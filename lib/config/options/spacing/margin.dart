import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwMarginTop {
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
}
