import 'package:flutter/material.dart';

ThemeData darkMode() {
  return ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Color.fromARGB(255, 104, 104, 177)),
    
    )
  ),
  hoverColor: const Color.fromARGB(255, 58, 64, 75),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.white,
  ),
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color.fromARGB(255, 44, 59, 73),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 22, 47, 83),
      foregroundColor: Color.fromARGB(255, 200, 200, 236),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color.fromARGB(255, 21, 39, 65),
      selectedItemColor: const Color.fromARGB(255, 180, 200, 245),
      unselectedItemColor: const Color.fromARGB(255, 46, 72, 97),
    ),
    dialogTheme: DialogThemeData(
      titleTextStyle: TextStyle(color: const Color.fromARGB(255, 7, 16, 66)),
    
    ),
    drawerTheme: DrawerThemeData(

      backgroundColor: const Color.fromARGB(255, 6, 26, 51),
    ),
    textTheme: const TextTheme(
      
      
      bodyMedium: TextStyle(color: Color.fromARGB(255, 215, 234, 255),),
      
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      borderRadius: BorderRadius.circular(10),
      borderColor: const Color.fromARGB(255, 42, 54, 59),
    )
  );
}
