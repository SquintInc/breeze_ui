import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwBorderTop {
  final PxUnit pixels;

  const TwBorderTop(this.pixels);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderTop &&
          runtimeType == other.runtimeType &&
          pixels == other.pixels;

  @override
  int get hashCode => pixels.hashCode;
}

@immutable
class TwBorderRight {
  final PxUnit pixels;

  const TwBorderRight(this.pixels);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRight &&
          runtimeType == other.runtimeType &&
          pixels == other.pixels;

  @override
  int get hashCode => pixels.hashCode;
}

@immutable
class TwBorderBottom {
  final PxUnit pixels;

  const TwBorderBottom(this.pixels);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderBottom &&
          runtimeType == other.runtimeType &&
          pixels == other.pixels;

  @override
  int get hashCode => pixels.hashCode;
}

@immutable
class TwBorderLeft {
  final PxUnit pixels;

  const TwBorderLeft(this.pixels);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderLeft &&
          runtimeType == other.runtimeType &&
          pixels == other.pixels;

  @override
  int get hashCode => pixels.hashCode;
}

@immutable
class TwBorderAll {
  final PxUnit pixels;

  const TwBorderAll(this.pixels);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderAll &&
          runtimeType == other.runtimeType &&
          pixels == other.pixels;

  @override
  int get hashCode => pixels.hashCode;
}

@immutable
class TwBorderX {
  final PxUnit pixels;

  const TwBorderX(this.pixels);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderX &&
          runtimeType == other.runtimeType &&
          pixels == other.pixels;

  @override
  int get hashCode => pixels.hashCode;
}

@immutable
class TwBorderY {
  final PxUnit pixels;

  const TwBorderY(this.pixels);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderY &&
          runtimeType == other.runtimeType &&
          pixels == other.pixels;

  @override
  int get hashCode => pixels.hashCode;
}

@immutable
class TwBorder {
  final TwBorderTop top;
  final TwBorderRight right;
  final TwBorderBottom bottom;
  final TwBorderLeft left;
  final TwBorderAll all;
  final TwBorderX x;
  final TwBorderY y;
  final BoxSideType type;

  const TwBorder.all(final TwBorderAll border)
      : top = const TwBorderTop(PxUnit(0)),
        right = const TwBorderRight(PxUnit(0)),
        bottom = const TwBorderBottom(PxUnit(0)),
        left = const TwBorderLeft(PxUnit(0)),
        x = const TwBorderX(PxUnit(0)),
        y = const TwBorderY(PxUnit(0)),
        all = border,
        type = BoxSideType.all;

  const TwBorder.x(final TwBorderX border)
      : top = const TwBorderTop(PxUnit(0)),
        right = const TwBorderRight(PxUnit(0)),
        bottom = const TwBorderBottom(PxUnit(0)),
        left = const TwBorderLeft(PxUnit(0)),
        x = border,
        y = const TwBorderY(PxUnit(0)),
        all = const TwBorderAll(PxUnit(0)),
        type = BoxSideType.x;

  const TwBorder.y(final TwBorderY border)
      : top = const TwBorderTop(PxUnit(0)),
        right = const TwBorderRight(PxUnit(0)),
        bottom = const TwBorderBottom(PxUnit(0)),
        left = const TwBorderLeft(PxUnit(0)),
        x = const TwBorderX(PxUnit(0)),
        y = border,
        all = const TwBorderAll(PxUnit(0)),
        type = BoxSideType.y;

  const TwBorder.xy(this.x, this.y)
      : top = const TwBorderTop(PxUnit(0)),
        right = const TwBorderRight(PxUnit(0)),
        bottom = const TwBorderBottom(PxUnit(0)),
        left = const TwBorderLeft(PxUnit(0)),
        all = const TwBorderAll(PxUnit(0)),
        type = BoxSideType.xy;

  const TwBorder({
    this.top = const TwBorderTop(PxUnit(0)),
    this.right = const TwBorderRight(PxUnit(0)),
    this.bottom = const TwBorderBottom(PxUnit(0)),
    this.left = const TwBorderLeft(PxUnit(0)),
  })  : x = const TwBorderX(PxUnit(0)),
        y = const TwBorderY(PxUnit(0)),
        all = const TwBorderAll(PxUnit(0)),
        type = BoxSideType.trbl;

  Border? toBorder(
    final Color? borderColor,
    final double? borderStrokeAlign,
  ) {
    if (isEmpty) return null;

    return switch (type) {
      BoxSideType.all => Border.all(
          color: borderColor ?? const Color(0xFF000000),
          width: all.pixels.value,
          strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
        ),
      BoxSideType.trbl => Border(
          top: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: top.pixels.value,
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
          right: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: right.pixels.value,
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
          bottom: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: bottom.pixels.value,
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
          left: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: left.pixels.value,
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
        ),
      BoxSideType.x || BoxSideType.y || BoxSideType.xy => Border.symmetric(
          horizontal: x.pixels.value > 0
              ? BorderSide(
                  color: borderColor ?? const Color(0xFF000000),
                  width: x.pixels.value,
                  strokeAlign:
                      borderStrokeAlign ?? BorderSide.strokeAlignInside,
                )
              : BorderSide.none,
          vertical: y.pixels.value > 0
              ? BorderSide(
                  color: borderColor ?? const Color(0xFF000000),
                  width: y.pixels.value,
                  strokeAlign:
                      borderStrokeAlign ?? BorderSide.strokeAlignInside,
                )
              : BorderSide.none,
        ),
    };
  }

  bool get isEmpty => switch (type) {
        BoxSideType.all => all.pixels.value == 0,
        BoxSideType.trbl => top.pixels.value == 0 &&
            right.pixels.value == 0 &&
            bottom.pixels.value == 0 &&
            left.pixels.value == 0,
        BoxSideType.x => x.pixels.value == 0,
        BoxSideType.y => y.pixels.value == 0,
        BoxSideType.xy => x.pixels.value == 0 && y.pixels.value == 0,
      };

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorder &&
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

  double get topPx => switch (type) {
        BoxSideType.all => all.pixels.value,
        BoxSideType.trbl => top.pixels.value,
        BoxSideType.y || BoxSideType.xy => y.pixels.value,
        _ => 0,
      };

  double get bottomPx => switch (type) {
        BoxSideType.all => all.pixels.value,
        BoxSideType.trbl => bottom.pixels.value,
        BoxSideType.y || BoxSideType.xy => y.pixels.value,
        _ => 0,
      };

  double get leftPx => switch (type) {
        BoxSideType.all => all.pixels.value,
        BoxSideType.trbl => left.pixels.value,
        BoxSideType.x || BoxSideType.xy => x.pixels.value,
        _ => 0,
      };

  double get rightPx => switch (type) {
        BoxSideType.all => all.pixels.value,
        BoxSideType.trbl => right.pixels.value,
        BoxSideType.x || BoxSideType.xy => x.pixels.value,
        _ => 0,
      };

  @override
  String toString() => switch (type) {
        BoxSideType.all => 'TwBorder{all: ${all.pixels}}',
        BoxSideType.trbl =>
          'TwBorder{top: ${top.pixels}, right: ${right.pixels}, bottom: ${bottom.pixels}, left: ${left.pixels}}',
        BoxSideType.x => 'TwBorder{x: ${x.pixels}}',
        BoxSideType.y => 'TwBorder{y: ${y.pixels}}',
        BoxSideType.xy => 'TwBorder{x: ${x.pixels}, y: ${y.pixels}}',
      };
}
