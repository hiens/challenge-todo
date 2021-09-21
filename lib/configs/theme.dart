import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final ThemeData appTheme = ThemeData(
  platform: TargetPlatform.android,
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  primaryColorLight: kPrimaryColorLight,
  primaryColorDark: kPrimaryColorDark,
  textTheme: GoogleFonts.playfairDisplayTextTheme(),
  colorScheme: ColorScheme(
    primary: kPrimaryColor,
    primaryVariant: kPrimaryColorDark,
    secondary: kAccentColor,
    secondaryVariant: kAccentColor,
    surface: Colors.grey[50]!,
    background: Colors.grey[50]!,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 16,
    ),
  ),
);
