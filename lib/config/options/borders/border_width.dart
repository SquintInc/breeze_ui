import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwBorderTop {
  final TwUnit value;

  const TwBorderTop(this.value);

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
  final TwUnit value;

  const TwBorderRight(this.value);

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
  final TwUnit value;

  const TwBorderBottom(this.value);

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
  final TwUnit value;

  const TwBorderLeft(this.value);

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
  final TwUnit top;
  final TwUnit right;
  final TwUnit bottom;
  final TwUnit left;

  const TwBorderAll(final TwUnit all)
      : top = all,
        right = all,
        bottom = all,
        left = all;

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderAll &&
          runtimeType == other.runtimeType &&
          top == other.top &&
          right == other.right &&
          bottom == other.bottom &&
          left == other.left;

  @override
  int get hashCode =>
      top.hashCode ^ right.hashCode ^ bottom.hashCode ^ left.hashCode;
}

@immutable
class TwBorderX {
  final TwUnit value;

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
  final TwUnit value;

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
}
