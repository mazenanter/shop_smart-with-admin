import 'package:admin_app/core/widgets/text_title.dart';
import 'package:admin_app/features/home/presentation/views/widgets/orders_view_body.dart';
import 'package:flutter/material.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

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
          ),
        ),
        title: const TextTitle(label: 'Placed orders'),
      ),
      body: const OrdersViewBody(),
    );
  }
}
