// ignore_for_file: always_put_required_named_parameters_first
import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';
import 'package:tailwind_elements/config/options/borders/border_width.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/effects/box_shadow.dart';
import 'package:tailwind_elements/config/options/sizing/height.dart';
import 'package:tailwind_elements/config/options/sizing/max_height.dart';
import 'package:tailwind_elements/config/options/sizing/max_width.dart';
import 'package:tailwind_elements/config/options/sizing/min_height.dart';
import 'package:tailwind_elements/config/options/sizing/min_width.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/config/options/spacing/margin.dart';
import 'package:tailwind_elements/config/options/spacing/padding.dart';
import 'package:tailwind_elements/config/options/typography/font_size.dart';
import 'package:tailwind_elements/config/options/typography/font_weight.dart';
import 'package:tailwind_elements/config/options/typography/letter_spacing.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';
import 'package:tailwind_elements/config/options/typography/text_decoration_thickness.dart';
import 'package:tailwind_elements/config/options/units.dart';
import 'package:tailwind_elements/widgets/extensions/extensions.dart';

export 'package:tailwind_elements/config/options/units.dart';
export 'package:tailwind_elements/widgets/extensions/extensions.dart';

/// Simplified wrapper for [MaterialState] values to provide exhaustive switch
/// cases. This does not account for combinations of [MaterialState] values and
/// simply assumes that each selectable state is mutually exclusive.
enum SelectableState {
  normal,
  disabled,
  hovered,
  focused,
  pressed,
  dragged,
  selected,
}

SelectableState getSelectableState(final Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return SelectableState.disabled;
  } else if (states.contains(MaterialState.dragged)) {
    return SelectableState.dragged;
  } else if (states.contains(MaterialState.selected)) {
    return SelectableState.selected;
  } else if (states.contains(MaterialState.pressed)) {
    return SelectableState.pressed;
  } else if (states.contains(MaterialState.hovered)) {
    return SelectableState.hovered;
  } else if (states.contains(MaterialState.focused)) {
    return SelectableState.focused;
  }
  return SelectableState.normal;
}

/// Flattened style data class for Tailwind CSS properties pertaining to text
/// styling
@immutable
class TwTextStyle {
  final TwFontSize fontSize;
  final TwFontWeight fontWeight;
  final TwLineHeight? lineHeight;
  final TwTextColor? textColor;
  final FontStyle fontStyle;
  final TextDecoration? textDecoration;
  final TwTextDecorationColor? textDecorationColor;
  final TextDecorationStyle? textDecorationStyle;
  final TextLeadingDistribution leadingDistribution;
  final TwTextDecorationThickness? textDecorationThickness;
  final double? wordSpacing;
  final TwLetterSpacing? letterSpacing;

  const TwTextStyle({
    this.fontSize = const TwFontSize(RemUnit(1.0), TwLineHeight(RemUnit(1.5))),
    this.fontWeight = const TwFontWeight(400),
    this.fontStyle = FontStyle.normal,
    this.lineHeight,
    this.textColor,
    this.textDecoration,
    this.textDecorationColor,
    this.textDecorationStyle,
    this.textDecorationThickness,
    this.leadingDistribution = TextLeadingDistribution.even,
    this.wordSpacing,
    this.letterSpacing,
  });

  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize.value.logicalPixels,
      fontWeight: fontWeight.fontWeight,
      height: fontSize.getLineHeight(lineHeight),
      fontStyle: fontStyle,
      color: textColor?.color,
      leadingDistribution: leadingDistribution,
      decoration: textDecoration,
      decorationColor: textDecorationColor?.color,
      decorationStyle: textDecorationStyle,
      decorationThickness: textDecorationThickness?.value.logicalPixels,
      wordSpacing: wordSpacing,
      letterSpacing:
          letterSpacing?.value.emPixels(fontSize.value.logicalPixels),
    );
  }
}

/// Flattened style data class for Tailwind CSS properties that represent a
/// 'container' and wraps any arbitrary child widget.
@immutable
class TwStyle {
  // Background styling
  final TwBackgroundColor? backgroundColor;
  final DecorationImage? backgroundImage;
  final Gradient? backgroundGradient;

  // Foreground styling (if applicable)
  final TwTextColor? textColor;

  // Effect styling
  final TwBoxShadows? boxShadow;
  final TwBoxShadowColor? boxShadowColor;

  // Border styling
  final TwBorder? border;
  final TwBorderColor? borderColor;
  final TwBorderRadius? borderRadius;
  final double? borderStrokeAlign;

  // Sizing styling
  final TwMinWidth? minWidth;
  final TwWidth width;
  final TwMaxWidth? maxWidth;
  final TwMinHeight? minHeight;
  final TwHeight height;
  final TwMaxHeight? maxHeight;

  // Spacing styling
  final TwPadding? padding;
  final TwMargin? margin;

  const TwStyle({
    // Background
    this.backgroundColor,
    this.backgroundImage,
    this.backgroundGradient,

    // Foreground
    this.textColor,

    // Effect styling
    this.boxShadow,
    this.boxShadowColor,

    // Border styling
    this.border,
    this.borderColor,
    this.borderRadius,
    this.borderStrokeAlign,

    // Sizing styling
    this.minWidth,
    this.width = const TwWidth(PxUnit(0)),
    this.maxWidth,
    this.minHeight,
    this.height = const TwHeight(PxUnit(0)),
    this.maxHeight,

    // Spacing styling
    this.padding,
    this.margin,
  });

  bool get hasConstraints =>
      minWidth != null ||
      maxWidth != null ||
      minHeight != null ||
      maxHeight != null;

  bool get hasPercentageConstraints =>
      (minWidth?.value.isPercentageBased ?? false) ||
      (maxWidth?.value.isPercentageBased ?? false) ||
      (minHeight?.value.isPercentageBased ?? false) ||
      (maxHeight?.value.isPercentageBased ?? false);

  bool get hasPercentageSize =>
      width.value.isPercentageBased || height.value.isPercentageBased;

  /// Returns true if any background styling property is set, and only if
  /// [backgroundColor] is not the sole non-null property set.
  bool get hasBackgroundDecoration =>
      (backgroundColor != null ||
          backgroundImage != null ||
          backgroundGradient != null) &&
      !(backgroundColor != null &&
          backgroundImage == null &&
          backgroundGradient == null);

  bool get hasBorderDecoration =>
      (border != null && !(border?.isEmpty ?? true)) || borderRadius != null;

  bool get hasBoxShadowDecoration => boxShadow != null;

  bool get hasDecorations =>
      hasBackgroundDecoration || hasBorderDecoration || hasBoxShadowDecoration;

  Decoration? get boxDecoration {
    if (!hasDecorations) {
      return null;
    }
    return BoxDecoration(
      color: backgroundColor?.color,
      image: backgroundImage,
      gradient: backgroundGradient,
      border: border?.toBorder(borderColor, borderStrokeAlign),
      borderRadius: borderRadius?.toBorderRadius(),
      boxShadow: boxShadow?.toBoxShadows(boxShadowColor),
    );
  }

  BoxConstraints getPercentageBoxConstraints(
    final double parentWidth,
    final double parentHeight,
  ) {
    final minWidth = this.minWidth;
    final maxWidth = this.maxWidth;
    final minHeight = this.minHeight;
    final maxHeight = this.maxHeight;

    final minWidthPx = minWidth != null
        ? (minWidth.value.isPercentageBased
            ? parentWidth * minWidth.value.percentage
            : minWidth.value.logicalPixels)
        : 0.0;
    final minHeightPx = minHeight != null
        ? (minHeight.value.isPercentageBased
            ? parentHeight * minHeight.value.percentage
            : minHeight.value.logicalPixels)
        : 0.0;
    final maxWidthPx = maxWidth != null
        ? (maxWidth.value.isPercentageBased
            ? parentWidth * maxWidth.value.percentage
            : maxWidth.value.logicalPixels)
        : double.infinity;
    final maxHeightPx = maxHeight != null
        ? (maxHeight.value.isPercentageBased
            ? parentHeight * maxHeight.value.percentage
            : maxHeight.value.logicalPixels)
        : double.infinity;

    return BoxConstraints(
      minWidth: minWidthPx,
      maxWidth: maxWidthPx,
      minHeight: minHeightPx,
      maxHeight: maxHeightPx,
    );
  }

  BoxConstraints? getSimpleConstraints() {
    if (!hasConstraints) return null;
    return BoxConstraints(
      minWidth: minWidth?.value.logicalPixels ?? 0.0,
      maxWidth: maxWidth?.value.logicalPixels ?? double.infinity,
      minHeight: minHeight?.value.logicalPixels ?? 0.0,
      maxHeight: maxHeight?.value.logicalPixels ?? double.infinity,
    );
  }
}
