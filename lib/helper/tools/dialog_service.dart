import 'package:flutter/material.dart';
import 'package:ibtikartask/shared/resourses/color_manager.dart';



enum BasicDialogStatus { success, error, warning }

class DialogService {
  static Future<dynamic> showBasicDialog({
    required BuildContext context,
    required BasicDialogStatus dialogStatus,
    bool doSomething = false,
    Function()? acceptFunction,
    String? title,
    String? description,
    String? acceptButtonTitle,
    String? secondaryButtonTitle,
    bool isDismissible = true,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: _BasicDialogContent(
          dialogStatus: dialogStatus,
          title: title,
          description: description,
          acceptButtonTitle: acceptButtonTitle,
          secondaryButtonTitle: secondaryButtonTitle,
          doSomething: doSomething,
          acceptFunction: acceptFunction,
        ),
      ),
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String title,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
  }
}
class _BasicDialogContent extends StatelessWidget {
  final BasicDialogStatus dialogStatus;
  final String? title;
  final String? description;
  final String? acceptButtonTitle;
  final String? secondaryButtonTitle;
  final bool? doSomething;
  final Function()? acceptFunction;

  const _BasicDialogContent({
    required this.dialogStatus,
    this.title,
    this.description,
    this.acceptButtonTitle,
    this.secondaryButtonTitle,
    this.doSomething,
    this.acceptFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
          ),
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...[
                const SizedBox(height: 10),
                Text(
                  title?.toUpperCase() ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
              if (description != null) ...[
                const SizedBox(height: 10),
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
              const SizedBox(height: 20),
              const Divider(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (secondaryButtonTitle != null) ...[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        secondaryButtonTitle?.toUpperCase() ?? '',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                      child: VerticalDivider(),
                    ),
                  ],
                  TextButton(
                    onPressed: (doSomething ?? false)
                        ? acceptFunction!()
                        : () => Navigator.of(context).pop(true),
                    child: Text(
                      acceptButtonTitle?.toUpperCase() ?? '',
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: -28,
          child: CircleAvatar(
            minRadius: 16,
            maxRadius: 28,
            backgroundColor: _getStatusColor(dialogStatus),
            child: Icon(
              _getStatusIcon(dialogStatus),
              size: 28,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Color _getStatusColor(BasicDialogStatus dialogStatus) {
    switch (dialogStatus) {
      case BasicDialogStatus.error:
        return ColorManager.error;
      case BasicDialogStatus.warning:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  IconData _getStatusIcon(BasicDialogStatus dialogStatus) {
    switch (dialogStatus) {
      case BasicDialogStatus.error:
        return Icons.error_outline;
      case BasicDialogStatus.warning:
        return Icons.warning_amber_rounded;
      default:
        return Icons.check;
    }
  }
}
