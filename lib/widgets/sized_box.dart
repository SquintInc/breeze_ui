import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/config/options/sizing/height.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/config/options/units.dart';

/// A simple [SizedBox] wrapper with constrained width and height.
@immutable
class TwSizedBox extends SizedBox {
  final TwWidth? widthConstrained;
  final TwHeight? heightConstrained;

  const TwSizedBox({
    final TwWidth? width,
    final TwHeight? height,
    super.child,
    super.key,
  })  : widthConstrained = width,
        heightConstrained = height;

  /// Creates a box that will become as large as its parent allows.
  const TwSizedBox.expand({super.key, super.child})
      : widthConstrained = const TwWidth(PxUnit(double.infinity)),
        heightConstrained = const TwHeight(PxUnit(double.infinity));

  /// Creates a box that will become as small as its parent allows.
  const TwSizedBox.shrink({super.key, super.child})
      : widthConstrained = const TwWidth(PxUnit(0)),
        heightConstrained = const TwHeight(PxUnit(0));

  @override
  double? get width => widthConstrained?.value.logicalPixels;

  @override
  double? get height => heightConstrained?.value.logicalPixels;
}
