import 'package:flutter/material.dart';
import 'package:web3_ai_assistant/core/theme/app_spacing.dart';

/// A loading skeleton widget that shows a shimmer effect
class LoadingSkeleton extends StatefulWidget {

  const LoadingSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.margin,
  });

  factory LoadingSkeleton.card({
    double? height = 200,
    EdgeInsets? margin,
  }) {
    return LoadingSkeleton(
      height: height,
      borderRadius: BorderRadius.circular(16),
      margin: margin,
    );
  }

  factory LoadingSkeleton.text({
    double? width = 200,
    double height = 16,
    EdgeInsets? margin,
  }) {
    return LoadingSkeleton(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(4),
      margin: margin,
    );
  }
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.surfaceContainerHighest;
    final highlightColor = theme.colorScheme.surface;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment(-1.0 - _animation.value * 2, 0),
              end: Alignment(1.0 - _animation.value * 2, 0),
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}

/// A group of loading skeletons for common patterns
class LoadingSkeletonGroup extends StatelessWidget {

  const LoadingSkeletonGroup({
    super.key,
    this.itemCount = 3,
    this.spacing = AppSpacing.md,
    this.direction = Axis.vertical,
  });
  final int itemCount;
  final double spacing;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      itemCount,
      (index) => LoadingSkeleton.text(
        width: index == itemCount - 1 ? 150 : null,
      ),
    );

    if (direction == Axis.horizontal) {
      return Row(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0) SizedBox(width: spacing),
            Expanded(child: items[i]),
          ],
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i > 0) SizedBox(height: spacing),
          items[i],
        ],
      ],
    );
  }
}
