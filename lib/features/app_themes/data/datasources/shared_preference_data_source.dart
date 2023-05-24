import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedProferenceDataSource {
  ThemeData getLightThemeData();
  ThemeData getDarkThemeData();
}

class SharedProferenceDataSourceImp implements SharedProferenceDataSource {
  final SharedPreferences sharedPreferences;

  SharedProferenceDataSourceImp({required this.sharedPreferences});

  @override
  ThemeData getDarkThemeData() {
    // TODO: implement getDarkThemeData
    throw UnimplementedError();
  }

  @override
  ThemeData getLightThemeData() {
    // TODO: implement getLightThemeData
    throw UnimplementedError();
  }
}
