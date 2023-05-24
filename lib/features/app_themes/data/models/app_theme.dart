import 'dart:developer';

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  late ThemeMode _themeMode;
  ThemeProvider(this._themeMode) {
    // _loadDarkPreference();
  }

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  ThemeMode get themeMode {
    return _themeMode;
  }

  void switchDarkMode(bool switchValue) {
    log('changed');
    _themeMode = switchValue ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
  static ThemeData appThemeLight() {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.blueGrey,
        opacity: 0.8,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 18,
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: MaterialStateProperty.all(true),
        trackVisibility: MaterialStateProperty.all(true),
        thumbColor: MaterialStateProperty.all(Colors.grey),
      ),
      cardTheme: CardTheme(
        color: Colors.blueGrey,
        shadowColor: Colors.black26,
        elevation: 3,
        margin: const EdgeInsets.all(16),
        // surfaceTintColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      dividerColor: Colors.black54,
      colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.blue,
          background: const Color.fromARGB(255, 187, 212, 228)),
    );
  }

  static ThemeData appThemeDark() {
    return ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.grey.shade900,
      iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 18,
          color: Colors.amberAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: MaterialStateProperty.all(true),
        trackVisibility: MaterialStateProperty.all(true),
        thumbColor: MaterialStateProperty.all(Colors.grey),
      ),
      cardTheme: CardTheme(
        color: Colors.grey.shade800,
        shadowColor: Colors.white24,
        elevation: 3,
        margin: const EdgeInsets.all(16),
        // surfaceTintColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      dividerColor: Colors.white54,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Colors.blue,
        secondary: Colors.deepPurple,
        background: Colors.black54,
      ),
    );
  }
}
