import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwPaddingTop {
  final CssAbsoluteUnit value;

  const TwPaddingTop(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwPaddingTop &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwPaddingRight {
  final CssAbsoluteUnit value;

  const TwPaddingRight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwPaddingRight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwPaddingBottom {
  final CssAbsoluteUnit value;

  const TwPaddingBottom(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwPaddingBottom &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwPaddingLeft {
  final CssAbsoluteUnit value;

  const TwPaddingLeft(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwPaddingLeft &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwPaddingAll {
  final CssAbsoluteUnit value;

  const TwPaddingAll(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwPaddingAll &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwPaddingX {
  final CssAbsoluteUnit value;

  const TwPaddingX(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwPaddingX &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwPaddingY {
  final CssAbsoluteUnit value;

  const TwPaddingY(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwPaddingY &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwPadding {
  final TwPaddingTop top;
  final TwPaddingRight right;
  final TwPaddingBottom bottom;
  final TwPaddingLeft left;
  final TwPaddingAll all;
  final TwPaddingX x;
  final TwPaddingY y;
  final BoxSideType type;

  const TwPadding.all(final TwPaddingAll padding)
      : top = const TwPaddingTop(PxUnit(0)),
        right = const TwPaddingRight(PxUnit(0)),
        bottom = const TwPaddingBottom(PxUnit(0)),
        left = const TwPaddingLeft(PxUnit(0)),
        x = const TwPaddingX(PxUnit(0)),
        y = const TwPaddingY(PxUnit(0)),
        all = padding,
        type = BoxSideType.all;

  const TwPadding.x(final TwPaddingX padding)
      : top = const TwPaddingTop(PxUnit(0)),
        right = const TwPaddingRight(PxUnit(0)),
        bottom = const TwPaddingBottom(PxUnit(0)),
        left = const TwPaddingLeft(PxUnit(0)),
        x = padding,
        y = const TwPaddingY(PxUnit(0)),
        all = const TwPaddingAll(PxUnit(0)),
        type = BoxSideType.x;

  const TwPadding.y(final TwPaddingY padding)
      : top = const TwPaddingTop(PxUnit(0)),
        right = const TwPaddingRight(PxUnit(0)),
        bottom = const TwPaddingBottom(PxUnit(0)),
        left = const TwPaddingLeft(PxUnit(0)),
        x = const TwPaddingX(PxUnit(0)),
        y = padding,
        all = const TwPaddingAll(PxUnit(0)),
        type = BoxSideType.y;

  const TwPadding.xy(this.x, this.y)
      : top = const TwPaddingTop(PxUnit(0)),
        right = const TwPaddingRight(PxUnit(0)),
        bottom = const TwPaddingBottom(PxUnit(0)),
        left = const TwPaddingLeft(PxUnit(0)),
        all = const TwPaddingAll(PxUnit(0)),
        type = BoxSideType.xy;

  const TwPadding({
    this.top = const TwPaddingTop(PxUnit(0)),
    this.right = const TwPaddingRight(PxUnit(0)),
    this.bottom = const TwPaddingBottom(PxUnit(0)),
    this.left = const TwPaddingLeft(PxUnit(0)),
  })  : x = const TwPaddingX(PxUnit(0)),
        y = const TwPaddingY(PxUnit(0)),
        all = const TwPaddingAll(PxUnit(0)),
        type = BoxSideType.trbl;

  EdgeInsetsGeometry toEdgeInsets() => switch (type) {
        BoxSideType.all => EdgeInsets.all(all.value.pixels()),
        BoxSideType.trbl => EdgeInsets.only(
            top: top.value.pixels(),
            right: right.value.pixels(),
            bottom: bottom.value.pixels(),
            left: left.value.pixels(),
          ),
        BoxSideType.x ||
        BoxSideType.y ||
        BoxSideType.xy =>
          EdgeInsets.symmetric(
            horizontal: x.value.pixels(),
            vertical: y.value.pixels(),
          ),
      };

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwPadding &&
          runtimeType == other.runtimeType &&
          top == other.top &&
          right == other.right &&
          bottom == other.bottom &&
          left == other.left &&
          all == other.all &&
          x == other.x &&
          y == other.y &&
          type == other.type;

  @override
  int get hashCode =>
      top.hashCode ^
      right.hashCode ^
      bottom.hashCode ^
      left.hashCode ^
      all.hashCode ^
      x.hashCode ^
      y.hashCode ^
      type.hashCode;

  @override
  String toString() => switch (type) {
        BoxSideType.all => 'TwPadding{all: ${all.value}}',
        BoxSideType.x => 'TwPadding{x: ${x.value}}',
        BoxSideType.y => 'TwPadding{y: ${y.value}}',
        BoxSideType.xy => 'TwPadding{x: ${x.value}, y: ${y.value}}',
        BoxSideType.trbl =>
          'TwPadding{top: ${top.value}, right: ${right.value}, bottom: ${bottom.value}, left: ${left.value}}',
      };
}
