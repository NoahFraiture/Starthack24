import 'dart:ui';

import 'package:flutter/material.dart';

const textColor = Color(0xFF170a0a);
const backgroundColor = Color(0xFFffffff);
const primaryColor = Color(0x00d2c1ac);
const primaryFgColor = Color(0xFF170a0a);
const secondaryColor = Color(0xFFe98080);
const secondaryFgColor = Color(0xFF170a0a);
const accentColor = Color(0xFFee5b5b);
const accentFgColor = Color(0xFF170a0a);

const colorScheme = ColorScheme(
  brightness: Brightness.light,
  background: backgroundColor,
  onBackground: textColor,
  primary: primaryColor,
  onPrimary: primaryFgColor,
  secondary: secondaryColor,
  onSecondary: secondaryFgColor,
  tertiary: accentColor,
  onTertiary: accentFgColor,
  surface: backgroundColor,
  onSurface: textColor,
  error: Brightness.light == Brightness.light ? Color(0xffB3261E) : Color(0xffF2B8B5),
  onError: Brightness.light == Brightness.light ? Color(0xffFFFFFF) : Color(0xff601410),
);