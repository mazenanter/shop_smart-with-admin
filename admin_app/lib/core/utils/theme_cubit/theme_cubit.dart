import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  static const THEMEKEY = 'THEMEKEY';
  bool isDark = false;
  bool get getIsDark => isDark;

  setDark({required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(
      THEMEKEY,
      value,
    );
    isDark = value;

    emit(ChangeTheme());
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool(THEMEKEY) ?? false;
    emit(ChangeTheme());

    return isDark;
  }

  IconData icon = Icons.bedtime;
  changeIcon() {
    isDark ? icon = Icons.bedtime : icon = Icons.light_mode;
    emit(ChangeIcon());
  }
}
