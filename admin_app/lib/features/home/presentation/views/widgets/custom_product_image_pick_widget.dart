import 'package:admin_app/core/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class CusgtomProductImagePickWidget extends StatelessWidget {
  const CusgtomProductImagePickWidget({
    super.key,
    this.cameraPress,
    this.galleryPress,
    this.removePress,
  });
  final void Function()? cameraPress;
  final void Function()? galleryPress;
  final void Function()? removePress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.23,
        width: MediaQuery.sizeOf(context).height * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                customDialog(
                  context,
                  cameraPress,
                  galleryPress,
                  removePress,
                );
              },
              icon: const Icon(
                Icons.image_outlined,
                size: 100,
                color: Colors.blue,
              ),
            ),
            const Text(
              'Pick product image',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
