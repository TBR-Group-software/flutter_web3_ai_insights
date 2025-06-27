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

  static const LinearGradient gradient = LinearGradient(
    colors: <Color>[
      Color(0xFF00A0AF),
      Color(0xFF6BE7C8),
    ],
  );

  static const Color errorRed = Color(0xFFFF3B30);
  static const Color lightRed = Color(0xFFFF6057);
  static const Color accentBlue = Color(0xFF6BD1E7);
  static const Color accentDarkBlue = Color(0xFF6B9DE7);

  static const Color darkBlue = Color(0xff37434d);
  static const Color darkRed = Color(0xff4D3737);
}

class AppColors {
  // Primary theme colors
  static const Color primary = Palette.primary;
  static const Color primaryLight = Palette.primary;
  static const Color primaryDark = Palette.secondary;
  static const Color primaryContainer = Palette.base2;
  static const Color onPrimary = Palette.background;
  static const Color onPrimaryContainer = Palette.primary;

  // Secondary colors
  static const Color secondary = Palette.secondary;
  static const Color secondaryLight = Palette.primary;
  static const Color secondaryDark = Palette.tertiary;
  static const Color secondaryContainer = Palette.base3;
  static const Color onSecondary = Palette.background;
  static const Color onSecondaryContainer = Palette.secondary;

  // Tertiary colors
  static const Color tertiary = Palette.tertiary;
  static const Color tertiaryLight = Palette.accentBlue;
  static const Color tertiaryDark = Palette.accentDarkBlue;
  static const Color tertiaryContainer = Palette.base4;
  static const Color onTertiary = Palette.white;
  static const Color onTertiaryContainer = Palette.accentBlue;

  // Error colors
  static const Color error = Palette.errorRed;
  static const Color errorLight = Palette.lightRed;
  static const Color errorDark = Palette.darkRed;
  static const Color errorContainer = Palette.darkRed;
  static const Color onError = Palette.white;
  static const Color onErrorContainer = Palette.lightRed;

  // Warning colors
  static const Color warning = Color(0xFFFFB020);
  static const Color warningLight = Color(0xFFFFC947);
  static const Color warningDark = Color(0xFFE6A017);
  static const Color warningContainer = Color(0xFF4A3B1A);
  static const Color onWarning = Palette.background;
  static const Color onWarningContainer = Color(0xFFFFB020);

  // Success colors
  static const Color success = Palette.secondary;
  static const Color successLight = Palette.primary;
  static const Color successDark = Palette.tertiary;
  static const Color successContainer = Palette.base3;
  static const Color onSuccess = Palette.background;
  static const Color onSuccessContainer = Palette.secondary;

  // Surface colors
  static const Color background = Palette.background;
  static const Color surface = Palette.base1;
  static const Color surfaceVariant = Palette.base2;
  static const Color surfaceContainer = Palette.base3;
  static const Color surfaceContainerHigh = Palette.base4;
  static const Color surfaceContainerHighest = Palette.base2;
  static const Color outline = Palette.overlay4;
  static const Color outlineVariant = Palette.overlay3;
  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);

  // Text colors
  static const Color onBackground = Palette.white;
  static const Color onSurface = Palette.white;
  static const Color onSurfaceVariant = Palette.overlay2;
  static const Color inverseSurface = Palette.white;
  static const Color inverseOnSurface = Palette.background;
  static const Color inversePrimary = Palette.tertiary;

  // Interactive states
  static const Color hover = Palette.baseHover;
  static const Color focus = Palette.primary;
  static const Color pressed = Palette.secondary;
  static const Color disabled = Palette.overlay4;
  static const Color onDisabled = Palette.overlay3;

  // Gradients
  static const LinearGradient primaryGradient = Palette.gradient;
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Palette.secondary,
      Palette.tertiary,
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Palette.accentBlue,
      Palette.accentDarkBlue,
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Palette.base1,
      Palette.base2,
    ],
  );

  // Chart colors for portfolio visualization
  static const List<Color> chartColors = [
    Palette.primary,
    Palette.secondary,
    Palette.tertiary,
    Palette.accentBlue,
    Palette.accentDarkBlue,
    Color(0xFF9B59B6),
    Color(0xFFE74C3C),
    Color(0xFFF39C12),
    Color(0xFF2ECC71),
    Color(0xFF3498DB),
  ];

  // Status colors for token performance
  static const Color bullish = Palette.secondary;
  static const Color bearish = Palette.errorRed;
  static const Color neutral = Palette.overlay3;
}
