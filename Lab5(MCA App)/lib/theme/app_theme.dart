import 'package:flutter/material.dart';

// Using 60-30-10 color rule
// 60% - Primary color (background, major elements)
// 30% - Secondary color (headers, important UI elements)
// 10% - Accent color (call to action, highlights)

class AppTheme {
  // Primary color - Navy blue (from SPIT website)
  static const Color primaryColor =  Color.fromARGB(255, 67, 16, 82);
  
  // Secondary color - Light blue
  static const Color secondaryColor = Color(0xFF3D5A80);
  
  // Accent color - Orange (from SPIT website)
  static const Color accentColor = Color.fromARGB(255, 245, 120, 207);
  
  // Background colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  
  // Text colors
  static const Color textPrimaryColor = Color(0xFF333333);
  static const Color textSecondaryColor = Color(0xFF666666);
  
  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: const CardTheme(
      color: cardColor,
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headlineMedium: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      titleLarge: TextStyle(
        color: textPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleMedium: TextStyle(
        color: textPrimaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      bodyLarge: TextStyle(
        color: textPrimaryColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: textSecondaryColor,
        fontSize: 14,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: accentColor,
    ),
  );
}

