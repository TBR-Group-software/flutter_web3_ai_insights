import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/breakpoints.dart';

/// A widget that applies responsive padding based on screen size
class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({
    super.key,
    required this.child,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.largeDektopPadding,
  });

  /// Factory constructor for symmetric horizontal responsive padding
  factory ResponsivePadding.horizontal({required Widget child}) {
    return ResponsivePadding(
      mobilePadding: const EdgeInsets.symmetric(horizontal: 16),
      tabletPadding: const EdgeInsets.symmetric(horizontal: 24),
      desktopPadding: const EdgeInsets.symmetric(horizontal: 32),
      largeDektopPadding: const EdgeInsets.symmetric(horizontal: 48),
      child: child,
    );
  }

  /// Factory constructor for all-sides responsive padding
  factory ResponsivePadding.all({required Widget child}) {
    return ResponsivePadding(
      mobilePadding: const EdgeInsets.all(16),
      tabletPadding: const EdgeInsets.all(24),
      desktopPadding: const EdgeInsets.all(32),
      largeDektopPadding: const EdgeInsets.all(48),
      child: child,
    );
  }
  final Widget child;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final EdgeInsets? largeDektopPadding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        EdgeInsets padding;

        if (AppBreakpoints.isLargeDesktop(width)) {
          padding = largeDektopPadding ?? desktopPadding ?? tabletPadding ?? mobilePadding ?? EdgeInsets.zero;
        } else if (AppBreakpoints.isDesktop(width)) {
          padding = desktopPadding ?? tabletPadding ?? mobilePadding ?? EdgeInsets.zero;
        } else if (AppBreakpoints.isTablet(width)) {
          padding = tabletPadding ?? mobilePadding ?? EdgeInsets.zero;
        } else {
          padding = mobilePadding ?? EdgeInsets.zero;
        }

        return Padding(padding: padding, child: child);
      },
    );
  }
}

/// A container with responsive max width constraint
class ResponsiveContainer extends StatelessWidget {
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.alignment = Alignment.center,
  });
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final contentMaxWidth = maxWidth ?? AppBreakpoints.getMaxContentWidth(width);

        return Container(
          alignment: alignment,
          padding: padding,
          child: ConstrainedBox(constraints: BoxConstraints(maxWidth: contentMaxWidth), child: child),
        );
      },
    );
  }
}
