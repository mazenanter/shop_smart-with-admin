import 'package:admin_app/core/widgets/text_title.dart';
import 'package:flutter/material.dart';

Future<dynamic> customDialog(BuildContext context, void Function()? cameraPress,
    void Function()? galleryPress, void Function()? removePress) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextTitle(
              label: 'Choose option',
            ),
            TextButton.icon(
              onPressed: cameraPress,
              icon: const Icon(
                Icons.camera_outlined,
              ),
              label: const Text('Camera'),
            ),
            TextButton.icon(
              onPressed: galleryPress,
              icon: const Icon(
                Icons.image_outlined,
              ),
              label: const Text('Gallery'),
            ),
            TextButton.icon(
              onPressed: removePress,
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
              ),
              label: const Text(
                'Remove',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
