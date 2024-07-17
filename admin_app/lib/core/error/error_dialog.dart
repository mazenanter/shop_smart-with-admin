import 'package:admin_app/core/widgets/sub_title_text.dart';
import 'package:flutter/material.dart';

Future<dynamic> customErrorDialog(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const SubTitleText(
              label: 'Ok',
              color: Colors.red,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              height: 80,
              width: 80,
              'assets/images/error.png',
            ),
            const SizedBox(
              height: 20,
            ),
            SubTitleText(
              label: title,
            ),
          ],
        ),
      );
    },
  );
}
