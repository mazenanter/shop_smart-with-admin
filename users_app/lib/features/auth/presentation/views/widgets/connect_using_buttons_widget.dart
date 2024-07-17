import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ConnectUsingButtonsWidget extends StatelessWidget {
  const ConnectUsingButtonsWidget({
    super.key,
    required this.title,
    this.showIcon = false,
    this.onTap,
  });
  final String title;
  final bool showIcon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          Visibility(
            visible: showIcon,
            child: const Icon(
              Ionicons.logo_google,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
            ),
          ),
        ],
      ),
    );
  }
}
