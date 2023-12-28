import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwBorderTop {
  final CssAbsoluteUnit value;

  const TwBorderTop(this.value);

  static TwBorderTop fromPx(final double? pixels) {
    return TwBorderTop(PxUnit(pixels ?? 0));
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderTop &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderRight {
  final CssAbsoluteUnit value;

  const TwBorderRight(this.value);

  static TwBorderRight fromPx(final double? px) {
    return TwBorderRight(PxUnit(px ?? 0));
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderBottom {
  final CssAbsoluteUnit value;

  const TwBorderBottom(this.value);

  static TwBorderBottom fromPx(final double? px) {
    return TwBorderBottom(PxUnit(px ?? 0));
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderBottom &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderLeft {
  final CssAbsoluteUnit value;

  const TwBorderLeft(this.value);

  static TwBorderLeft fromPx(final double? px) {
    return TwBorderLeft(PxUnit(px ?? 0));
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderLeft &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderAll {
  final CssAbsoluteUnit value;

  const TwBorderAll(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderAll &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderX {
  final CssAbsoluteUnit value;

  const TwBorderX(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderX &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class TwBorderY {
  final CssAbsoluteUnit value;

  const TwBorderY(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderY &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
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
          width: all.value.pixels(),
          strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
        ),
      BoxSideType.trbl => Border(
          top: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: top.value.pixels(),
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
          right: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: right.value.pixels(),
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
          bottom: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: bottom.value.pixels(),
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
          left: BorderSide(
            color: borderColor ?? const Color(0xFF000000),
            width: left.value.pixels(),
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
        ),
      BoxSideType.x || BoxSideType.y || BoxSideType.xy => Border.symmetric(
          horizontal: x.value.pixels() > 0
              ? BorderSide(
                  color: borderColor ?? const Color(0xFF000000),
                  width: x.value.pixels(),
                  strokeAlign:
                      borderStrokeAlign ?? BorderSide.strokeAlignInside,
                )
              : BorderSide.none,
          vertical: y.value.pixels() > 0
              ? BorderSide(
                  color: borderColor ?? const Color(0xFF000000),
                  width: y.value.pixels(),
                  strokeAlign:
                      borderStrokeAlign ?? BorderSide.strokeAlignInside,
                )
              : BorderSide.none,
        ),
    };
  }

  bool get isEmpty => switch (type) {
        BoxSideType.all => all.value.pixels() == 0,
        BoxSideType.trbl => top.value.pixels() == 0 &&
            right.value.pixels() == 0 &&
            bottom.value.pixels() == 0 &&
            left.value.pixels() == 0,
        BoxSideType.x => x.value.pixels() == 0,
        BoxSideType.y => y.value.pixels() == 0,
        BoxSideType.xy => x.value.pixels() == 0 && y.value.pixels() == 0,
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
        BoxSideType.all => all.value.pixels(),
        BoxSideType.trbl => top.value.pixels(),
        BoxSideType.y || BoxSideType.xy => y.value.pixels(),
        _ => 0,
      };

  double get bottomPx => switch (type) {
        BoxSideType.all => all.value.pixels(),
        BoxSideType.trbl => bottom.value.pixels(),
        BoxSideType.y || BoxSideType.xy => y.value.pixels(),
        _ => 0,
      };

  double get leftPx => switch (type) {
        BoxSideType.all => all.value.pixels(),
        BoxSideType.trbl => left.value.pixels(),
        BoxSideType.x || BoxSideType.xy => x.value.pixels(),
        _ => 0,
      };

  double get rightPx => switch (type) {
        BoxSideType.all => all.value.pixels(),
        BoxSideType.trbl => right.value.pixels(),
        BoxSideType.x || BoxSideType.xy => x.value.pixels(),
        _ => 0,
      };

  @override
  String toString() => switch (type) {
        BoxSideType.all => 'TwBorder{all: ${all.value}}',
        BoxSideType.trbl =>
          'TwBorder{top: ${top.value}, right: ${right.value}, bottom: ${bottom.value}, left: ${left.value}}',
        BoxSideType.x => 'TwBorder{x: ${x.value}}',
        BoxSideType.y => 'TwBorder{y: ${y.value}}',
        BoxSideType.xy => 'TwBorder{x: ${x.value}, y: ${y.value}}',
      };
}
