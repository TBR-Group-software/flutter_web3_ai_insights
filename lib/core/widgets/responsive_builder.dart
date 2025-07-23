import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/breakpoints.dart';

/// A widget that builds different layouts based on screen size
class ResponsiveBuilder extends StatelessWidget {

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });
  final Widget Function(BuildContext context, BoxConstraints constraints) mobile;
  final Widget Function(BuildContext context, BoxConstraints constraints)? tablet;
  final Widget Function(BuildContext context, BoxConstraints constraints)? desktop;
  final Widget Function(BuildContext context, BoxConstraints constraints)? largeDesktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final screenSize = AppBreakpoints.getScreenSize(width);

        switch (screenSize) {
          case ScreenSize.largeDesktop:
            return (largeDesktop ?? desktop ?? tablet ?? mobile)(context, constraints);
          case ScreenSize.desktop:
            return (desktop ?? tablet ?? mobile)(context, constraints);
          case ScreenSize.tablet:
            return (tablet ?? mobile)(context, constraints);
          case ScreenSize.mobile:
            return mobile(context, constraints);
        }
      },
    );
  }
}

/// Simplified responsive builder that just needs widgets, not builders
class ResponsiveWidget extends StatelessWidget {

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: (_, _) => mobile,
      tablet: tablet != null ? (_, _) => tablet! : null,
      desktop: desktop != null ? (_, _) => desktop! : null,
      largeDesktop: largeDesktop != null ? (_, _) => largeDesktop! : null,
    );
  }
}
