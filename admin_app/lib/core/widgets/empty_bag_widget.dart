import 'package:admin_app/core/widgets/sub_title_text.dart';
import 'package:admin_app/core/widgets/text_title.dart';
import 'package:flutter/material.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image, title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 16),
      child: Column(
        children: [
          Center(
            child: Image.asset(
              image,
              height: MediaQuery.sizeOf(context).height * 0.4,
            ),
          ),
          const TextTitle(
            label: 'Whoops!',
            fontSize: 30,
            color: Colors.red,
          ),
          const SizedBox(
            height: 20,
          ),
          TextTitle(
            label: title,
          ),
          const SizedBox(
            height: 10,
          ),
          SubTitleText(
            label: subTitle,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
