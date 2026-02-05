import 'package:flutter/material.dart';

class AppTheme {
  // ---------------------------------------------------------------------------
  // Color Palette - Premium & appetizing
  // ---------------------------------------------------------------------------
  static const Color primaryColor = Color(0xFFFF5722); // Deep Orange
  static const Color primaryVariant = Color(0xFFE64A19); // Darker Orange
  static const Color secondaryColor = Color(0xFFFFCC80); // Soft Orange Accent
  static const Color accentColor = Color(0xFFFFAB91); // Light Salmon

  static const Color backgroundColor = Colors.white;
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFD32F2F);

  // Text Colors
  static const Color textColor = Color(0xFF2D3436); // Soft Black
  static const Color subtitleColor = Color(0xFF636E72); // Slate Gray
  static const Color textOnPrimary = Colors.white;

  // ---------------------------------------------------------------------------
  // Typography
  // ---------------------------------------------------------------------------
  static const TextStyle displayLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
    letterSpacing: -0.5,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textColor,
    letterSpacing: 0.15,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: textColor,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: subtitleColor,
    height: 1.4,
  );

  // ---------------------------------------------------------------------------
  // Component Styles
  // ---------------------------------------------------------------------------

  // Input Decoration - Global Theme
  static InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      labelStyle: TextStyle(color: subtitleColor),
      hintStyle: TextStyle(color: subtitleColor.withOpacity(0.5)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: errorColor),
      ),
    );
  }

  // Button Style - Global Theme
  static ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: primaryButtonStyle,
    );
  }

  static ButtonStyle get primaryButtonStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: textOnPrimary,
      elevation: 4,
      shadowColor: primaryColor.withOpacity(0.4),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  // Card Theme
  static CardThemeData get cardTheme {
    return CardThemeData(
      color: surfaceColor,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.all(8),
    );
  }

  // ---------------------------------------------------------------------------
  // Main Theme Data
  // ---------------------------------------------------------------------------
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: surfaceColor,
      brightness: Brightness.light,
      
      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: textOnPrimary,
        onSecondary: textColor,
        onSurface: textColor,
        onBackground: textColor,
        onError: Colors.white,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: displayLarge,
        titleLarge: titleLarge,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
      ),

      // Component Themes
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
        titleTextStyle: titleLarge,
      ),
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      cardTheme: cardTheme,
      
      // General Visuals
      dividerColor: Colors.grey.shade200,
      fontFamily: 'Roboto',
    );
  }

  static ThemeData get darkThemeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Color(0xFF121212),
      cardColor: Color(0xFF1E1E1E),
      brightness: Brightness.dark,
      
      // Color Scheme
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Color(0xFF1E1E1E),
        background: Color(0xFF121212),
        error: Color(0xFFCF6679),
        onPrimary: textOnPrimary,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.black,
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: displayLarge.copyWith(color: Colors.white),
        titleLarge: titleLarge.copyWith(color: Colors.white),
        bodyLarge: bodyLarge.copyWith(color: Colors.white70),
        bodyMedium: bodyMedium.copyWith(color: Colors.white60),
      ),

      // Component Themes
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF121212),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: titleLarge.copyWith(color: Colors.white),
      ),
      inputDecorationTheme: inputDecorationTheme.copyWith(
        fillColor: Color(0xFF1E1E1E),
        labelStyle: TextStyle(color: Colors.white60),
        hintStyle: TextStyle(color: Colors.white38),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white24),
        ),
      ),
      elevatedButtonTheme: elevatedButtonTheme,
      cardTheme: cardTheme.copyWith(
        color: Color(0xFF1E1E1E),
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      
      // General Visuals
      dividerColor: Colors.white24,
      fontFamily: 'Roboto',
    );
  }

  // Helper for custom inputs if needed (legacy support, but improved)
  static InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: primaryColor),
    ); // Theme will handle the rest
  }
}
