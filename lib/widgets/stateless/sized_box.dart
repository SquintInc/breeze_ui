import 'package:breeze_ui/config/options/sizing/height.dart';
import 'package:breeze_ui/config/options/sizing/width.dart';
import 'package:breeze_ui/config/options/units.dart';
import 'package:flutter/widgets.dart';

/// A simple, unstyled [SizedBox] wrapper with constrained width and height.
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
  double? get width => switch (widthConstrained?.value) {
        CssAbsoluteUnit() =>
          (widthConstrained!.value as CssAbsoluteUnit).pixels(),
        _ => null,
      };

  @override
  double? get height => switch (heightConstrained?.value) {
        CssAbsoluteUnit() =>
          (heightConstrained!.value as CssAbsoluteUnit).pixels(),
        _ => null,
      };
}
