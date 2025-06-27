class AppBreakpoints {
  // Breakpoint values (in logical pixels)
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;
  static const double largeDesktop = 1920;

  // Helper methods to check screen size
  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < desktop;
  static bool isDesktop(double width) => width >= desktop;
  static bool isLargeDesktop(double width) => width >= largeDesktop;

  // Get current breakpoint
  static ScreenSize getScreenSize(double width) {
    if (width < mobile) {
      return ScreenSize.mobile;
    }
    if (width < desktop) {
      return ScreenSize.tablet;
    }
    if (width < largeDesktop) {
      return ScreenSize.desktop;
    }
    return ScreenSize.largeDesktop;
  }

  // Grid columns based on screen size
  static int getGridColumns(double width) {
    if (isMobile(width)) {
      return 1;
    }
    if (isTablet(width)) {
      return 2;
    }
    if (isDesktop(width)) {
      return 3;
    }
    return 4; // Large desktop
  }

  // Responsive padding
  static double getHorizontalPadding(double width) {
    if (isMobile(width)) {
      return 16;
    }
    if (isTablet(width)) {
      return 24;
    }
    if (isDesktop(width)) {
      return 32;
    }
    return 48; // Large desktop
  }

  static double getVerticalPadding(double width) {
    if (isMobile(width)) {
      return 16;
    }
    if (isTablet(width)) {
      return 20;
    }
    if (isDesktop(width)) {
      return 24;
    }
    return 32; // Large desktop
  }

  // Content max width for different layouts
  static double getMaxContentWidth(double width) {
    if (isMobile(width)) {
      return width;
    }
    if (isTablet(width)) {
      return 768;
    }
    if (isDesktop(width)) {
      return 1200;
    }
    return 1400; // Large desktop
  }

  // Navigation layout type
  static NavigationType getNavigationType(double width) {
    if (isMobile(width)) {
      return NavigationType.bottom;
    }
    if (isTablet(width)) {
      return NavigationType.rail;
    }
    return NavigationType.drawer;
  }

  // Card dimensions
  static double getCardWidth(double width) {
    if (isMobile(width)) {
      return width - 32; // Full width minus padding
    }
    if (isTablet(width)) {
      return (width - 64) / 2; // 2 columns
    }
    if (isDesktop(width)) {
      return (width - 96) / 3; // 3 columns
    }
    return (width - 128) / 4; // 4 columns for large desktop
  }

  static double getPortfolioCardHeight(double width) {
    if (isMobile(width)) {
      return 120;
    }
    if (isTablet(width)) {
      return 140;
    }
    return 160; // Desktop and above
  }

  // Dialog dimensions
  static double getDialogWidth(double width) {
    if (isMobile(width)) {
      return width * 0.9;
    }
    if (isTablet(width)) {
      return 500;
    }
    return 600; // Desktop and above
  }

  // Sidebar width for navigation
  static double getSidebarWidth(double width) {
    if (isTablet(width)) {
      return 72; // Rail width
    }
    return 280; // Full sidebar width for desktop
  }

  // App bar height variations
  static double getAppBarHeight(double width) {
    if (isMobile(width)) {
      return 56;
    }
    return 64; // Tablet and desktop
  }

  // Font scaling
  static double getFontScale(double width) {
    if (isMobile(width)) {
      return 0.9;
    }
    if (isTablet(width)) {
      return 1;
    }
    return 1.1; // Desktop and above
  }

  // Chart dimensions for portfolio visualization
  static double getChartHeight(double width) {
    if (isMobile(width)) {
      return 200;
    }
    if (isTablet(width)) {
      return 300;
    }
    return 400; // Desktop and above
  }

  // Button sizing
  static double getButtonHeight(double width) {
    if (isMobile(width)) {
      return 48;
    }
    return 52; // Tablet and desktop
  }

  static double getButtonMinWidth(double width) {
    if (isMobile(width)) {
      return 88;
    }
    return 120; // Tablet and desktop
  }

  // Form field sizing
  static double getFormFieldHeight(double width) {
    if (isMobile(width)) {
      return 56;
    }
    return 60; // Tablet and desktop
  }
}

enum ScreenSize {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

enum NavigationType {
  bottom,
  rail,
  drawer,
}
