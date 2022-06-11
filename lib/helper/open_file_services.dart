import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ibtikartask/helper/tools/dialog_service.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../generated/l10n.dart';
import '../shared/widgets/download_file_dialog.dart';

class OpenFileServices {
  Future<void> downloadOrOpen(String? _url, BuildContext ctx) async {
    try {
      final dirPath = await _createDir();
      final fileName = _getFileName(_url);

      final _file = File(dirPath.path + '/' + (fileName ?? ''));
      if (await _file.exists()) {
        await _openUpFile(_file, ctx);
      } else {
        await _downLoadFile(_file, _url, ctx);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Directory> _createDir() async {
    var _dir = await getApplicationDocumentsDirectory();
    const folderName = 'ibtikar';
    final _path = Directory('${_dir.path}/$folderName');
    if ((await _path.exists())) {
      return _path;
    } else {
      await _path.create();
      return _path;
    }
  }

  String? _getFileName(String? _url) {
    final _filePath = _url?.split('/').last;
    return _filePath;
  }

  Future<void> _openUpFile(File _file, BuildContext ctx) async {
    final _result = await OpenFile.open(_file.path);
    if (_result.message != 'done') {
      return DialogService.showBasicDialog(
          context: ctx,
          dialogStatus: BasicDialogStatus.warning,
          description: _result.message,
          acceptButtonTitle: S.of(ctx).done);
    }
  }

  Future<void> _downLoadFile(File _file, String? url, BuildContext ctx) async {
    await showDialog(
      context: ctx,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return DownLoadFileDialog(_file, url);
      },
    );
  }


  Future<FilePickerResult?> pickFile() async {
    FilePickerResult? _result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    return _result;
  }
}

