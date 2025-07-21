import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3_ai_assistant/core/theme/app_colors.dart';
import 'package:web3_ai_assistant/core/theme/app_text_theme.dart';
import 'package:web3_ai_assistant/core/theme/component_themes.dart';

class AppTheme {
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      // Primary colors
      primary: Palette.primary,
      onPrimary: Palette.background,
      primaryContainer: Palette.base2,
      onPrimaryContainer: Palette.primary,
      
      // Secondary colors
      secondary: Palette.secondary,
      onSecondary: Palette.background,
      secondaryContainer: Palette.base3,
      onSecondaryContainer: Palette.secondary,
      
      // Tertiary colors
      tertiary: Palette.tertiary,
      onTertiary: Palette.white,
      tertiaryContainer: Palette.base4,
      onTertiaryContainer: Palette.accentBlue,
      
      // Error colors
      error: Palette.errorRed,
      onError: Palette.white,
      errorContainer: Palette.darkRed,
      onErrorContainer: Palette.lightRed,
      
      // Surface colors
      surface: Palette.base1,
      onSurface: Palette.white,
      surfaceContainerLowest: Palette.background,
      surfaceContainerLow: Palette.base1,
      surfaceContainer: Palette.base2,
      surfaceContainerHigh: Palette.base3,
      surfaceContainerHighest: Palette.base4,
      
      // Surface variants
      onSurfaceVariant: Palette.overlay2,
      outline: Palette.overlay4,
      outlineVariant: Palette.overlay3,
      
      // Other colors
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Palette.white,
      onInverseSurface: Palette.background,
      inversePrimary: Palette.tertiary,
      surfaceTint: Palette.primary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.darkTextTheme(colorScheme),
      appBarTheme: ComponentThemes.darkAppBarTheme(colorScheme),
      elevatedButtonTheme: ComponentThemes.elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: ComponentThemes.outlinedButtonTheme(colorScheme),
      filledButtonTheme: ComponentThemes.filledButtonTheme(colorScheme),
      textButtonTheme: ComponentThemes.textButtonTheme(colorScheme),
      cardTheme: ComponentThemes.cardTheme(colorScheme),
      chipTheme: ComponentThemes.chipTheme(colorScheme),
      inputDecorationTheme: ComponentThemes.inputDecorationTheme(colorScheme),
      bottomNavigationBarTheme: ComponentThemes.bottomNavigationBarTheme(colorScheme),
      navigationBarTheme: ComponentThemes.navigationBarTheme(colorScheme),
      navigationRailTheme: ComponentThemes.navigationRailTheme(colorScheme),
      navigationDrawerTheme: ComponentThemes.navigationDrawerTheme(colorScheme),
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
      // Primary colors
      primary: Palette.secondary,
      onPrimary: Palette.background,
      primaryContainer: Palette.overlay1,
      onPrimaryContainer: Palette.secondary,
      
      // Secondary colors
      secondary: Palette.primary,
      onSecondary: Palette.background,
      secondaryContainer: Palette.overlay2,
      onSecondaryContainer: Palette.primary,
      
      // Tertiary colors
      tertiary: Palette.tertiary,
      onTertiary: Palette.white,
      tertiaryContainer: Palette.overlay1,
      onTertiaryContainer: Palette.tertiary,
      
      // Error colors
      error: Palette.errorRed,
      onError: Palette.white,
      errorContainer: Palette.overlay1,
      onErrorContainer: Palette.errorRed,
      
      // Surface colors
      surface: Palette.overlay1,
      onSurface: Palette.background,
      surfaceContainerLowest: Palette.white,
      surfaceContainerLow: Palette.overlay1,
      surfaceContainer: Palette.overlay2,
      surfaceContainerHigh: Palette.overlay3,
      surfaceContainerHighest: Palette.overlay4,
      
      // Surface variants
      onSurfaceVariant: Palette.background,
      outline: Palette.overlay3,
      outlineVariant: Palette.overlay2,
      
      // Other colors
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Palette.background,
      onInverseSurface: Palette.white,
      inversePrimary: Palette.primary,
      surfaceTint: Palette.secondary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: AppTextTheme.lightTextTheme(colorScheme),
      appBarTheme: ComponentThemes.lightAppBarTheme(colorScheme),
      elevatedButtonTheme: ComponentThemes.elevatedButtonTheme(colorScheme),
      outlinedButtonTheme: ComponentThemes.outlinedButtonTheme(colorScheme),
      filledButtonTheme: ComponentThemes.filledButtonTheme(colorScheme),
      textButtonTheme: ComponentThemes.textButtonTheme(colorScheme),
      cardTheme: ComponentThemes.cardTheme(colorScheme),
      chipTheme: ComponentThemes.chipTheme(colorScheme),
      inputDecorationTheme: ComponentThemes.inputDecorationTheme(colorScheme),
      bottomNavigationBarTheme: ComponentThemes.bottomNavigationBarTheme(colorScheme),
      navigationBarTheme: ComponentThemes.navigationBarTheme(colorScheme),
      navigationRailTheme: ComponentThemes.navigationRailTheme(colorScheme),
      navigationDrawerTheme: ComponentThemes.navigationDrawerTheme(colorScheme),
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
      systemNavigationBarColor: Palette.background,
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
