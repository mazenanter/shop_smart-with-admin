import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    this.onChanged,
    this.onPressX,
  });
  final Function(String)? onChanged;
  final void Function()? onPressX;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        label: const Text(
          'Search',
        ),
        prefixIcon: const Icon(
          IconlyLight.search,
        ),
        suffixIcon: IconButton(
          onPressed: onPressX,
          icon: const Icon(
            Icons.clear,
            color: Colors.red,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
    );
  }
}
