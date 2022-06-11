import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ibtikartask/shared/resourses/color_manager.dart';

import '../../generated/l10n.dart';
import '../../helper/open_file_services.dart';


class DownLoadFileDialog extends StatefulWidget {
  final File file;
  final String? url;

  const DownLoadFileDialog(this.file, this.url, {Key? key}) : super(key: key);

  @override
  _DownLoadFileDialogState createState() => _DownLoadFileDialogState();
}

class _DownLoadFileDialogState extends State<DownLoadFileDialog> {
  StreamController<double> controller = StreamController<double>();

  @override
  void initState() {
    _downloadFile();
    super.initState();
  }

  Future<void> _downloadFile() async {
    try {
      final response = await Dio()
          .download((widget.url??''), widget.file.path,
          onReceiveProgress: (rec, total) {
            double percentage = ((rec / total));
            if (mounted) controller.add(percentage);
          });
      if (response.statusCode != 200) {
        controller.addError(true); //   controller.addError('');

      }
    } catch (e) {
      controller.addError(true);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      child: StreamBuilder<double>(
        initialData: 0.0,
        stream: controller.stream,
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          return Container(
            width:  null,
            padding: const EdgeInsets.all(16),
            child: snapshot.error == true
                ? Text(
              S.of(context).canNotDownload,
              style: const TextStyle(color: Colors.green),
            )
                : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).pleaseWait,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularProgressIndicator(
                      value: snapshot.data!,
                      color: Colors.green,
                    ),
                    //    kSizedBoxWidth16px,
                    Text(
                      S.of(context).downloading +
                          '  ' +
                          (snapshot.data! * 100).toStringAsFixed(0) +
                          ' %',
                    ),
                  ],
                ),
                if (snapshot.data == 1.0)
                  Column(children: [
                    const Divider(),
                    TextButton(
                      onPressed: () async {
                        await OpenFileServices()
                            .downloadOrOpen(widget.url, context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.of(context).openFile,
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ]),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
