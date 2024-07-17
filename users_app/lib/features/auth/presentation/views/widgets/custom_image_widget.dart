import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.17,
            width: MediaQuery.sizeOf(context).width * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
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
