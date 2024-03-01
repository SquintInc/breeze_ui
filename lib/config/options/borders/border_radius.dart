import 'dart:math';

import 'package:breeze_ui/config/options/box_types.dart';
import 'package:breeze_ui/config/options/units.dart';
import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';

@immutable
class TwBorderRadiusTopLeft {
  final CssAbsoluteUnit value;

  const TwBorderRadiusTopLeft(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusTopLeft &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRadiusTopRight {
  final CssAbsoluteUnit value;

  const TwBorderRadiusTopRight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusTopRight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRadiusBottomLeft {
  final CssAbsoluteUnit value;

  const TwBorderRadiusBottomLeft(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusBottomLeft &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRadiusBottomRight {
  final CssAbsoluteUnit value;

  const TwBorderRadiusBottomRight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusBottomRight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRadiusTop {
  final CssAbsoluteUnit value;

  const TwBorderRadiusTop(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusTop &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRadiusRight {
  final CssAbsoluteUnit value;

  const TwBorderRadiusRight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusRight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRadiusBottom {
  final CssAbsoluteUnit value;

  const TwBorderRadiusBottom(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusBottom &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRadiusLeft {
  final CssAbsoluteUnit value;

  const TwBorderRadiusLeft(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusLeft &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRadiusAll {
  final CssAbsoluteUnit value;

  const TwBorderRadiusAll(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusAll &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRadius {
  /// Full radius value in pixels, 'rounded-full', taken from
  /// https://tailwindcss.com/docs/border-radius
  static const double fullRadiusPx = 9999.0;

  /// Full radius value in pixel units using [fullRadiusPx].
  static const PxUnit fullRadius = PxUnit(fullRadiusPx);

  // When [type] is [BoxCornerType.tltrbrbl]
  final TwBorderRadiusTopLeft topLeft;
  final TwBorderRadiusTopRight topRight;
  final TwBorderRadiusBottomRight bottomRight;
  final TwBorderRadiusBottomLeft bottomLeft;

  // When [type] is [BoxCornerType.trbl]
  final TwBorderRadiusTop top;
  final TwBorderRadiusRight right;
  final TwBorderRadiusBottom bottom;
  final TwBorderRadiusLeft left;

  // When [type] is [BoxCornerType.all]
  final TwBorderRadiusAll all;

  final BoxCornerType type;

  const TwBorderRadius.all(final TwBorderRadiusAll borderRadius)
      : top = const TwBorderRadiusTop(PxUnit(0)),
        right = const TwBorderRadiusRight(PxUnit(0)),
        bottom = const TwBorderRadiusBottom(PxUnit(0)),
        left = const TwBorderRadiusLeft(PxUnit(0)),
        topLeft = const TwBorderRadiusTopLeft(PxUnit(0)),
        topRight = const TwBorderRadiusTopRight(PxUnit(0)),
        bottomRight = const TwBorderRadiusBottomRight(PxUnit(0)),
        bottomLeft = const TwBorderRadiusBottomLeft(PxUnit(0)),
        all = borderRadius,
        type = BoxCornerType.all;

  const TwBorderRadius.side({
    this.top = const TwBorderRadiusTop(PxUnit(0)),
    this.right = const TwBorderRadiusRight(PxUnit(0)),
    this.bottom = const TwBorderRadiusBottom(PxUnit(0)),
    this.left = const TwBorderRadiusLeft(PxUnit(0)),
  })  : topLeft = const TwBorderRadiusTopLeft(PxUnit(0)),
        topRight = const TwBorderRadiusTopRight(PxUnit(0)),
        bottomRight = const TwBorderRadiusBottomRight(PxUnit(0)),
        bottomLeft = const TwBorderRadiusBottomLeft(PxUnit(0)),
        all = const TwBorderRadiusAll(PxUnit(0)),
        type = BoxCornerType.trbl;

  const TwBorderRadius.corner({
    this.topLeft = const TwBorderRadiusTopLeft(PxUnit(0)),
    this.topRight = const TwBorderRadiusTopRight(PxUnit(0)),
    this.bottomRight = const TwBorderRadiusBottomRight(PxUnit(0)),
    this.bottomLeft = const TwBorderRadiusBottomLeft(PxUnit(0)),
  })  : top = const TwBorderRadiusTop(PxUnit(0)),
        right = const TwBorderRadiusRight(PxUnit(0)),
        bottom = const TwBorderRadiusBottom(PxUnit(0)),
        left = const TwBorderRadiusLeft(PxUnit(0)),
        all = const TwBorderRadiusAll(PxUnit(0)),
        type = BoxCornerType.tltrbrbl;

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadius &&
          runtimeType == other.runtimeType &&
          topLeft == other.topLeft &&
          topRight == other.topRight &&
          bottomRight == other.bottomRight &&
          bottomLeft == other.bottomLeft &&
          top == other.top &&
          right == other.right &&
          bottom == other.bottom &&
          left == other.left &&
          all == other.all &&
          type == other.type;

  @override
  int get hashCode =>
      topLeft.hashCode ^
      topRight.hashCode ^
      bottomRight.hashCode ^
      bottomLeft.hashCode ^
      top.hashCode ^
      right.hashCode ^
      bottom.hashCode ^
      left.hashCode ^
      all.hashCode ^
      type.hashCode;

  static TwBorderRadius? fromBorderRadius(final BorderRadius? borderRadius) {
    if (borderRadius == null) return null;
    return TwBorderRadius.corner(
      topLeft: TwBorderRadiusTopLeft(PxUnit(borderRadius.topLeft.x)),
      topRight: TwBorderRadiusTopRight(PxUnit(borderRadius.topRight.x)),
      bottomRight:
          TwBorderRadiusBottomRight(PxUnit(borderRadius.bottomRight.x)),
      bottomLeft: TwBorderRadiusBottomLeft(PxUnit(borderRadius.bottomLeft.x)),
    );
  }

  BorderRadius toBorderRadius() => switch (type) {
        BoxCornerType.all => BorderRadius.circular(all.value.pixels()),
        BoxCornerType.tltrbrbl => BorderRadius.only(
            topLeft: topLeft.value.pixels() > 0
                ? Radius.circular(topLeft.value.pixels())
                : Radius.zero,
            topRight: topRight.value.pixels() > 0
                ? Radius.circular(topRight.value.pixels())
                : Radius.zero,
            bottomRight: bottomRight.value.pixels() > 0
                ? Radius.circular(bottomRight.value.pixels())
                : Radius.zero,
            bottomLeft: bottomLeft.value.pixels() > 0
                ? Radius.circular(bottomLeft.value.pixels())
                : Radius.zero,
          ),
        BoxCornerType.trbl => BorderRadius.only(
            topLeft: Radius.circular(
              max(top.value.pixels(), left.value.pixels()),
            ),
            topRight: Radius.circular(
              max(top.value.pixels(), right.value.pixels()),
            ),
            bottomRight: Radius.circular(
              max(bottom.value.pixels(), right.value.pixels()),
            ),
            bottomLeft: Radius.circular(
              max(bottom.value.pixels(), left.value.pixels()),
            ),
          )
      };

  bool get isCircle => switch (type) {
        BoxCornerType.all => all.value == fullRadius,
        BoxCornerType.trbl => top.value == right.value &&
            top.value == bottom.value &&
            top.value == left.value &&
            top.value == fullRadius,
        BoxCornerType.tltrbrbl => topLeft.value == topRight.value &&
            topLeft.value == bottomRight.value &&
            topLeft.value == bottomLeft.value &&
            topLeft.value == fullRadius,
      };

  double get minRadius => switch (type) {
        BoxCornerType.all => all.value.pixels(),
        BoxCornerType.trbl => min(
            min(top.value.pixels(), right.value.pixels()),
            min(bottom.value.pixels(), left.value.pixels()),
          ),
        BoxCornerType.tltrbrbl => min(
            min(topLeft.value.pixels(), topRight.value.pixels()),
            min(
              bottomRight.value.pixels(),
              bottomLeft.value.pixels(),
            ),
          ),
      };

  @override
  String toString() => switch (type) {
        BoxCornerType.all => 'TwBorderRadius{all: ${all.value}}',
        BoxCornerType.trbl =>
          'TwBorderRadius{top: ${top.value}, right: ${right.value}, bottom: ${bottom.value}, left: ${left.value}}',
        BoxCornerType.tltrbrbl =>
          'TwBorderRadius{topLeft: ${topLeft.value}, topRight: ${topRight.value}, bottomRight: ${bottomRight.value}, bottomLeft: ${bottomLeft.value}}',
      };
}
