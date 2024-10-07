import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}

class AppThemes {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 242, 117, 8),
      brightness: Brightness.light,
      primary: const Color.fromARGB(255, 242, 117, 8),
      onPrimary: Colors.white,
      secondary: const Color.fromARGB(255, 7, 255, 44),
      onSecondary: Colors.black,
    ),
    useMaterial3: true,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color.fromARGB(255, 7, 255, 44),
      unselectedItemColor: Colors.grey,
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 242, 117, 8),
      brightness: Brightness.dark,
      primary: Colors.blueGrey,
      onPrimary: Colors.white,
      secondary: Colors.teal,
      onSecondary: Colors.black,
    ),
    useMaterial3: true,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color.fromARGB(255, 7, 255, 44),
      unselectedItemColor: Colors.grey,
    ),
  );

  static final blueTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
      primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: Colors.lightBlueAccent,
      onSecondary: Colors.black,
    ),
    useMaterial3: true,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.blueGrey,
    ),
  );

  static final pinkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.pink,
      brightness: Brightness.light,
      primary: Colors.pink,
      onPrimary: Colors.white,
      secondary: Colors.pinkAccent,
      onSecondary: Colors.black,
    ),
    useMaterial3: true,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.pink.shade200,
    ),
  );
}
