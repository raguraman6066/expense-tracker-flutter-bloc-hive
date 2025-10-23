import 'package:expensetracker/utils/constants.dart';
import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.light(
    surface: backgroundColor,
    primary: primaryDark,
    secondary: secondaryDark,
  ),
  useMaterial3: true,
);
