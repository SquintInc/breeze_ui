import 'package:flutter/painting.dart';
import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/colors.dart';

@immutable
class TwBoxShadows {
  final List<BoxShadow> boxShadows;

  const TwBoxShadows(this.boxShadows);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwBoxShadows &&
          runtimeType == other.runtimeType &&
          boxShadows == other.boxShadows;

  @override
  int get hashCode => boxShadows.hashCode;

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
}
