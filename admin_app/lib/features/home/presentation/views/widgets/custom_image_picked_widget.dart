import 'dart:io';

import 'package:admin_app/core/widgets/sub_title_text.dart';
import 'package:flutter/material.dart';

class CustomImagePickedWidget extends StatelessWidget {
  const CustomImagePickedWidget(
      {super.key, this.file, this.removePress, this.editPress});
  final File? file;
  final void Function()? removePress;
  final void Function()? editPress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            height: MediaQuery.sizeOf(context).height * 0.23,
            width: MediaQuery.sizeOf(context).height * 0.23,
            fit: BoxFit.cover,
            file!,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: removePress,
              child: const SubTitleText(
                label: 'Remove image',
                color: Colors.red,
              ),
            ),
            TextButton(
              onPressed: editPress,
              child: const SubTitleText(
                label: 'Edit image',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
