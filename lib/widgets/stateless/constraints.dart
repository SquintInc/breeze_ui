import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/config/options/units/measurement_unit.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

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
  final BoxConstraints parentConstraints,
  final TwConstraints twConstraints,
) {
  final minWidthPx = switch (twConstraints.minWidth?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.minWidth!.value as CssAbsoluteUnit).pixels(),
    CssRelativeUnit() =>
      (twConstraints.minWidth!.value as CssRelativeUnit).percentageFloat() *
          parentConstraints.maxWidth,
    _ => 0.0,
  };
  final minHeightPx = switch (twConstraints.minHeight?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.minHeight!.value as CssAbsoluteUnit).pixels(),
    CssRelativeUnit() =>
      (twConstraints.minHeight!.value as CssRelativeUnit).percentageFloat() *
          parentConstraints.maxHeight,
    _ => 0.0,
  };
  final maxWidthPx = switch (twConstraints.maxWidth?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.maxWidth!.value as CssAbsoluteUnit).pixels(),
    CssRelativeUnit() =>
      (twConstraints.maxWidth!.value as CssRelativeUnit).percentageFloat() *
          parentConstraints.maxWidth,
    _ => double.infinity,
  };
  final maxHeightPx = switch (twConstraints.maxHeight?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.maxHeight!.value as CssAbsoluteUnit).pixels(),
    CssRelativeUnit() =>
      (twConstraints.maxHeight!.value as CssRelativeUnit).percentageFloat() *
          parentConstraints.maxHeight,
    _ => double.infinity,
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
    CssRelativeUnit() =>
      (twConstraints.width!.value as CssRelativeUnit).percentageFloat() *
          parentConstraints.maxWidth,
    _ => null,
  };
  final heightPx = switch (twConstraints.height?.value) {
    CssAbsoluteUnit() =>
      (twConstraints.height!.value as CssAbsoluteUnit).pixels(),
    CssRelativeUnit() =>
      (twConstraints.height!.value as CssRelativeUnit).percentageFloat() *
          parentConstraints.maxHeight,
    _ => null,
  };

  final tightConstraints = constraints.tighten(
    width: widthPx,
    height: heightPx,
  );

  return tightConstraints;
}
