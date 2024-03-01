import 'package:breeze_ui/config/options/units/measurement_unit.dart';
import 'package:breeze_ui/widgets/style/style.dart';
import 'package:flutter/widgets.dart';

/// Gets a [BoxConstraints] object that assumes usage of simple [PxUnit]
/// values.
BoxConstraints? tightenAbsoluteConstraints(
  final TwConstraints twConstraints,
  final double fontSizePx,
) {
  final width = switch (twConstraints.width?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.width!.value as CssAbsoluteUnit).pixels(),
    _ => null,
  };
  final height = switch (twConstraints.height?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.height!.value as CssAbsoluteUnit).pixels(),
    _ => null,
  };
  final constraints = twConstraints.getSimpleConstraints(fontSizePx);
  final fullConstraints = (width != null || height != null)
      ? constraints?.tighten(
            width: width,
            height: height,
          ) ??
          BoxConstraints.tightFor(
            width: width,
            height: height,
          )
      : constraints;
  return fullConstraints;
}

/// Computes the min and max sizing constraints for the given widget, using
/// the parent constraints. Then tightens the constraints using the given
/// width and height values if they exist.
BoxConstraints computeRelativeConstraints(
  final BuildContext context,
  final BoxConstraints parentConstraints,
  final TwConstraints twConstraints,
) {
  final minWidthPx = switch (twConstraints.minWidth?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.minWidth!.value as CssAbsoluteUnit).pixels(),
    PercentUnit() =>
      (twConstraints.minWidth!.value as PercentUnit).percentageFloat() *
          parentConstraints.maxWidth,
    ViewportUnit() ||
    SmallViewportUnit() ||
    LargeViewportUnit() ||
    DynamicViewportUnit() =>
      (twConstraints.minWidth!.value as CssRelativeUnit).percentageFloat() *
          MediaQuery.of(context).size.width,
    null => 0.0,
  };
  final minHeightPx = switch (twConstraints.minHeight?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.minHeight!.value as CssAbsoluteUnit).pixels(),
    PercentUnit() =>
      (twConstraints.minHeight!.value as PercentUnit).percentageFloat() *
          parentConstraints.maxHeight,
    ViewportUnit() ||
    SmallViewportUnit() ||
    LargeViewportUnit() ||
    DynamicViewportUnit() =>
      (twConstraints.minWidth!.value as CssRelativeUnit).percentageFloat() *
          MediaQuery.of(context).size.height,
    null => 0.0,
  };
  final maxWidthPx = switch (twConstraints.maxWidth?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.maxWidth!.value as CssAbsoluteUnit).pixels(),
    PercentUnit() =>
      (twConstraints.maxWidth!.value as PercentUnit).percentageFloat() *
          parentConstraints.maxWidth,
    ViewportUnit() ||
    SmallViewportUnit() ||
    LargeViewportUnit() ||
    DynamicViewportUnit() =>
      (twConstraints.maxWidth!.value as CssRelativeUnit).percentageFloat() *
          MediaQuery.of(context).size.width,
    null => double.infinity,
  };
  final maxHeightPx = switch (twConstraints.maxHeight?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.maxHeight!.value as CssAbsoluteUnit).pixels(),
    PercentUnit() =>
      (twConstraints.maxHeight!.value as PercentUnit).percentageFloat() *
          parentConstraints.maxHeight,
    ViewportUnit() ||
    SmallViewportUnit() ||
    LargeViewportUnit() ||
    DynamicViewportUnit() =>
      (twConstraints.maxHeight!.value as CssRelativeUnit).percentageFloat() *
          MediaQuery.of(context).size.height,
    null => double.infinity,
  };

  final constraints = BoxConstraints(
    minWidth: minWidthPx,
    minHeight: minHeightPx,
    maxWidth: maxWidthPx,
    maxHeight: maxHeightPx,
  );

  final widthPx = switch (twConstraints.width?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.width!.value as CssAbsoluteUnit).pixels(),
    PercentUnit() =>
      (twConstraints.width!.value as PercentUnit).percentageFloat() *
          parentConstraints.maxWidth,
    ViewportUnit() ||
    SmallViewportUnit() ||
    LargeViewportUnit() ||
    DynamicViewportUnit() =>
      (twConstraints.width!.value as CssRelativeUnit).percentageFloat() *
          MediaQuery.of(context).size.width,
    null => null,
  };
  final heightPx = switch (twConstraints.height?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.height!.value as CssAbsoluteUnit).pixels(),
    PercentUnit() =>
      (twConstraints.height!.value as PercentUnit).percentageFloat() *
          parentConstraints.maxHeight,
    ViewportUnit() ||
    SmallViewportUnit() ||
    LargeViewportUnit() ||
    DynamicViewportUnit() =>
      (twConstraints.height!.value as CssRelativeUnit).percentageFloat() *
          MediaQuery.of(context).size.height,
    null => null,
  };

  final tightConstraints = constraints.tighten(
    width: widthPx,
    height: heightPx,
  );

  return tightConstraints;
}
