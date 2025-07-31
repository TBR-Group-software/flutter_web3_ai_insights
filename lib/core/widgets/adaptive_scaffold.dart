import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3_ai_assistant/core/theme/breakpoints.dart';
import 'package:web3_ai_assistant/core/widgets/adaptive_scaffold_mobile_layout.dart';
import 'package:web3_ai_assistant/core/widgets/adaptive_scaffold_tablet_layout.dart';
import 'package:web3_ai_assistant/core/widgets/adaptive_scaffold_desktop_layout.dart';

/// An adaptive scaffold that changes navigation style based on screen size
class AdaptiveScaffold extends ConsumerWidget {
  const AdaptiveScaffold({super.key, required this.currentRoute, required this.body, this.title, this.actions});
  final String currentRoute;
  final Widget body;
  final String? title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (AppBreakpoints.isMobile(constraints.maxWidth)) {
          return AdaptiveScaffoldMobileLayout(currentRoute: currentRoute, body: body, title: title, actions: actions);
        } else if (AppBreakpoints.isTablet(constraints.maxWidth)) {
          return AdaptiveScaffoldTabletLayout(currentRoute: currentRoute, body: body, title: title, actions: actions);
        } else {
          return AdaptiveScaffoldDesktopLayout(currentRoute: currentRoute, body: body, title: title, actions: actions);
        }
      },
    );
  }
}
