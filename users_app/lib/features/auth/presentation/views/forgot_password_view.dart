import 'package:ecommerce_app_firebase/core/widgets/custom_app_title.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/forgot_password_view_body.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: const CustomAppTitle(),
        centerTitle: true,
      ),
      body: const ForgotPasswordViewBody(),
    );
  }
}
