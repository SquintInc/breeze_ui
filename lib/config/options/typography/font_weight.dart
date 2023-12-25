import 'dart:ui';

import 'package:meta/meta.dart';

@immutable
class TwFontWeight {
  final int weight;

  const TwFontWeight(this.weight);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwFontWeight &&
          runtimeType == other.runtimeType &&
          weight == other.weight;

  @override
  int get hashCode => weight.hashCode;

  FontWeight get fontWeight {
    if (weight == 100) {
      return FontWeight.w100;
    } else if (weight == 200) {
      return FontWeight.w200;
    } else if (weight == 300) {
      return FontWeight.w300;
    } else if (weight == 400) {
      return FontWeight.w400;
    } else if (weight == 500) {
      return FontWeight.w500;
    } else if (weight == 600) {
      return FontWeight.w600;
    } else if (weight == 700) {
      return FontWeight.w700;
    } else if (weight == 800) {
      return FontWeight.w800;
    } else if (weight == 900) {
      return FontWeight.w900;
    }
    return FontWeight.w400;
  }
}
