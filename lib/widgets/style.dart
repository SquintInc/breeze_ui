// ignore_for_file: always_put_required_named_parameters_first
import 'package:flutter/widgets.dart';
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
import 'package:tailwind_elements/config/options/units.dart';
import 'package:tailwind_elements/widgets/extensions/extensions.dart';

export 'package:tailwind_elements/config/options/units.dart';
export 'package:tailwind_elements/widgets/extensions/extensions.dart';

/// Flattened style data class for all Tailwind CSS properties.
@immutable
class TwStyle {
  // Background styling
  final TwBackgroundColor? backgroundColor;
  final DecorationImage? backgroundImage;
  final Gradient? backgroundGradient;

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
    required this.width,
    this.maxWidth,
    this.minHeight,
    required this.height,
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
