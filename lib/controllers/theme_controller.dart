import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/configs/themes/app_dark_theme.dart';
import 'package:mobile_app/configs/themes/app_light_theme.dart';

class ThemeController extends GetxController {
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;

  @override
  void onInit(){
    initializedThemeData();
    super.onInit();
  }

  void initializedThemeData() {
    _darkTheme = DarkTheme().buildDarkTheme();
    _lightTheme = LightTheme().buildLightTheme();
  }

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;
}