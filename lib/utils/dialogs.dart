// Flutter imports:
import 'package:flutter/material.dart';

import 'utils.dart';

class Dialogs {
  static bool open = false;

  static Future<Future<T?>> show<T extends Object>(
    BuildContext context,
    Widget dialog,
  ) async =>
      showDialog<T>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return dialog;
        },
      );

  static Future showModal<T extends Object>(
      BuildContext context, Widget dialog) async {
    if (!open) {
      open = true;
      return show<T>(context, dialog);
    }
  }

  static Future showUnmodal<T extends Object>(
      BuildContext context, Widget dialog) async {
    return show<T>(context, dialog);
  }

  static void hide(BuildContext context) {
    if (open) {
      Navigator.of(context, rootNavigator: true).pop();
      open = false;
    }
  }

  static Future shonMessage(BuildContext context, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                backgroundColor: AppColors.widgetsBackground,
                title: const Text(
                  'Уведомление',
                  style: AppTypography.font16lightGray,
                ),
                content: Text(
                  message,
                  style: AppTypography.font16description,
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Ок'),
                    onPressed: () => Navigator.pop(context),
                  )
                ]));
  }
}
