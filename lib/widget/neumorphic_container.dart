
import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double depth; 
  final Color? color;

  const NeumorphicContainer({
    Key? key,
    required this.child,
    this.radius = 14,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.depth = 6,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = color ?? theme.cardColor;

    
    final topShadow = BoxShadow(
      color: isDark ? Colors.black.withOpacity(0.6) : Colors.white.withOpacity(0.8),
      offset: Offset(-depth / 3, -depth / 3),
      blurRadius: depth * 1.5,
    );
    final bottomShadow = BoxShadow(
      color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.08),
      offset: Offset(depth / 2, depth / 2),
      blurRadius: depth * 1.8,
    );

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [topShadow, bottomShadow],
      ),
      child: child,
    );
  }
}
