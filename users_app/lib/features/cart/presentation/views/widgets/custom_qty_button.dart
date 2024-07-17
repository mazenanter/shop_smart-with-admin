import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CustomQuantityButton extends StatelessWidget {
  const CustomQuantityButton({
    super.key,
    required this.qty,
  });
  final String qty;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          context: context,
          builder: (context) {
            return SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      height: 6,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Center(child: TextTitle(label: '${index + 1}')),
                          ),
                        ),
                        itemCount: 25,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(IconlyLight.arrowDown2),
      label: Text("Qty: $qty"),
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        side: const BorderSide(width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
