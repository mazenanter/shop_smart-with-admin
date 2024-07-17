import 'package:admin_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTheme {
  static ThemeData themeData(
      {required bool isDark, required BuildContext context}) {
    return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: isDark ? AppColors.darkCardColor : Colors.white,
      )),
      buttonTheme: ButtonThemeData(
        buttonColor: isDark ? Theme.of(context).cardColor : Colors.white,
      ),
      scaffoldBackgroundColor:
          isDark ? AppColors.darkScaffoldColor : AppColors.lightScaffoldColor,
      cardColor: isDark ? AppColors.darkCardColor : AppColors.lightCardColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? AppColors.darkScaffoldColor : AppColors.lightScaffoldColor,
      ),
    );
  }
}
