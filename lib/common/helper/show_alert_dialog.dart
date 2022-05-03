import 'package:flutter/material.dart';
import 'package:whatsapp_chat_app/common/extensions/custom_theme_extension.dart';

showAlertDialog({required BuildContext context, required String message, String? btnText}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          message,
          style: TextStyle(color: context.theme.greyColor, fontSize: 15),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
            ),
            child: Text(
              btnText ?? 'OK',
              style: TextStyle(
                color: context.theme.circleImageColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
