import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  static const THEMEKEY = 'THEMEKEY';
  bool isDark = false;
  bool get getIsDarkTheme => isDark;
  setDark(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEMEKEY, value);
    isDark = value;
    emit(ThemeChange());
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool(THEMEKEY) ?? false;
    emit(ThemeChange());
    return isDark;
  }
}
