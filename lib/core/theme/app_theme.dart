import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3_ai_assistant/core/theme/app_colors.dart';
import 'package:web3_ai_assistant/core/theme/app_text_theme.dart';
import 'package:web3_ai_assistant/core/theme/component_themes.dart';

class AppTheme {
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      primaryContainer: AppColors.primaryContainer,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,
      secondaryContainer: AppColors.secondaryContainer,
      onSecondaryContainer: AppColors.onSecondaryContainer,
      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryContainer: AppColors.tertiaryContainer,
      onTertiaryContainer: AppColors.onTertiaryContainer,
      error: AppColors.error,
      onError: AppColors.onError,
      errorContainer: AppColors.errorContainer,
      onErrorContainer: AppColors.onErrorContainer,
      surface: AppColors.surface,
      surfaceContainerHighest: AppColors.surfaceVariant,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,
      shadow: AppColors.shadow,
      scrim: AppColors.scrim,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.inverseOnSurface,
      inversePrimary: AppColors.inversePrimary,
      surfaceTint: AppColors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.darkTextTheme,
      appBarTheme: ComponentThemes.darkAppBarTheme(colorScheme),
      elevatedButtonTheme: ComponentThemes.elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: ComponentThemes.outlinedButtonTheme(colorScheme),
      filledButtonTheme: ComponentThemes.filledButtonTheme(colorScheme),
      textButtonTheme: ComponentThemes.textButtonTheme(colorScheme),
      cardTheme: ComponentThemes.cardTheme(colorScheme),
      chipTheme: ComponentThemes.chipTheme(colorScheme),
      inputDecorationTheme: ComponentThemes.inputDecorationTheme(colorScheme),
      bottomNavigationBarTheme: ComponentThemes.bottomNavigationBarTheme(colorScheme),
      navigationRailTheme: ComponentThemes.navigationRailTheme(colorScheme),
      drawerTheme: ComponentThemes.drawerTheme(colorScheme),
      dividerTheme: ComponentThemes.dividerTheme(colorScheme),
      snackBarTheme: ComponentThemes.snackBarTheme(colorScheme),
      dialogTheme: ComponentThemes.dialogTheme(colorScheme),
      bottomSheetTheme: ComponentThemes.bottomSheetTheme(colorScheme),
      listTileTheme: ComponentThemes.listTileTheme(colorScheme),
      switchTheme: ComponentThemes.switchTheme(colorScheme),
      checkboxTheme: ComponentThemes.checkboxTheme(colorScheme),
      radioTheme: ComponentThemes.radioTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.surface,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      fontFamily: AppTextTheme.fontFamily,
    );
  }

  // Light theme for future use or testing
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppColors.secondary,
      onPrimary: AppColors.background,
      primaryContainer: Palette.overlay1,
      onPrimaryContainer: AppColors.secondary,
      secondary: AppColors.primary,
      onSecondary: AppColors.background,
      secondaryContainer: Palette.overlay2,
      onSecondaryContainer: AppColors.primary,
      tertiary: AppColors.tertiary,
      onTertiary: Palette.white,
      tertiaryContainer: Palette.overlay1,
      onTertiaryContainer: AppColors.tertiary,
      error: AppColors.error,
      errorContainer: Palette.overlay1,
      onErrorContainer: AppColors.error,
      surface: Palette.overlay1,
      onSurface: AppColors.background,
      surfaceContainerHighest: Palette.overlay2,
      onSurfaceVariant: AppColors.background,
      outline: Palette.overlay3,
      outlineVariant: Palette.overlay2,
      shadow: AppColors.shadow,
      scrim: AppColors.scrim,
      inverseSurface: AppColors.background,
      onInverseSurface: Palette.white,
      inversePrimary: AppColors.primary,
      surfaceTint: AppColors.secondary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.lightTextTheme,
      appBarTheme: ComponentThemes.lightAppBarTheme(colorScheme),
      elevatedButtonTheme: ComponentThemes.elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: ComponentThemes.outlinedButtonTheme(colorScheme),
      filledButtonTheme: ComponentThemes.filledButtonTheme(colorScheme),
      textButtonTheme: ComponentThemes.textButtonTheme(colorScheme),
      cardTheme: ComponentThemes.cardTheme(colorScheme),
      chipTheme: ComponentThemes.chipTheme(colorScheme),
      inputDecorationTheme: ComponentThemes.inputDecorationTheme(colorScheme),
      bottomNavigationBarTheme: ComponentThemes.bottomNavigationBarTheme(colorScheme),
      navigationRailTheme: ComponentThemes.navigationRailTheme(colorScheme),
      drawerTheme: ComponentThemes.drawerTheme(colorScheme),
      dividerTheme: ComponentThemes.dividerTheme(colorScheme),
      snackBarTheme: ComponentThemes.snackBarTheme(colorScheme),
      dialogTheme: ComponentThemes.dialogTheme(colorScheme),
      bottomSheetTheme: ComponentThemes.bottomSheetTheme(colorScheme),
      listTileTheme: ComponentThemes.listTileTheme(colorScheme),
      switchTheme: ComponentThemes.switchTheme(colorScheme),
      checkboxTheme: ComponentThemes.checkboxTheme(colorScheme),
      radioTheme: ComponentThemes.radioTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.surface,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      fontFamily: AppTextTheme.fontFamily,
    );
  }

  static SystemUiOverlayStyle get darkSystemUiOverlayStyle {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }

  static SystemUiOverlayStyle get lightSystemUiOverlayStyle {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Palette.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  // Helper method to apply theme-based system UI overlay
  static void setSystemUIOverlayStyle(bool isDark) {
    SystemChrome.setSystemUIOverlayStyle(
      isDark ? darkSystemUiOverlayStyle : lightSystemUiOverlayStyle,
    );
  }
}
