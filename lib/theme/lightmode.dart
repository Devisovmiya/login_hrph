import 'package:flutter/material.dart';

ThemeData lightMode() {
  return ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color.fromARGB(255, 217, 222, 248),
        appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 178, 220, 255),
      foregroundColor: Color.fromARGB(255, 20, 19, 19),
      ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 178, 220, 255),
        selectedItemColor: const Color.fromARGB(255, 57, 61, 60),
        unselectedItemColor: const Color.fromARGB(255, 4, 115, 129),
        ),
        textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      borderRadius: BorderRadius.circular(10),
      borderColor: Colors.blueGrey,
    )

      );
        
}
