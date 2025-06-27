import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_colors.dart';

class ComponentThemes {
  // Button Themes
  static ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.onPrimary,
        backgroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.onDisabled,
        disabledBackgroundColor: AppColors.disabled,
        elevation: 2,
        shadowColor: AppColors.shadow.withValues(alpha: 0.3),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.hover.withValues(alpha: 0.1);
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColors.pressed.withValues(alpha: 0.2);
            }
            return null;
          },
        ),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.disabled,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ).copyWith(
        side: WidgetStateProperty.resolveWith<BorderSide>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return const BorderSide(color: AppColors.disabled, width: 1.5);
            }
            if (states.contains(WidgetState.pressed)) {
              return const BorderSide(color: AppColors.pressed, width: 1.5);
            }
            return const BorderSide(color: AppColors.primary, width: 1.5);
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.primary.withValues(alpha: 0.1);
            }
            if (states.contains(WidgetState.pressed)) {
              return AppColors.primary.withValues(alpha: 0.2);
            }
            return null;
          },
        ),
      ),
    );
  }

  static FilledButtonThemeData filledButtonTheme(ColorScheme colorScheme) {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: AppColors.onSecondary,
        backgroundColor: AppColors.secondary,
        disabledForegroundColor: AppColors.onDisabled,
        disabledBackgroundColor: AppColors.disabled,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static TextButtonThemeData textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        disabledForegroundColor: AppColors.disabled,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minimumSize: const Size(64, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
      ),
    );
  }

  // Card Theme
  static CardTheme cardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: AppColors.surface,
      shadowColor: AppColors.shadow.withValues(alpha: 0.2),
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.outline.withValues(alpha: 0.2),
        ),
      ),
    );
  }

  // Input Theme
  static InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.disabled),
      ),
      labelStyle: const TextStyle(color: AppColors.onSurfaceVariant),
      hintStyle: TextStyle(color: AppColors.onSurfaceVariant.withValues(alpha: 0.6)),
      errorStyle: const TextStyle(color: AppColors.error),
      helperStyle: TextStyle(color: AppColors.onSurfaceVariant.withValues(alpha: 0.8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  // AppBar Theme
  static AppBarTheme lightAppBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppColors.shadow.withValues(alpha: 0.1),
      centerTitle: false,
      titleTextStyle: const TextStyle(
        color: AppColors.onSurface,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: AppColors.onSurface),
      actionsIconTheme: const IconThemeData(color: AppColors.onSurface),
      shape: Border(
        bottom: BorderSide(
          color: AppColors.outline.withValues(alpha: 0.2),
        ),
      ),
    );
  }

  static AppBarTheme darkAppBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: AppColors.shadow.withValues(alpha: 0.3),
      centerTitle: false,
      titleTextStyle: const TextStyle(
        color: AppColors.onSurface,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: const IconThemeData(color: AppColors.onSurface),
      actionsIconTheme: const IconThemeData(color: AppColors.onSurface),
    );
  }

  // Navigation Themes
  static BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colorScheme) {
    return const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static NavigationRailThemeData navigationRailTheme(ColorScheme colorScheme) {
    return const NavigationRailThemeData(
      backgroundColor: AppColors.surface,
      selectedIconTheme: IconThemeData(
        color: AppColors.primary,
        size: 24,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.onSurfaceVariant,
        size: 24,
      ),
      selectedLabelTextStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: AppColors.onSurfaceVariant,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      indicatorColor: AppColors.primaryContainer,
    );
  }

  // Other Component Themes
  static ChipThemeData chipTheme(ColorScheme colorScheme) {
    return ChipThemeData(
      backgroundColor: AppColors.surfaceContainer,
      selectedColor: AppColors.primaryContainer,
      disabledColor: AppColors.disabled,
      deleteIconColor: AppColors.onSurfaceVariant,
      labelStyle: const TextStyle(
        color: AppColors.onSurface,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      side: BorderSide(color: AppColors.outline.withValues(alpha: 0.5)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static DrawerThemeData drawerTheme(ColorScheme colorScheme) {
    return DrawerThemeData(
      backgroundColor: AppColors.surface,
      scrimColor: AppColors.scrim.withValues(alpha: 0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
    );
  }

  static DividerThemeData dividerTheme(ColorScheme colorScheme) {
    return DividerThemeData(
      color: AppColors.outline.withValues(alpha: 0.3),
      thickness: 1,
      space: 1,
    );
  }

  static SnackBarThemeData snackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      backgroundColor: AppColors.surfaceContainerHigh,
      contentTextStyle: const TextStyle(color: AppColors.onSurface),
      actionTextColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static DialogTheme dialogTheme(ColorScheme colorScheme) {
    return DialogTheme(
      backgroundColor: AppColors.surface,
      surfaceTintColor: AppColors.primary,
      elevation: 6,
      shadowColor: AppColors.shadow.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: const TextStyle(
        color: AppColors.onSurface,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: const TextStyle(
        color: AppColors.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static BottomSheetThemeData bottomSheetTheme(ColorScheme colorScheme) {
    return const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      surfaceTintColor: AppColors.primary,
      modalBackgroundColor: AppColors.surface,
      elevation: 8,
      modalElevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  static ListTileThemeData listTileTheme(ColorScheme colorScheme) {
    return ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: AppColors.primaryContainer.withValues(alpha: 0.3),
      iconColor: AppColors.onSurfaceVariant,
      textColor: AppColors.onSurface,
      titleTextStyle: const TextStyle(
        color: AppColors.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: const TextStyle(
        color: AppColors.onSurfaceVariant,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static SwitchThemeData switchTheme(ColorScheme colorScheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.onPrimary;
          }
          return AppColors.outline;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.surfaceContainerHighest;
        },
      ),
    );
  }

  static CheckboxThemeData checkboxTheme(ColorScheme colorScheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        },
      ),
      checkColor: WidgetStateProperty.all(AppColors.onPrimary),
      side: const BorderSide(color: AppColors.outline, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  static RadioThemeData radioTheme(ColorScheme colorScheme) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.outline;
        },
      ),
    );
  }
}
