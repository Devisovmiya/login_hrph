import 'package:flutter/material.dart';

ThemeData darkMode() {
  return ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: const Color.fromARGB(255, 141, 139, 143),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 51, 21, 65),
      foregroundColor: Color.fromARGB(255, 243, 231, 252),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color.fromARGB(255, 51, 21, 65),
      selectedItemColor: const Color.fromARGB(255, 227, 233, 231),
      unselectedItemColor: const Color.fromARGB(255, 133, 97, 173),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Color.fromARGB(255, 31, 25, 32)),
      
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      borderRadius: BorderRadius.circular(10),
      borderColor: const Color.fromARGB(255, 42, 54, 59),
    )
  );
}
