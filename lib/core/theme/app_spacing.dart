import 'package:flutter/material.dart';

class AppSpacing {
  // Base spacing unit (4dp)
  static const double unit = 4;

  // Spacing scale (multiples of base unit)
  static const double xs = unit; // 4
  static const double sm = unit * 2; // 8
  static const double md = unit * 3; // 12
  static const double lg = unit * 4; // 16
  static const double xl = unit * 5; // 20
  static const double xxl = unit * 6; // 24
  static const double xxxl = unit * 8; // 32
  static const double xxxxl = unit * 12; // 48
  static const double xxxxxl = unit * 16; // 64

  // Common spacing shortcuts
  static const double micro = xs; // 4
  static const double small = sm; // 8
  static const double medium = lg; // 16
  static const double large = xxl; // 24
  static const double extraLarge = xxxl; // 32
  static const double huge = xxxxl; // 48
  static const double massive = xxxxxl; // 64

  // Semantic spacing for UI components
  static const double buttonPadding = lg; // 16
  static const double cardPadding = lg; // 16
  static const double screenPadding = lg; // 16
  static const double sectionSpacing = xxl; // 24
  static const double elementSpacing = md; // 12
  static const double listItemSpacing = sm; // 8

  // Form spacing
  static const double formFieldSpacing = lg; // 16
  static const double formSectionSpacing = xxxl; // 32
  static const double inputPadding = md; // 12

  // Navigation spacing
  static const double navItemSpacing = sm; // 8
  static const double navSectionSpacing = lg; // 16
  static const double tabBarPadding = lg; // 16

  // Component-specific spacing
  static const double chipSpacing = sm; // 8
  static const double iconSpacing = sm; // 8
  static const double dividerSpacing = lg; // 16

  // Responsive spacing getters
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < 600) {
      // Mobile - slightly smaller spacing
      return baseSpacing * 0.8;
    } else if (width < 1200) {
      // Tablet - normal spacing
      return baseSpacing;
    } else {
      // Desktop - slightly larger spacing
      return baseSpacing * 1.2;
    }
  }

  static double getScreenPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < 600) {
      return lg; // 16
    } else if (width < 1200) {
      return xl; // 20
    } else {
      return xxl; // 24
    }
  }

  static double getSectionSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < 600) {
      return xl; // 20
    } else if (width < 1200) {
      return xxl; // 24
    } else {
      return xxxl; // 32
    }
  }

  // Helper methods for EdgeInsets
  static EdgeInsets get allXs => const EdgeInsets.all(xs);
  static EdgeInsets get allSm => const EdgeInsets.all(sm);
  static EdgeInsets get allMd => const EdgeInsets.all(md);
  static EdgeInsets get allLg => const EdgeInsets.all(lg);
  static EdgeInsets get allXl => const EdgeInsets.all(xl);
  static EdgeInsets get allXxl => const EdgeInsets.all(xxl);
  static EdgeInsets get allXxxl => const EdgeInsets.all(xxxl);

  static EdgeInsets get horizontalXs => const EdgeInsets.symmetric(horizontal: xs);
  static EdgeInsets get horizontalSm => const EdgeInsets.symmetric(horizontal: sm);
  static EdgeInsets get horizontalMd => const EdgeInsets.symmetric(horizontal: md);
  static EdgeInsets get horizontalLg => const EdgeInsets.symmetric(horizontal: lg);
  static EdgeInsets get horizontalXl => const EdgeInsets.symmetric(horizontal: xl);
  static EdgeInsets get horizontalXxl => const EdgeInsets.symmetric(horizontal: xxl);
  static EdgeInsets get horizontalXxxl => const EdgeInsets.symmetric(horizontal: xxxl);

  static EdgeInsets get verticalXs => const EdgeInsets.symmetric(vertical: xs);
  static EdgeInsets get verticalSm => const EdgeInsets.symmetric(vertical: sm);
  static EdgeInsets get verticalMd => const EdgeInsets.symmetric(vertical: md);
  static EdgeInsets get verticalLg => const EdgeInsets.symmetric(vertical: lg);
  static EdgeInsets get verticalXl => const EdgeInsets.symmetric(vertical: xl);
  static EdgeInsets get verticalXxl => const EdgeInsets.symmetric(vertical: xxl);
  static EdgeInsets get verticalXxxl => const EdgeInsets.symmetric(vertical: xxxl);

  // Common padding combinations
  static EdgeInsets get cardPaddingAll => allLg;
  static EdgeInsets get screenPaddingAll => allLg;
  static EdgeInsets get buttonPaddingHorizontal => horizontalLg;
  static EdgeInsets get formFieldPaddingAll => allMd;
  static EdgeInsets get listItemPaddingHorizontal => horizontalLg;
  static EdgeInsets get listItemPaddingVertical => verticalSm;

  // SizedBox helpers
  static Widget get gapXs => const SizedBox(height: xs);
  static Widget get gapSm => const SizedBox(height: sm);
  static Widget get gapMd => const SizedBox(height: md);
  static Widget get gapLg => const SizedBox(height: lg);
  static Widget get gapXl => const SizedBox(height: xl);
  static Widget get gapXxl => const SizedBox(height: xxl);
  static Widget get gapXxxl => const SizedBox(height: xxxl);

  static Widget get hGapXs => const SizedBox(width: xs);
  static Widget get hGapSm => const SizedBox(width: sm);
  static Widget get hGapMd => const SizedBox(width: md);
  static Widget get hGapLg => const SizedBox(width: lg);
  static Widget get hGapXl => const SizedBox(width: xl);
  static Widget get hGapXxl => const SizedBox(width: xxl);
  static Widget get hGapXxxl => const SizedBox(width: xxxl);

  // Custom gap methods
  static Widget gap(double height) => SizedBox(height: height);
  static Widget hGap(double width) => SizedBox(width: width);
}

class AppSizing {
  // Icon sizes
  static const double iconXs = 16;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 28;
  static const double iconXl = 32;
  static const double iconXxl = 40;
  static const double iconXxxl = 48;

  // Button heights
  static const double buttonSm = 32;
  static const double buttonMd = 40;
  static const double buttonLg = 48;
  static const double buttonXl = 56;

  // Input field heights
  static const double inputSm = 32;
  static const double inputMd = 40;
  static const double inputLg = 48;
  static const double inputXl = 56;

  // Avatar sizes
  static const double avatarSm = 24;
  static const double avatarMd = 32;
  static const double avatarLg = 40;
  static const double avatarXl = 48;
  static const double avatarXxl = 64;

  // Border radius
  static const double radiusXs = 4;
  static const double radiusSm = 6;
  static const double radiusMd = 8;
  static const double radiusLg = 12;
  static const double radiusXl = 16;
  static const double radiusXxl = 20;
  static const double radiusXxxl = 24;
  static const double radiusRound = 100;

  // Common border radius
  static BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);
  static BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);
  static BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);
  static BorderRadius get borderRadiusXl => BorderRadius.circular(radiusXl);

  // Card dimensions
  static const double cardMinHeight = 120;
  static const double cardMaxWidth = 400;
  static const double portfolioCardHeight = 160;
  static const double tokenCardHeight = 80;

  // Layout constraints
  static const double maxContentWidth = 1200;
  static const double sidebarWidth = 280;
  static const double navigationRailWidth = 72;

  // Chart dimensions
  static const double chartMinHeight = 200;
  static const double chartMaxHeight = 400;

  // Elevation levels
  static const double elevationSm = 2;
  static const double elevationMd = 4;
  static const double elevationLg = 8;
  static const double elevationXl = 12;
  static const double elevationXxl = 16;

  // Line heights for text
  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.4;
  static const double lineHeightRelaxed = 1.6;
  static const double lineHeightLoose = 1.8;
}
