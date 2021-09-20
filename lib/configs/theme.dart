import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'colors.dart';

final ThemeData appTheme = ThemeData(
  platform: TargetPlatform.android,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    color: Colors.grey[50],
    iconTheme: Get.theme.primaryIconTheme.copyWith(color: Colors.black),
    actionsIconTheme: Get.theme.primaryIconTheme.copyWith(color: Colors.black),
    elevation: 0,
    centerTitle: true,
    toolbarTextStyle: Get.theme.textTheme.headline6?.copyWith(
      color: Colors.black,
      fontFamily: 'ProductSans',
    ),
    titleTextStyle: Get.theme.textTheme.headline6?.copyWith(
      color: Colors.black,
      fontFamily: 'ProductSans',
    ),
  ),
  primaryColor: kPrimaryColor,
  primaryColorLight: kPrimaryColorLight,
  primaryColorDark: kPrimaryColorDark,
  fontFamily: 'ProductSans',
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
