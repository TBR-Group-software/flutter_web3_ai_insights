import 'package:flutter/material.dart';

class Palette {
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFF0C0B09);
  static const Color base1 = Color(0xFF171615);
  static const Color base2 = Color(0xFF1D1B1A);
  static const Color base3 = Color(0xFF2A2827);
  static const Color base4 = Color(0xFF3D3C3A);
  static const Color baseHover = Color(0xFF22211F);

  static const Color overlay1 = Color(0xFFF7F7F7);
  static const Color overlay2 = Color(0xFFDFDFDF);
  static const Color overlay3 = Color(0xFFA19999);
  static const Color overlay4 = Color(0xFF595857);

  static const Color primary = Color(0xFF6BE7C8);
  static const Color secondary = Color(0xFF03C9A9);
  static const Color tertiary = Color(0xFF00A0AF);

  static const LinearGradient gradient = LinearGradient(colors: <Color>[Color(0xFF00A0AF), Color(0xFF6BE7C8)]);

  static const Color errorRed = Color(0xFFFF3B30);
  static const Color lightRed = Color(0xFFFF6057);
  static const Color accentBlue = Color(0xFF6BD1E7);
  static const Color accentDarkBlue = Color(0xFF6B9DE7);

  static const Color darkBlue = Color(0xff37434d);
  static const Color darkRed = Color(0xff4D3737);

  // Additional colors for theme
  static const Color warning = Color(0xFFFFB020);
  static const Color warningLight = Color(0xFFFFC947);
  static const Color warningDark = Color(0xFFE6A017);
  static const Color warningContainer = Color(0xFF4A3B1A);

  // Chart colors for portfolio visualization
  static const List<Color> chartColors = [
    primary,
    secondary,
    tertiary,
    accentBlue,
    accentDarkBlue,
    Color(0xFF9B59B6),
    Color(0xFFE74C3C),
    Color(0xFFF39C12),
    Color(0xFF2ECC71),
    Color(0xFF3498DB),
  ];
}
