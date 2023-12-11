import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/colors.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwBoxShadow {
  final TwBoxShadowColor color;
  final TwUnit offsetX;
  final TwUnit offsetY;
  final TwUnit blurRadius;
  final TwUnit spreadRadius;

  const TwBoxShadow({
    required this.color,
    required this.offsetX,
    required this.offsetY,
    required this.blurRadius,
    required this.spreadRadius,
  });

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBoxShadow &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          offsetX == other.offsetX &&
          offsetY == other.offsetY &&
          blurRadius == other.blurRadius &&
          spreadRadius == other.spreadRadius;

  @override
  int get hashCode =>
      color.hashCode ^
      offsetX.hashCode ^
      offsetY.hashCode ^
      blurRadius.hashCode ^
      spreadRadius.hashCode;
}

@immutable
class TwBoxShadows {
  final List<TwBoxShadow> boxShadows;

  const TwBoxShadows(this.boxShadows);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBoxShadows &&
          runtimeType == other.runtimeType &&
          boxShadows == other.boxShadows;

  @override
  int get hashCode => boxShadows.hashCode;
}
