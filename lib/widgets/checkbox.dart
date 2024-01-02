import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements/widgets/state/animated_state.dart';
import 'package:tailwind_elements/widgets/state/state.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

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

  SvgPicture _checkmarkSvg(
    final TwStyle style,
    final BytesLoader svgAssetLoader,
    final double checkmarkSizePx,
  ) {
    return SvgPicture(
      svgAssetLoader,
      colorFilter: ColorFilter.mode(
        style.textColor?.color ?? Colors.transparent,
        BlendMode.srcIn,
      ),
      width: checkmarkSizePx,
      height: checkmarkSizePx,
    );
  }

  Icon _checkmarkIcon(
    final TwStyle style,
    final double checkmarkSizePx,
  ) {
    return Icon(
      Icons.check,
      color: style.textColor?.color ?? Colors.transparent,
      size: checkmarkSizePx,
    );
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
    final style = mergedStyle.merge(animationController?.animatedStyle);

    final double? widthPx =
        style.width != null && style.width!.value is CssAbsoluteUnit
            ? (style.width!.value as CssAbsoluteUnit).pixels()
            : null;
    final double? heightPx =
        style.height != null && style.height!.value is CssAbsoluteUnit
            ? (style.height!.value as CssAbsoluteUnit).pixels()
            : null;
    final constraints = _getSizeConstraints(widthPx, heightPx);
    _trackConstraintsForAnimation(
      constraints: constraints,
      mergedStyle: mergedStyle,
    );

    final checkmarkSizePx = switch (widget.checkmarkSize.value) {
      CssAbsoluteUnit() =>
        (widget.checkmarkSize.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() =>
        (widget.checkmarkSize.value as CssRelativeUnit).percentageFloat() *
            min(
              widthPx ?? TwCheckbox.defaultCheckmarkSizePx,
              heightPx ?? TwCheckbox.defaultCheckmarkSizePx,
            ),
    };

    final checkmarkSvg = widget.checkmarkSvg;
    final checkmark = checkmarkSvg != null
        ? _checkmarkSvg(style, checkmarkSvg, checkmarkSizePx)
        : _checkmarkIcon(style, checkmarkSizePx);
    Widget current = Align(alignment: Alignment.center, child: checkmark);

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

    final Decoration? decoration = style.getBoxDecoration(constraints);
    if (decoration != null) {
      current = DecoratedBox(
        decoration: decoration,
        child: current,
      );
    }

    current = ConstrainedBox(
      constraints: constraints,
      child: current,
    );

    final double tapTargetSizePx = max(
      widget.tapTargetSize.pixels(),
      max(constraints.minWidth, constraints.minHeight),
    );
    final marginWidth = (tapTargetSizePx - constraints.minWidth) / 2;
    if (marginWidth > 0) {
      current = Padding(
        padding: EdgeInsets.all(marginWidth),
        child: current,
      );
    }

    return current;
  }
}
