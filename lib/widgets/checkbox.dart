import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/sizing/height.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements/widgets/state/animated_state.dart';
import 'package:tailwind_elements/widgets/state/state.dart';

/// A widget meant to represent a [Checkbox] with custom styling via Tailwind
/// styled properties.
///
/// NOTE: This widget does not support [minWidth], [minHeight], [maxWidth], nor [maxHeight]
/// constraints, and only takes in [width] and [height] values as [CssAbsoluteUnit]s.
/// Any sizing using [CssRelativeUnit]s will be ignored and will be assumed to be null instead.
@immutable
class TwCheckbox extends TwStatefulWidget {
  static const double minTapTargetSizePx = 48.0;
  static const double defaultCheckmarkSizePx = 16.0;

  /// Initial value of the checkbox.
  final bool? initialValue;

  /// Called when the internal selected state of the checkbox changes.
  final ValueChanged<bool>? onChanged;

  /// The square size of the inner checkmark icon. Defaults to 16.0 pixels, but supports any
  /// [CssAbsoluteUnit] and [CssRelativeUnit]. If using [CssRelativeUnit], the checkmark icon will
  /// scale to the min(width, height) value of the checkbox style.
  final TwWidth checkmarkSize;

  /// The tap target size of the checkbox widget, defaults to 48.0 pixels as per Material Design
  /// guidelines.
  final CssAbsoluteUnit tapTargetSize;

  /// Custom SVG asset to use for the checkmark icon.
  final BytesLoader? checkmarkSvg;

  const TwCheckbox({
    required this.initialValue,
    required this.onChanged,
    this.checkmarkSize = const TwWidth(PxUnit(defaultCheckmarkSizePx)),
    this.tapTargetSize = const PxUnit(minTapTargetSizePx),
    this.checkmarkSvg,
    super.style = const TwStyle(),
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    super.key,
    super.isDisabled,
  }) : super(
          isSelectable: true,
          onSelected: onChanged,
          gestureBehavior: HitTestBehavior.opaque,
        );

  @override
  State createState() => _CheckboxState();
}

class _CheckboxState extends TwAnimatedState<TwCheckbox> {
  @override
  void initState() {
    super.initState();
    isSelected = widget.initialValue ?? false;
  }

  EdgeInsetsGeometry? _paddingIncludingDecoration(final TwStyle style) {
    final padding = style.padding;
    final paddingEdgeInsets = padding?.toEdgeInsets();
    if (!style.hasBorderDecoration) return paddingEdgeInsets;
    final EdgeInsetsGeometry decorationPadding = style.border
            ?.toBorder(style.borderColor?.color, style.borderStrokeAlign)
            ?.dimensions ??
        EdgeInsets.zero;
    return (paddingEdgeInsets == null)
        ? decorationPadding
        : paddingEdgeInsets.add(decorationPadding);
  }

  BoxConstraints _getSizeConstraints(
    final double? widthPx,
    final double? heightPx,
  ) {
    return BoxConstraints(
      minWidth: widthPx ?? 0.0,
      maxWidth: widthPx ?? double.infinity,
      minHeight: heightPx ?? 0.0,
      maxHeight: heightPx ?? double.infinity,
    );
  }

  void _trackConstraintsForAnimation({
    required final BoxConstraints? constraints,
    required final TwStyle mergedStyle,
  }) {
    if (widget.hasTransitions && (animationController?.canAnimate ?? false)) {
      animationController?.updateTrackedConstraints(
        constraints: constraints,
        mergedStyle: mergedStyle,
      );
    }
  }

  @override
  Widget buildForState(final BuildContext context) {
    final mergedStyle = currentStyle;
    final double? widthPx =
        mergedStyle.width != null && mergedStyle.width!.value is CssAbsoluteUnit
            ? (mergedStyle.width!.value as CssAbsoluteUnit).pixels()
            : null;
    final double? heightPx = mergedStyle.height != null &&
            mergedStyle.height!.value is CssAbsoluteUnit
        ? (mergedStyle.height!.value as CssAbsoluteUnit).pixels()
        : null;
    final constraints = _getSizeConstraints(widthPx, heightPx);
    _trackConstraintsForAnimation(
      constraints: constraints,
      mergedStyle: mergedStyle,
    );

    final animatedStyle = mergedStyle.merge(animationController?.animatedStyle);
    final style = animatedStyle.copyWith(
      textColor: !isSelected ? const TwTextColor(Colors.transparent) : null,
    );
    final dynamicConstraints =
        animationController?.animatedBoxConstraints ?? constraints;
    final double? dynamicWidthPx = dynamicConstraints.maxWidth.isFinite
        ? dynamicConstraints.maxWidth
        : null;
    final double? dynamicHeightPx = dynamicConstraints.maxHeight.isFinite
        ? dynamicConstraints.maxHeight
        : null;

    final checkmarkSizePx = switch (widget.checkmarkSize.value) {
      CssAbsoluteUnit() =>
        (widget.checkmarkSize.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() =>
        (widget.checkmarkSize.value as CssRelativeUnit).percentageFloat() *
            min(
              dynamicWidthPx ?? TwCheckbox.defaultCheckmarkSizePx,
              dynamicHeightPx ?? TwCheckbox.defaultCheckmarkSizePx,
            ),
    };

    final svg = widget.checkmarkSvg;
    final checkmarkIcon = svg != null
        ? TwIcon.svg(
            svg: svg,
            style: style.copyWith(
              width: TwWidth(PxUnit(checkmarkSizePx)),
              height: TwHeight(PxUnit(checkmarkSizePx)),
              textColor: style.textColor,
            ),
          )
        : TwIcon.icon(
            icon: Icons.check,
            style: style.copyWith(
              width: TwWidth(PxUnit(checkmarkSizePx)),
              height: TwHeight(PxUnit(checkmarkSizePx)),
              textColor: style.textColor,
            ),
          );
    Widget current = Align(alignment: Alignment.center, child: checkmarkIcon);

    // Render effective padding (including border widths) around the current
    // widget if applicable.
    final EdgeInsetsGeometry? effectivePadding =
        _paddingIncludingDecoration(style);
    if (effectivePadding != null) {
      current = Padding(
        padding: effectivePadding,
        child: current,
      );
    }

    final Decoration? decoration = style.getBoxDecoration(dynamicConstraints);
    if (decoration != null) {
      current = DecoratedBox(
        decoration: decoration,
        child: current,
      );
    }

    current = ConstrainedBox(
      constraints: dynamicConstraints,
      child: current,
    );

    final double tapTargetSizePx = max(
      widget.tapTargetSize.pixels(),
      max(dynamicConstraints.minWidth, dynamicConstraints.minHeight),
    );
    final marginWidth = (tapTargetSizePx - dynamicConstraints.minWidth) / 2;
    final marginHeight = (tapTargetSizePx - dynamicConstraints.minHeight) / 2;
    if (marginWidth > 0 || marginHeight > 0) {
      current = Padding(
        padding: EdgeInsets.symmetric(
          horizontal: marginWidth,
          vertical: marginHeight,
        ),
        child: current,
      );
    }

    return current;
  }
}
