import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:flutter/material.dart';

Future<dynamic> customDialog(
  BuildContext context,
  void Function()? onTap,
  String title,
) {
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
              label: 'Cancel',
              color: Colors.blue,
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: const SubTitleText(
              label: 'Confirm',
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
              'assets/images/warning.png',
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
