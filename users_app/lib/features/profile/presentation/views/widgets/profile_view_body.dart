import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app_firebase/core/utils/theme_cubit/theme_cubit.dart';
import 'package:ecommerce_app_firebase/core/widgets/custom_dialog.dart';
import 'package:ecommerce_app_firebase/core/widgets/sub_title_text.dart';
import 'package:ecommerce_app_firebase/core/widgets/text_title.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce_app_firebase/features/profile/data/repos/profile_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/manager/fetch_user_cubit/fetch_user_cubit.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/views/orders_view.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/views/viewed_recently_view.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/views/widgets/custom_button.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/views/widgets/custom_list_tile.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/views/widgets/custom_profile_info.dart';
import 'package:ecommerce_app_firebase/features/profile/presentation/views/wishlist_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    User? user = FirebaseAuth.instance.currentUser;
    var sizeHeight = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (context) => FetchUserCubit(ProfileRepoImpl())..fetchUserInfo(),
      child: BlocConsumer<FetchUserCubit, FetchUserState>(
        listener: (context, state) {
          if (state is FetchUserError) {
            log('Error ${state.errMsg}');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  if (BlocProvider.of<FetchUserCubit>(context).userModel ==
                          null &&
                      state is! FetchUserLoading)
                    const TextTitle(
                      label: 'Login to save your details, and access your info',
                      maxLines: 2,
                    ),
                  ConditionalBuilder(
                    condition: state is FetchUserSuccess,
                    builder: (context) {
                      if (state is FetchUserSuccess) {
                        return CustomProfileInfo(
                          userModel: state.userModel,
                        );
                      }
                      return const Center(
                          child: Text(
                        'NO RESULT',
                      ));
                    },
                    fallback: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SubTitleText(
                    label: 'General',
                    fontWeight: FontWeight.bold,
                  ),
                  CustomListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrdersView(),
                        ),
                      );
                    },
                    sizeHeight: sizeHeight,
                    image: 'assets/images/bag/order_svg.png',
                    text: 'All order',
                  ),
                  CustomListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WishlistView(),
                        ),
                      );
                    },
                    sizeHeight: sizeHeight,
                    image: 'assets/images/bag/wishlist_svg.png',
                    text: 'Wishlist',
                  ),
                  CustomListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewedRecentlyView(),
                        ),
                      );
                    },
                    sizeHeight: sizeHeight,
                    image: 'assets/images/profile/recent.png',
                    text: 'Viewed recently',
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SubTitleText(
                    label: 'Setting',
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customSwitchWidget(sizeHeight, context),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomProfileButton(
                    title: user == null ? 'Login' : 'Logout',
                    icon: user == null ? Icons.login : Icons.logout,
                    sizeHeight: sizeHeight,
                    onTap: () {
                      if (user == null) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                          (route) => false,
                        );
                      } else {
                        customDialog(
                          context,
                          () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.remove('IsLogined');
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                              (route) => false,
                            );
                          },
                          'Are you sure to logout',
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding customSwitchWidget(double sizeHeight, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Image.asset(
            'assets/images/profile/theme.png',
            height: sizeHeight * 0.05,
          ),
          const SizedBox(
            width: 15,
          ),
          SubTitleText(
            label: BlocProvider.of<ThemeCubit>(context).isDark
                ? 'Dark mode'
                : 'Light mode',
            fontSize: 16,
          ),
          const Spacer(),
          Switch(
              value: BlocProvider.of<ThemeCubit>(context).isDark,
              onChanged: (value) {
                BlocProvider.of<ThemeCubit>(context).setDark(value);
                setState(() {});
                log('Theme Is : ${BlocProvider.of<ThemeCubit>(context).getIsDarkTheme}');
              }),
        ],
      ),
    );
  }
}
