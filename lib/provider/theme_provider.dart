import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  String currentTheme = 'system';

  ThemeMode get themeMode {
    if(currentTheme == 'light'){
      return ThemeMode.light;
    }
    else if (currentTheme == 'dark')
      {
        return ThemeMode.dark;
      }
    else
      {
        return ThemeMode.system;
      }
  }


  changeTheme(String theme) async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    _pref.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }

  initialize() async{
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    currentTheme = _pref.getString('theme')??'system';
    notifyListeners();
  }
}