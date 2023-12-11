import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwBorderRadiusTopLeft {
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit value;

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
  final TwUnit topLeft;
  final TwUnit topRight;
  final TwUnit bottomRight;
  final TwUnit bottomLeft;

  const TwBorderRadiusAll(final TwUnit all)
      : topLeft = all,
        topRight = all,
        bottomRight = all,
        bottomLeft = all;

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBorderRadiusAll &&
          runtimeType == other.runtimeType &&
          topLeft == other.topLeft &&
          topRight == other.topRight &&
          bottomRight == other.bottomRight &&
          bottomLeft == other.bottomLeft;

  @override
  int get hashCode =>
      topLeft.hashCode ^
      topRight.hashCode ^
      bottomRight.hashCode ^
      bottomLeft.hashCode;
}

@immutable
class TwBorderRadius {
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
}
