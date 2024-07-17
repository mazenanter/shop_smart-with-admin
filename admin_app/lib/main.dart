import 'package:admin_app/core/utils/theme.dart';
import 'package:admin_app/core/utils/theme_cubit/theme_cubit.dart';
import 'package:admin_app/features/home/data/repos/dashboard_repo_impl.dart';
import 'package:admin_app/features/home/presentation/manager/add_product_cubit/add_product_cubit.dart';
import 'package:admin_app/features/home/presentation/views/dashboard_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit()..getTheme(),
        ),
        BlocProvider(
          create: (context) => AddProductCubit(DashboardRepoImpl()),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'admin app',
            theme: AppTheme.themeData(
              isDark: BlocProvider.of<ThemeCubit>(context).getIsDark,
              context: context,
            ),
            home: const DashboardView(),
          );
        },
      ),
    );
  }
}
