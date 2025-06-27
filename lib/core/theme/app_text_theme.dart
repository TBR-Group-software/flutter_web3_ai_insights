import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_colors.dart';

class AppTextTheme {
  static const String fontFamily = 'System';

  // Base text theme for dark theme
  static TextTheme get darkTextTheme {
    return const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 1.12,
        letterSpacing: -0.25,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 1.16,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 1.22,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 1.25,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 1.29,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 1.33,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.27,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.50,
        letterSpacing: 0.15,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.50,
        letterSpacing: 0.5,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.25,
        color: AppColors.onBackground,
        fontFamily: fontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0.4,
        color: AppColors.onSurfaceVariant,
        fontFamily: fontFamily,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
        color: AppColors.onSurface,
        fontFamily: fontFamily,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
        letterSpacing: 0.5,
        color: AppColors.onSurface,
        fontFamily: fontFamily,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.45,
        letterSpacing: 0.5,
        color: AppColors.onSurfaceVariant,
        fontFamily: fontFamily,
      ),
    );
  }

  // Light text theme (for future use or contrast scenarios)
  static TextTheme get lightTextTheme {
    return darkTextTheme.apply(
      bodyColor: AppColors.background,
      displayColor: AppColors.background,
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
  static TextStyle get gradientText => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
    foreground: Paint()
      ..shader = AppColors.primaryGradient.createShader(
        const Rect.fromLTWH(0, 0, 200, 70),
      ),
    fontFamily: fontFamily,
  );

  static TextStyle get currencyText => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.primary,
    fontFamily: fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextStyle get percentagePositive => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.success,
    fontFamily: fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextStyle get percentageNegative => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.error,
    fontFamily: fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextStyle get percentageNeutral => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: AppColors.neutral,
    fontFamily: fontFamily,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static TextStyle get tokenSymbol => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.onSurfaceVariant,
    fontFamily: fontFamily,
    letterSpacing: 0.5,
  );

  static TextStyle get walletAddress => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.2,
    color: AppColors.onSurfaceVariant,
    fontFamily: 'monospace',
    letterSpacing: 0.2,
  );

  static TextStyle get aiInsightTitle => const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.primary,
    fontFamily: fontFamily,
  );

  static TextStyle get aiInsightBody => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.onSurface,
    fontFamily: fontFamily,
  );

  static TextStyle get errorText => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.error,
    fontFamily: fontFamily,
  );

  static TextStyle get successText => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.success,
    fontFamily: fontFamily,
  );

  static TextStyle get warningText => const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.warning,
    fontFamily: fontFamily,
  );
}
