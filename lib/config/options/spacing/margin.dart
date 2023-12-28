import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwMarginTop {
  final CssAbsoluteUnit value;

  const TwMarginTop(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMarginTop &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwMarginRight {
  final CssAbsoluteUnit value;

  const TwMarginRight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMarginRight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwMarginBottom {
  final CssAbsoluteUnit value;

  const TwMarginBottom(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMarginBottom &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwMarginLeft {
  final CssAbsoluteUnit value;

  const TwMarginLeft(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMarginLeft &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwMarginAll {
  final CssAbsoluteUnit value;

  const TwMarginAll(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMarginAll &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwMarginX {
  final CssAbsoluteUnit value;

  const TwMarginX(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMarginX &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwMarginY {
  final CssAbsoluteUnit value;

  const TwMarginY(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMarginY &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwMargin {
  final TwMarginTop top;
  final TwMarginRight right;
  final TwMarginBottom bottom;
  final TwMarginLeft left;
  final TwMarginAll all;
  final TwMarginX x;
  final TwMarginY y;
  final BoxSideType type;

  const TwMargin.all(final TwMarginAll margin)
      : top = const TwMarginTop(PxUnit(0)),
        right = const TwMarginRight(PxUnit(0)),
        bottom = const TwMarginBottom(PxUnit(0)),
        left = const TwMarginLeft(PxUnit(0)),
        x = const TwMarginX(PxUnit(0)),
        y = const TwMarginY(PxUnit(0)),
        all = margin,
        type = BoxSideType.all;

  const TwMargin.x(final TwMarginX margin)
      : top = const TwMarginTop(PxUnit(0)),
        right = const TwMarginRight(PxUnit(0)),
        bottom = const TwMarginBottom(PxUnit(0)),
        left = const TwMarginLeft(PxUnit(0)),
        x = margin,
        y = const TwMarginY(PxUnit(0)),
        all = const TwMarginAll(PxUnit(0)),
        type = BoxSideType.x;

  const TwMargin.y(final TwMarginY margin)
      : top = const TwMarginTop(PxUnit(0)),
        right = const TwMarginRight(PxUnit(0)),
        bottom = const TwMarginBottom(PxUnit(0)),
        left = const TwMarginLeft(PxUnit(0)),
        x = const TwMarginX(PxUnit(0)),
        y = margin,
        all = const TwMarginAll(PxUnit(0)),
        type = BoxSideType.y;

  const TwMargin.xy(this.x, this.y)
      : top = const TwMarginTop(PxUnit(0)),
        right = const TwMarginRight(PxUnit(0)),
        bottom = const TwMarginBottom(PxUnit(0)),
        left = const TwMarginLeft(PxUnit(0)),
        all = const TwMarginAll(PxUnit(0)),
        type = BoxSideType.xy;

  const TwMargin({
    this.top = const TwMarginTop(PxUnit(0)),
    this.right = const TwMarginRight(PxUnit(0)),
    this.bottom = const TwMarginBottom(PxUnit(0)),
    this.left = const TwMarginLeft(PxUnit(0)),
  })  : x = const TwMarginX(PxUnit(0)),
        y = const TwMarginY(PxUnit(0)),
        all = const TwMarginAll(PxUnit(0)),
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
      other is TwMargin &&
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
        BoxSideType.all => 'TwMargin{all: ${all.value}}',
        BoxSideType.x => 'TwMargin{x: ${x.value}}',
        BoxSideType.y => 'TwMargin{y: ${y.value}}',
        BoxSideType.xy => 'TwMargin{x: ${x.value}, y: ${y.value}}',
        BoxSideType.trbl =>
          'TwMargin{top: ${top.value}, right: ${right.value}, bottom: ${bottom.value}, left: ${left.value}}',
      };
}
