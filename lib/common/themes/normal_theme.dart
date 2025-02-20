import 'dart:io';

import 'package:flutter/material.dart';

class NormalTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: Platform.isIOS ? '.SF Pro Display' : 'Roboto',
    primarySwatch: Colors.blue, // Primary color
    scaffoldBackgroundColor: Colors.white, // Background color of scaffolds
    appBarTheme: const AppBarTheme( // Theme for app bars
      backgroundColor: Colors.blue, // App bar background color
      titleTextStyle: TextStyle( // App bar title text style
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData( // App bar icons
        color: Colors.white,
      ),
    ),
    
    textTheme: const TextTheme( // Text styles
      headlineSmall: TextStyle( // Example text style
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: TextStyle( // Another example
        fontSize: 16,
        color: Colors.black87,
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData( // Theme for elevated buttons
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Button background color
        textStyle: const TextStyle( // Button text style
          color: Colors.white,
        ),
      ),
    ),

   
    // ... other theme properties (e.g., colorScheme, inputDecorationTheme, etc.)
  );


  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.indigo,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        textStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}