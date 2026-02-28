import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.variant = GlassVariant.dark,
    this.blur = 22.0,
    this.borderRadius,
    this.padding,
    this.margin,

    this.fillColor,
    this.borderColor,
  });

  final Widget child;

  final GlassVariant variant;

  final double blur;

  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final Color? fillColor;

  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final defaultRadius =
        borderRadius ??
        BorderRadius.circular(variant == GlassVariant.light ? 20.0 : 8.0);

    final resolvedFill = fillColor ?? variant._defaultFill;
    final resolvedBorder = borderColor ?? variant._defaultBorder;

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: defaultRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: resolvedFill,
              borderRadius: defaultRadius,
              border: Border.all(color: resolvedBorder, width: 1),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

enum GlassVariant {
  light,

  dark;

  Color get _defaultFill => switch (this) {
    GlassVariant.light => const Color(0xB3FFFFFF),
    GlassVariant.dark => const Color(0x1AFFFFFF),
  };

  Color get _defaultBorder => switch (this) {
    GlassVariant.light => const Color(0x33FFFFFF),
    GlassVariant.dark => const Color(0x1AFFFFFF),
  };
}
