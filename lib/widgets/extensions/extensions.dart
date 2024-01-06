import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';

extension RadiusExt on BoxConstraints {
  double get circleRadius {
    final bool hasInfiniteHeight = maxHeight.isInfinite;
    final bool hasInfiniteWidth = maxWidth.isInfinite;
    if (hasInfiniteWidth && hasInfiniteHeight) {
      return TwBorderRadius.fullRadiusPx;
    }
    if (hasInfiniteWidth) {
      return (maxHeight / 2).ceilToDouble();
    }
    if (hasInfiniteHeight) {
      return (maxWidth / 2).ceilToDouble();
    }
    return (min(minWidth, minHeight) / 2).ceilToDouble();
  }
}
