import 'package:flutter/material.dart';

class RealtimeIndicator extends StatefulWidget {
  const RealtimeIndicator({super.key});

  @override
  State<RealtimeIndicator> createState() => _RealtimeIndicatorState();
}

class _RealtimeIndicatorState extends State<RealtimeIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();

    _pulseAnimation = Tween<double>(
      begin: 1,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        Text(
          'Live',
          style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
