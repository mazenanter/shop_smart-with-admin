import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_login_text_form_field.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  var emailController = TextEditingController();
  FocusNode emailNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/forgot_password.jpg',
              height: MediaQuery.sizeOf(context).height * 0.38,
              width: double.infinity,
            ),
            const SizedBox(
              height: 20,
            ),
            const TextTitle(
              label: 'Forgot password',
            ),
            SubTitleText(
              label:
                  'please enter your email address you\'d like your password reset information send to',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomLoginTextFormField(
              label: 'youremail@gmail.com',
              prefIcon: IconlyLight.message,
              textEditingController: emailController,
              focusNode: emailNode,
            ),
            const SizedBox(
              height: 32,
            ),
            const CustomSignInButton(
              icon: IconlyBold.send,
              text: 'Request link',
            ),
          ],
        ),
      ),
    );
  }
}
