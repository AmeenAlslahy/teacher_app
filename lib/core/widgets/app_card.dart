import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? boxShadow;
  final bool isAnimated;
  
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.onTap,
    this.borderRadius,
    this.boxShadow,
    this.isAnimated = false,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
    
    if (onTap == null) return card;
    
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      child: card,
    );
  }
}
