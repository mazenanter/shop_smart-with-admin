import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.maxLine = 1,
    this.maxLength,
    this.prefix,
    required this.title,
    this.keyboardType,
    this.textController,
  });
  final int maxLine;
  final int? maxLength;
  final Widget? prefix;
  final String title;
  final TextInputType? keyboardType;
  final TextEditingController? textController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefix: prefix,
        filled: true,
        hintText: title,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              12,
            ),
          ),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
