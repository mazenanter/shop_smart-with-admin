import 'package:admin_app/core/widgets/text_title.dart';
import 'package:admin_app/features/home/presentation/views/widgets/inspect_all_product_view_body.dart';
import 'package:flutter/material.dart';

class InspectAllProductView extends StatelessWidget {
  const InspectAllProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Image.asset(
                height: 40,
                'assets/images/bag/shopping_cart.png',
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const TextTitle(
              label: 'Store product',
            ),
          ],
        ),
      ),
      body: const InspectAllProductsViewBody(),
    );
  }
}
