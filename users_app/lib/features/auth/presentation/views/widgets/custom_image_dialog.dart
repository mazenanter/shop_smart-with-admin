import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

Future<dynamic> customImageDialog(
    {required BuildContext context,
    void Function()? cameraPressed,
    void Function()? galleryPressed,
    void Function()? removePressed}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Center(
          child: TextTitle(
            label: 'Choose option',
            fontWeight: FontWeight.bold,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              onPressed: cameraPressed,
              icon: const Icon(Icons.camera),
              label: const Text('Camera'),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton.icon(
              onPressed: galleryPressed,
              icon: const Icon(Icons.photo),
              label: const Text('Gallery'),
            ),
            const SizedBox(
              height: 5,
            ),
            TextButton.icon(
              onPressed: removePressed,
              icon: const Icon(
                Ionicons.remove_circle,
                color: Colors.red,
              ),
              label: const Text('Remove'),
            ),
          ],
        ),
      );
    },
  );
}
