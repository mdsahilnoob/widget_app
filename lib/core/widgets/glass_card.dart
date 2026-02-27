import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable glassmorphism card that uses [BackdropFilter] to blur content
/// behind it and overlays a translucent fill with a thin frosted border.
///
/// Works well on top of any image, gradient, or colourful background.
/// On dark backgrounds (Nothing / OnePlus) use [GlassVariant.dark]; on
/// light backgrounds (iOS) use [GlassVariant.light].
///
/// ```dart
/// GlassCard(
///   variant: GlassVariant.light,
///   child: Text('Frosted'),
/// )
/// ```
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.variant = GlassVariant.dark,
    this.blur = 22.0,
    this.borderRadius,
    this.padding,
    this.margin,
    // Advanced overrides — leave null to use [variant] defaults.
    this.fillColor,
    this.borderColor,
  });

  final Widget child;

  /// Preset that controls the default [fillColor] and [borderColor].
  final GlassVariant variant;

  /// Gaussian blur radius applied behind the card. Default: `22`.
  final double blur;

  /// Corner radius. Defaults to `20` for [GlassVariant.light] and `8` for
  /// [GlassVariant.dark].
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  /// Override the semi-transparent fill colour.
  final Color? fillColor;

  /// Override the border colour.
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

/// Preset fill/border colours for [GlassCard].
enum GlassVariant {
  /// Translucent white — designed for frosted looks on light (iOS) backgrounds.
  light,

  /// Translucent white with low opacity — designed for dark (Nothing / OnePlus)
  /// backgrounds.
  dark;

  Color get _defaultFill => switch (this) {
    GlassVariant.light => const Color(0xB3FFFFFF), // ~70 % white
    GlassVariant.dark => const Color(0x1AFFFFFF), // ~10 % white
  };

  Color get _defaultBorder => switch (this) {
    GlassVariant.light => const Color(0x33FFFFFF), // 20 % white
    GlassVariant.dark => const Color(0x1AFFFFFF), // 10 % white
  };
}
