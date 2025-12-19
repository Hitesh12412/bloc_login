
import 'package:flutter/material.dart';

class SurfaceContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final List<BoxShadow>? boxShadow;
  final BoxConstraints? constraints;

  const SurfaceContainer({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.radius = 16,
    this.boxShadow,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultShadow = BoxShadow(
      color: isDark ? Colors.black.withOpacity(0.6) : Colors.grey.withOpacity(0.2),
      blurRadius: 10,
      offset: const Offset(0, 4),
    );

    return Container(
      constraints: constraints,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: boxShadow ?? [defaultShadow],
      ),
      child: child,
    );
  }
}
