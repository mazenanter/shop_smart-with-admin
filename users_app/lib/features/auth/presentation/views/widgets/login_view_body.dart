import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app_firebase/core/error/error_dialog.dart';
import 'package:ecommerce_app_firebase/core/utils/main_page/main_page.dart';
import 'package:ecommerce_app_firebase/core/widgets/custom_app_title.dart';
import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/auth/data/repos/auth_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/manager/google_sign_in_cubit/google_sign_in_cubit.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/manager/login_user_cubit/login_user_cubit.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/forgot_password_view.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/register_view.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/connect_using_buttons_widget.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_login_text_form_field.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_sign_in_button.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  bool securePass = true;
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginUserCubit(AuthRepoImpl()),
      child: BlocConsumer<LoginUserCubit, LoginUserState>(
        listener: (context, state) async {
          if (state is LoginUserSuccess) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('IsLogined', true);
            Navigator.pushAndRemoveUntil(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
              (route) => false,
            );
            Fluttertoast.showToast(
                msg: 'Login success',
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is LoginUserError) {
            customErrorDialog(
              // ignore: use_build_context_synchronously
              context,
              state.errMsg,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
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
                            'Let\'s get you logged in so you can start exploring',
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomLoginTextFormField(
                        textInputAction: TextInputAction.next,
                        textEditingController: emailController,
                        focusNode: emailFocus,
                        label: 'email address',
                        prefIcon: IconlyLight.message,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomLoginTextFormField(
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (p0) {
                          FocusScope.of(context).requestFocus(passFocus);
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                          }
                        },
                        textEditingController: passwordController,
                        focusNode: passFocus,
                        onTapIcon: () {
                          setState(() {
                            securePass = !securePass;
                          });
                        },
                        obscureText: securePass,
                        label: 'password',
                        prefIcon: IconlyLight.password,
                        sufIcon: securePass
                            ? Icons.visibility_off
                            : Icons.remove_red_eye,
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: CustomTextButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordView(),
                              ),
                            );
                          },
                          fontStyle: FontStyle.italic,
                          textDecoration: TextDecoration.underline,
                          text: 'Forgot Password?',
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      ConditionalBuilder(
                        condition: state is LoginUserLoading,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        fallback: (context) => CustomSignInButton(
                          onTap: () async {
                            BlocProvider.of<LoginUserCubit>(context).loginUser(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                          icon: IconlyLight.login,
                          text: 'Sign in',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: SubTitleText(
                          label: 'OR CONNECT USING',
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: BlocProvider(
                              create: (context) =>
                                  GoogleSignInCubit(AuthRepoImpl()),
                              child: BlocConsumer<GoogleSignInCubit,
                                  GoogleSignInState>(
                                listener: (context, state) async {
                                  if (state is GoogleSignInSuccess) {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setBool('IsLogined', true);
                                    Fluttertoast.showToast(
                                        msg: 'google signed in success',
                                        timeInSecForIosWeb: 1,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    Navigator.pushAndRemoveUntil(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const MainPage(),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                  if (state is GoogleSignInError) {
                                    customErrorDialog(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      state.errMsg,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return ConnectUsingButtonsWidget(
                                    onTap: () {
                                      BlocProvider.of<GoogleSignInCubit>(
                                              context)
                                          .googleSignIn();
                                    },
                                    showIcon: true,
                                    title: 'Sign in with google',
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: ConnectUsingButtonsWidget(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MainPage(),
                                    ),
                                    (route) => false);
                              },
                              title: 'Guest ?',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SubTitleText(
                            label: 'Don\'t have an account?',
                          ),
                          CustomTextButton(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterView(),
                                ),
                              );
                            },
                            text: 'Sign up',
                          ),
                        ],
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
}
