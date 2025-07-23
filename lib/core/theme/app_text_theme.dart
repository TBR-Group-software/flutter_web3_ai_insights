import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static const String fontFamily = 'System';

  // Base text theme for dark theme
  static TextTheme darkTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      // Display styles
      displayLarge: GoogleFonts.orbitron(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        height: 1.12,
        letterSpacing: -0.25,
        color: colorScheme.onSurface,
      ),
      displayMedium: GoogleFonts.orbitron(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        height: 1.16,
        color: colorScheme.onSurface,
      ),
      displaySmall: GoogleFonts.orbitron(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.22,
        color: colorScheme.onSurface,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.orbitron(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: colorScheme.onSurface,
      ),
      headlineMedium: GoogleFonts.orbitron(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.29,
        color: colorScheme.onSurface,
      ),
      headlineSmall: GoogleFonts.orbitron(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.33,
        color: colorScheme.onSurface,
      ),

      // Title styles
      titleLarge: GoogleFonts.orbitron(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.27,
        color: colorScheme.onSurface,
      ),
      titleMedium: GoogleFonts.orbitron(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.50,
        letterSpacing: 0.15,
        color: colorScheme.onSurface,
      ),
      titleSmall: GoogleFonts.orbitron(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.43,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.50,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.25,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0.4,
        color: colorScheme.onSurfaceVariant,
        fontFamily: fontFamily,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
        fontFamily: fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
        letterSpacing: 0.5,
        color: colorScheme.onSurfaceVariant,
        fontFamily: fontFamily,
      ),
    );
  }

  // Light text theme (for future use or contrast scenarios)
  static TextTheme lightTextTheme(ColorScheme colorScheme) {
    return darkTextTheme(colorScheme).apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );
  }

  // Responsive text scaling
  static double getResponsiveTextScale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < 600) {
      // Mobile
      return 0.9;
    } else if (width < 1200) {
      // Tablet
      return 1;
    } else {
      // Desktop
      return 1.1;
    }
  }

  // Custom text styles for specific use cases
  static TextStyle gradientText(ColorScheme colorScheme) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
    foreground: Paint()
      ..shader = LinearGradient(
        colors: [colorScheme.primary, colorScheme.secondary],
      ).createShader(
        const Rect.fromLTWH(0, 0, 200, 70),
      ),
    fontFamily: fontFamily,
  );

  static TextStyle currencyText(ColorScheme colorScheme) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: colorScheme.primary,
    fontFamily: fontFamily,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle percentagePositive(ColorScheme colorScheme) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: colorScheme.tertiary,
    fontFamily: fontFamily,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle percentageNegative(ColorScheme colorScheme) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: colorScheme.error,
    fontFamily: fontFamily,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle percentageNeutral(ColorScheme colorScheme) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: colorScheme.onSurfaceVariant,
    fontFamily: fontFamily,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  static TextStyle tokenSymbol(ColorScheme colorScheme) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: colorScheme.onSurfaceVariant,
    fontFamily: fontFamily,
    letterSpacing: 0.5,
  );

  static TextStyle walletAddress(ColorScheme colorScheme) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.2,
    color: colorScheme.onSurfaceVariant,
    fontFamily: 'monospace',
    letterSpacing: 0.2,
  );

  static TextStyle aiInsightTitle(ColorScheme colorScheme) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: colorScheme.primary,
    fontFamily: fontFamily,
  );

  static TextStyle aiInsightBody(ColorScheme colorScheme) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: colorScheme.onSurface,
    fontFamily: fontFamily,
  );

  static TextStyle errorText(ColorScheme colorScheme) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: colorScheme.error,
    fontFamily: fontFamily,
  );

  static TextStyle successText(ColorScheme colorScheme) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: colorScheme.tertiary,
    fontFamily: fontFamily,
  );

  static TextStyle warningText(ColorScheme colorScheme) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: colorScheme.secondary,
    fontFamily: fontFamily,
  );
}
