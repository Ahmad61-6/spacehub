import 'package:flutter/material.dart';
import 'package:spacehub/view/utility/app_colors.dart';

class AppTheme {
  ThemeData appThemeData = ThemeData(
    scaffoldBackgroundColor: AppColors.appBackground,
    fontFamily: 'FiraSans',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.buttonColor,
        padding: EdgeInsets.symmetric(vertical: 15),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.withValues(alpha: .07),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.buttonColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.buttonColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.buttonColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red),
      ),
      hintStyle: TextStyle(color: Colors.grey.shade400),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    ),
  );
}
