import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app_firebase/core/error/error_dialog.dart';
import 'package:ecommerce_app_firebase/core/widgets/custom_app_title.dart';
import 'package:ecommerce_app_firebase/core/widgets/image_picker.dart';
import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/manager/register_user_cubit/register_user_cubit.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_image_dialog.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_image_picked_widget.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_image_widget.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_login_text_form_field.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passController = TextEditingController();
  var repPassController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode repPassFocusNode = FocusNode();
  bool securePassword = true;
  var formKey = GlobalKey<FormState>();
  File? image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterUserCubit(AuthRepoImpl()),
      child: BlocConsumer<RegisterUserCubit, RegisterUserState>(
        listener: (context, state) {
          if (state is RegisterUserSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ),
              (route) => false,
            );
            Fluttertoast.showToast(
                msg: 'Email created successfully,now login',
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is RegisterUserError) {
            customErrorDialog(context, state.errMsg);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppTitle(),
                      const SizedBox(
                        height: 20,
                      ),
                      const TextTitle(
                        label: 'Welcome Back',
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                      ),
                      SubTitleText(
                        label:
                            'Sign up now to recieve special offers and updates from our app',
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      customConditionImageWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomLoginTextFormField(
                        textInputAction: TextInputAction.next,
                        label: 'user123',
                        prefIcon: IconlyLight.profile,
                        textEditingController: nameController,
                        focusNode: nameFocusNode,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomLoginTextFormField(
                        textInputAction: TextInputAction.next,
                        label: 'youremail@gmail.com',
                        prefIcon: IconlyLight.message,
                        textEditingController: emailController,
                        focusNode: emailFocusNode,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomLoginTextFormField(
                        textInputAction: TextInputAction.next,
                        obscureText: securePassword,
                        label: 'password',
                        prefIcon: IconlyLight.password,
                        textEditingController: passController,
                        focusNode: passFocusNode,
                        sufIcon: securePassword
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_outlined,
                        onTapIcon: () {
                          setState(() {
                            securePassword = !securePassword;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomLoginTextFormField(
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (p0) {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context)
                                .requestFocus(repPassFocusNode);
                            FocusScope.of(context).unfocus();
                          }
                        },
                        label: 'repeat password',
                        obscureText: securePassword,
                        prefIcon: IconlyLight.password,
                        textEditingController: repPassController,
                        focusNode: repPassFocusNode,
                        sufIcon: securePassword
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_outlined,
                        onTapIcon: () {
                          setState(() {
                            securePassword = !securePassword;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ConditionalBuilder(
                        condition: state is RegisterUserLoading,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        fallback: (context) => CustomSignInButton(
                          onTap: () {
                            if (image == null) {
                              customErrorDialog(
                                context,
                                'image is required',
                              );
                            } else {
                              BlocProvider.of<RegisterUserCubit>(context)
                                  .registerUser(
                                pickedImage: image!,
                                image: image.toString(),
                                userCart: [],
                                wishlist: [],
                                timestamp: Timestamp.now(),
                                name: nameController.text,
                                email: emailController.text,
                                password: passController.text,
                              );
                            }
                          },
                          icon: IconlyLight.login,
                          text: 'Sign up',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ConditionalBuilder customConditionImageWidget() {
    return ConditionalBuilder(
      condition: image == null,
      builder: (context) => CustomImageWidget(
        onTap: () {
          customImageDialog(
            context: context,
            cameraPressed: () async {
              image =
                  await ImagePickerService.pickImageFromCamera(image: image);
              setState(() {});
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            galleryPressed: () async {
              image =
                  await ImagePickerService.pickImageFromGallery(image: image);
              setState(() {});
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
            removePressed: () {
              image = null;
              Navigator.pop(context);
              setState(() {});
            },
          );
        },
      ),
      fallback: (context) => CustomImagePickedWidget(
        file: image,
        onTap: () {
          customImageDialog(
            context: context,
            cameraPressed: () async {
              image =
                  await ImagePickerService.pickImageFromCamera(image: image);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              setState(() {});
            },
            galleryPressed: () async {
              image =
                  await ImagePickerService.pickImageFromGallery(image: image);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              setState(() {});
            },
            removePressed: () {
              image = null;
              Navigator.pop(context);
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
