import 'package:flutter/material.dart';

class CustomLoginTextFormField extends StatelessWidget {
  const CustomLoginTextFormField({
    super.key,
    required this.label,
    required this.prefIcon,
    this.sufIcon,
    this.obscureText = false,
    this.onTapIcon,
    required this.textEditingController,
    required this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
  });
  final String label;
  final IconData prefIcon;
  final IconData? sufIcon;
  final bool obscureText;
  final void Function()? onTapIcon;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      textInputAction: textInputAction,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Must not be empty';
        }
        return null;
      },
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        filled: true,
        hintText: label,
        prefixIcon: Icon(prefIcon),
        suffixIcon: IconButton(
          onPressed: onTapIcon,
          icon: Icon(sufIcon),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
      ),
    );
  }
}
