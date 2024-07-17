import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';

class CustomImagePickedWidget extends StatelessWidget {
  const CustomImagePickedWidget({super.key, this.onTap, this.file});
  final void Function()? onTap;

  final File? file;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              height: MediaQuery.sizeOf(context).height * 0.17,
              width: MediaQuery.sizeOf(context).width * 0.35,
              fit: BoxFit.cover,
              file!,
            ),
          ),
          Positioned(
            bottom: 95,
            left: 105,
            child: Material(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(16),
              child: IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Ionicons.camera_sharp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
