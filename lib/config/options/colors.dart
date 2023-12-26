import 'dart:ui';

import 'package:meta/meta.dart';

@immutable
class TwColor {
  final Color color;

  const TwColor(this.color);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwColor &&
          runtimeType == other.runtimeType &&
          color == other.color;

  @override
  int get hashCode => color.hashCode ^ runtimeType.toString().hashCode;

  /// Returns the color as null if the color is transparent for tweening.
  /// See [ColorTween] for more details.
  Color? get tweenColor => color == const Color(0x00000000) ? null : color;

  @override
  String toString() {
    return 'TwColor{color: $color}';
  }
}

/// A color that is used for the background of an element.
/// https://tailwindcss.com/docs/background-color
@immutable
class TwBackgroundColor extends TwColor {
  const TwBackgroundColor(super.color);

  static TwBackgroundColor? fromColor(final Color? color) =>
      color != null ? TwBackgroundColor(color) : null;

  @override
  String toString() {
    return 'TwBackgroundColor{$color}';
  }
}

/// A color that is used for the box shadow of an element.
/// https://tailwindcss.com/docs/box-shadow-color
@immutable
class TwBoxShadowColor extends TwColor {
  const TwBoxShadowColor(super.color);

  static TwBoxShadowColor? fromColor(final Color? color) =>
      color != null ? TwBoxShadowColor(color) : null;

  @override
  String toString() {
    return 'TwBoxShadowColor{$color}';
  }
}

/// A color that is used for the border of an element.
/// https://tailwindcss.com/docs/border-color
@immutable
class TwBorderColor extends TwColor {
  const TwBorderColor(super.color);

  static TwBorderColor? fromColor(final Color? color) =>
      color != null ? TwBorderColor(color) : null;

  @override
  String toString() {
    return 'TwBorderColor{$color}';
  }
}

/// A color that is used for the text of an element.
/// https://tailwindcss.com/docs/text-color
@immutable
class TwTextColor extends TwColor {
  const TwTextColor(super.color);

  static TwTextColor? fromColor(final Color? color) =>
      color != null ? TwTextColor(color) : null;

  @override
  String toString() {
    return 'TwTextColor{$color}';
  }
}

/// A color that is used for the text decoration of an element.
/// https://tailwindcss.com/docs/text-decoration
@immutable
class TwTextDecorationColor extends TwColor {
  const TwTextDecorationColor(super.color);

  static TwTextDecorationColor? fromColor(final Color? color) =>
      color != null ? TwTextDecorationColor(color) : null;

  @override
  String toString() {
    return 'TwTextDecorationColor{$color}';
  }
}
