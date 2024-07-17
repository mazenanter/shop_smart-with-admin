import 'package:ecommerce_app_firebase/core/utils/main_page/main_page.dart';
import 'package:ecommerce_app_firebase/core/utils/theme_cubit/theme_cubit.dart';
import 'package:ecommerce_app_firebase/core/utils/theme_style.dart';
import 'package:ecommerce_app_firebase/features/auth/presentation/views/login_view.dart';
import 'package:ecommerce_app_firebase/features/cart/data/repos/cart_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/cart/presentation/manager/remove_all_items_from_cart_cubit/remove_all_items_from_cart_cubit.dart';
import 'package:ecommerce_app_firebase/features/search/data/repos/search_repo_impl.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/manager/add_product_to_cart_cubit/add_product_to_cart_cubit.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/manager/add_product_to_wishlist_cubit/add_product_to_wishlist_cubit.dart';
import 'package:ecommerce_app_firebase/features/search/presentation/manager/search_product_cubit/search_product_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  Widget? startWidget;
  final bool? isLogined = prefs.getBool('IsLogined');
  if (isLogined != null && isLogined) {
    startWidget = const MainPage();
  } else {
    startWidget = const LoginView();
  }
  runApp(MyApp(
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit()..getTheme(),
        ),
        BlocProvider(
          create: (context) => AddProductToCartCubit(SearchRepoImpl()),
        ),
        BlocProvider(
          create: (context) => AddProductToWishlistCubit(SearchRepoImpl()),
        ),
        BlocProvider(create: (context) => SearchProductCubit(SearchRepoImpl())),
        BlocProvider(
            create: (context) => RemoveAllItemsFromCartCubit(CartRepoImpl())),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shop App',
            theme: ThemeStyle.themeData(
                isDark: BlocProvider.of<ThemeCubit>(context).getIsDarkTheme,
                context: context),
            home: startWidget,
          );
        },
      ),
    );
  }
}
