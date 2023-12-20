import 'package:flutter/material.dart';
import 'package:tailwind_elements/base.dart';

/// A [CircleAvatar] widget wrapper with support for Tailwind styled properties.
@immutable
class TwCircleAvatar extends StatelessWidget {
  final Widget? child;
  final TwBackgroundColor? backgroundColor;
  final TwTextColor? textColor;
  final ImageProvider? backgroundImage;
  final ImageProvider? foregroundImage;
  final ImageErrorListener? onBackgroundImageError;
  final ImageErrorListener? onForegroundImageError;

  /// The full width of the circular avatar, in terms of a square. This is
  /// double the radius of the circle.
  final TwWidth? width;

  const TwCircleAvatar({
    this.child,
    this.backgroundColor,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.textColor,
    this.width,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final width = this.width;
    return CircleAvatar(
      backgroundColor: backgroundColor?.color,
      backgroundImage: backgroundImage,
      foregroundImage: foregroundImage,
      onBackgroundImageError: onBackgroundImageError,
      onForegroundImageError: onForegroundImageError,
      foregroundColor: textColor?.color,
      radius: width != null ? width.value.logicalPixels / 2 : 0,
      child: child,
    );
  }
}
