import 'package:breeze_ui/config/options/colors.dart';
import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';

@immutable
class TwBoxShadows {
  final List<BoxShadow> boxShadows;

  const TwBoxShadows(this.boxShadows);

  static TwBoxShadows? fromBoxShadows(final List<BoxShadow>? boxShadows) =>
      boxShadows != null && boxShadows.isNotEmpty
          ? TwBoxShadows(boxShadows)
          : null;

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBoxShadows &&
          runtimeType == other.runtimeType &&
          boxShadows == other.boxShadows;

  @override
  int get hashCode => boxShadows.hashCode;

  Color? get firstColor {
    if (boxShadows.isEmpty) return null;
    return boxShadows.firstOrNull?.color;
  }

  List<BoxShadow> withColor(final TwBoxShadowColor? color) {
    if (color == null) {
      return boxShadows;
    }
    return boxShadows
        .map(
          (final BoxShadow boxShadow) => BoxShadow(
            color: color.color,
            offset: boxShadow.offset,
            blurRadius: boxShadow.blurRadius,
            spreadRadius: boxShadow.spreadRadius,
          ),
        )
        .toList();
  }

  @override
  String toString() {
    return 'TwBoxShadows{boxShadows: $boxShadows}';
  }
}
