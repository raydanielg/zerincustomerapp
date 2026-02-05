import 'package:flutter/material.dart';
import 'package:ride_sharing_user_app/core/theme/custom_theme_color.dart';
import 'package:ride_sharing_user_app/core/constants/app_constants.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: AppConstants.fontFamily,
  primaryColor: const Color(0xFFF47C20),
  primaryColorDark: const Color(0xFFDC6C1A),
  disabledColor: const Color(0xFFBABFC4),
  scaffoldBackgroundColor: const Color(0xFF0B0F19),
  canvasColor: const Color(0xFF0F172A),
  shadowColor: Colors.white.withValues(alpha:0.03),
  brightness: Brightness.dark,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: const Color(0xFF242424),
  textTheme:  const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Color(0xffd5e1e0)),
    bodyLarge: TextStyle(color: Color(0xffffffff)),
    titleMedium: TextStyle(color: Color(0xff1D2D2B)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0F172A),
    foregroundColor: Color(0xFFF9FAFB),
    elevation: 0,
    centerTitle: true,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF47C20),
      foregroundColor: const Color(0xFF111827),
      disabledBackgroundColor: const Color(0xFF334155),
      disabledForegroundColor: const Color(0xFFCBD5E1),
      minimumSize: const Size(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(fontWeight: FontWeight.w700),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF111827),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFF334155)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFF334155)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFF47C20), width: 1.5),
    ),
  ),

  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFF47C20),
    error: Color(0xFFFF6767),
    surface: Color(0xFFF3F3F3),
    secondary: Color(0xFF0F172A),
    tertiary: Color(0xFF7CCD8B),
    tertiaryContainer: Color(0xFFC98B3E),
    secondaryContainer: Color(0xFFEE6464),
    onTertiary: Color(0xFFD9D9D9),
    onSecondary: Color(0xFF00FEE1),
    onSecondaryContainer: Color(0xFFA8C5C1),
    onTertiaryContainer: Color(0xFF425956),
    outline: Color(0xFF8CFFF1),
    onPrimaryContainer: Color(0xFFDEFFFB),
    errorContainer: Color(0xFFF6F6F6),
    primaryContainer: Color(0xFFFFA800),
    onSurface: Color(0xFFFFE6AD),
    onPrimary: Color(0xFF111827),
    inverseSurface: Color(0xFF0148AF),
    surfaceContainer: Color(0xFF0094FF),
    secondaryFixedDim: Color(0xff808080),

  ),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFFF47C20))),

  extensions: <ThemeExtension<CustomThemeColors>>[
    CustomThemeColors.dark(),
  ],
);