import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/config/options/sizing/gap.dart';
import 'package:tailwind_elements/config/options/units/measurement_unit.dart';

/// Wrapper for [Wrap] on the horizontal axis with support for Tailwind styled gap spacing.
class TwWrapX extends Wrap {
  final TwGapX gap;
  final TwGapY? gapVertical;

  @override
  double get spacing => (gap.value as CssAbsoluteUnit).pixels();

  @override
  double get runSpacing => gapVertical != null
      ? (gapVertical!.value as CssAbsoluteUnit).pixels()
      : 0.0;

  const TwWrapX({
    required this.gap,
    this.gapVertical,
    super.alignment = WrapAlignment.start,
    super.runAlignment = WrapAlignment.start,
    super.crossAxisAlignment = WrapCrossAlignment.start,
    super.textDirection,
    super.verticalDirection = VerticalDirection.down,
    super.clipBehavior = Clip.none,
    super.children,
    super.key,
  }) : super(
          direction: Axis.horizontal,
        );
}

/// Wrapper for [Wrap] on the vertical axis with support for Tailwind styled gap spacing.
class TwWrapY extends Wrap {
  final TwGapY gap;
  final TwGapX? gapHorizontal;

  @override
  double get spacing => (gap.value as CssAbsoluteUnit).pixels();

  @override
  double get runSpacing => gapHorizontal != null
      ? (gapHorizontal!.value as CssAbsoluteUnit).pixels()
      : 0.0;

  const TwWrapY({
    required this.gap,
    this.gapHorizontal,
    super.alignment = WrapAlignment.start,
    super.runAlignment = WrapAlignment.start,
    super.crossAxisAlignment = WrapCrossAlignment.start,
    super.textDirection,
    super.verticalDirection = VerticalDirection.down,
    super.clipBehavior = Clip.none,
    super.children,
    super.key,
  }) : super(
          direction: Axis.vertical,
        );
}
