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
}

/// A color that is used for the background of an element.
/// https://tailwindcss.com/docs/background-color
@immutable
class TwBackgroundColor extends TwColor {
  const TwBackgroundColor(super.color);
}

/// A color that is used for the box shadow of an element.
/// https://tailwindcss.com/docs/box-shadow-color
@immutable
class TwBoxShadowColor extends TwColor {
  const TwBoxShadowColor(super.color);
}

/// A color that is used for the border of an element.
/// https://tailwindcss.com/docs/border-color
@immutable
class TwBorderColor extends TwColor {
  const TwBorderColor(super.color);
}

/// A color that is used for the text of an element.
/// https://tailwindcss.com/docs/text-color
@immutable
class TwTextColor extends TwColor {
  const TwTextColor(super.color);
}
