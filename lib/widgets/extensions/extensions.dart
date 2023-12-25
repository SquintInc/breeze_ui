import 'dart:math';

import 'package:flutter/widgets.dart';

extension RadiusExt on BoxConstraints {
  double get circleRadius => (min(minWidth, minHeight) / 2).ceilToDouble();
}

extension BoxConstraintsExtension on BoxConstraints {
  double limitedMaxWidth(final BuildContext context) {
    return (maxWidth.isInfinite) ? MediaQuery.of(context).size.width : maxWidth;
  }
}
