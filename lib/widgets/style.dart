import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/borders/border_radius.dart';
import 'package:tailwind_elements/config/options/borders/border_width.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/effects/box_shadow.dart';
import 'package:tailwind_elements/config/options/effects/opacity.dart';
import 'package:tailwind_elements/config/options/sizing/height.dart';
import 'package:tailwind_elements/config/options/sizing/max_height.dart';
import 'package:tailwind_elements/config/options/sizing/max_width.dart';
import 'package:tailwind_elements/config/options/sizing/min_height.dart';
import 'package:tailwind_elements/config/options/sizing/min_width.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/config/options/spacing/margin.dart';
import 'package:tailwind_elements/config/options/spacing/padding.dart';
import 'package:tailwind_elements/config/options/transitions/transition_delay.dart';
import 'package:tailwind_elements/config/options/transitions/transition_duration.dart';
import 'package:tailwind_elements/config/options/transitions/transition_property.dart';
import 'package:tailwind_elements/config/options/transitions/transition_timing_function.dart';
import 'package:tailwind_elements/config/options/typography/font_size.dart';
import 'package:tailwind_elements/config/options/typography/font_weight.dart';
import 'package:tailwind_elements/config/options/typography/letter_spacing.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';
import 'package:tailwind_elements/config/options/typography/text_decoration_thickness.dart';
import 'package:tailwind_elements/config/options/units.dart';
import 'package:tailwind_elements/widgets/extensions/extensions.dart';
import 'package:tailwind_elements/widgets/state/widget_state.dart';

export 'package:tailwind_elements/config/options/units.dart';
export 'package:tailwind_elements/widgets/extensions/extensions.dart';

typedef StyleValueResolver<T> = T? Function(TwStyle? statusStyle);

MaterialStateProperty<T> always<T>(final T value) =>
    MaterialStatePropertyAll<T>(value);

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

  static MaterialStateTextStyle toMaterialTextStyle(
    final TwTextStyle normal, {
    required final TwTextStyle? disabled,
    required final TwTextStyle? dragged,
    required final TwTextStyle? error,
    required final TwTextStyle? focused,
    required final TwTextStyle? selected,
    required final TwTextStyle? pressed,
    required final TwTextStyle? hovered,
  }) {
    return MaterialStateTextStyle.resolveWith(
        (final Set<MaterialState> states) {
      final TwTextStyle? statusStyle = switch (getWidgetState(states)) {
        TwWidgetState.disabled => disabled,
        TwWidgetState.dragged => dragged,
        TwWidgetState.error => error,
        TwWidgetState.focused => focused,
        TwWidgetState.selected => selected,
        TwWidgetState.pressed => pressed,
        TwWidgetState.hovered => hovered,
        _ => normal,
      };
      return TextStyle(
        fontSize: statusStyle?.fontSize.value.logicalPixels ??
            normal.fontSize.value.logicalPixels,
        fontWeight:
            statusStyle?.fontWeight.fontWeight ?? normal.fontWeight.fontWeight,
        height: statusStyle?.fontSize.getLineHeight(statusStyle.lineHeight) ??
            normal.fontSize.getLineHeight(normal.lineHeight),
        fontStyle: statusStyle?.fontStyle ?? normal.fontStyle,
        color: statusStyle?.textColor?.color ?? normal.textColor?.color,
        leadingDistribution:
            statusStyle?.leadingDistribution ?? normal.leadingDistribution,
        decoration: statusStyle?.textDecoration ?? normal.textDecoration,
        decorationColor: statusStyle?.textDecorationColor?.color ??
            normal.textDecorationColor?.color,
        decorationStyle:
            statusStyle?.textDecorationStyle ?? normal.textDecorationStyle,
        decorationThickness:
            statusStyle?.textDecorationThickness?.value.logicalPixels ??
                normal.textDecorationThickness?.value.logicalPixels,
        wordSpacing: statusStyle?.wordSpacing ?? normal.wordSpacing,
        letterSpacing: statusStyle?.letterSpacing?.value
                .emPixels(statusStyle.fontSize.value.logicalPixels) ??
            normal.letterSpacing?.value
                .emPixels(normal.fontSize.value.logicalPixels),
      );
    });
  }
}

@immutable
class TwTextInputStyle extends TwTextStyle {
  // Background styling
  final TwBackgroundColor? backgroundColor;

  // Border styling
  final TwBorder? border;
  final TwBorderColor? borderColor;
  final TwBorderRadius? borderRadius;
  final double? borderStrokeAlign;

  // Sizing styling
  final TwWidth? width;
  final TwHeight? height;

  // Spacing styling
  final TwPadding? padding;

  const TwTextInputStyle({
    // Typography styling
    super.fontSize = const TwFontSize(RemUnit(1.0), TwLineHeight(RemUnit(1.5))),
    super.fontWeight = const TwFontWeight(400),
    super.fontStyle = FontStyle.normal,
    super.lineHeight,
    super.textColor,
    super.textDecoration,
    super.textDecorationColor,
    super.textDecorationStyle,
    super.textDecorationThickness,
    super.leadingDistribution = TextLeadingDistribution.even,
    super.wordSpacing,
    super.letterSpacing,
    this.backgroundColor,
    this.border,
    this.borderColor,
    this.borderRadius,
    this.borderStrokeAlign,
    this.width,
    this.height,
    this.padding,
  });

  static InputBorder? toMaterialInputBorder(
    final TwTextInputStyle normal, {
    required final TwTextInputStyle? disabled,
    required final TwTextInputStyle? dragged,
    required final TwTextInputStyle? error,
    required final TwTextInputStyle? focused,
    required final TwTextInputStyle? selected,
    required final TwTextInputStyle? pressed,
    required final TwTextInputStyle? hovered,
  }) =>
      MaterialStateOutlineInputBorder.resolveWith(
          (final Set<MaterialState> states) {
        final TwTextInputStyle? statusStyle = switch (getWidgetState(states)) {
          TwWidgetState.disabled => disabled,
          TwWidgetState.dragged => dragged,
          TwWidgetState.error => error,
          TwWidgetState.focused => focused,
          TwWidgetState.selected => selected,
          TwWidgetState.pressed => pressed,
          TwWidgetState.hovered => hovered,
          _ => normal,
        };
        return statusStyle?.toBorder() ?? normal.toBorder() ?? InputBorder.none;
      });

  bool get hasBorderDecoration =>
      (border != null && !(border?.isEmpty ?? true)) || borderRadius != null;

  BoxConstraints? getBoxConstraints() {
    if (width == null && height == null) return null;
    return BoxConstraints(
      minWidth: width?.value.logicalPixels ?? 0.0,
      maxWidth: width?.value.logicalPixels ?? double.infinity,
      minHeight: height?.value.logicalPixels ?? 0.0,
      maxHeight: height?.value.logicalPixels ?? double.infinity,
    );
  }

  InputBorder? toBorder() => hasBorderDecoration
      ? OutlineInputBorder(
          borderRadius: borderRadius?.toBorderRadius() ?? BorderRadius.zero,
          borderSide: BorderSide(
            color: hasBorderDecoration
                ? borderColor?.color ?? Colors.transparent
                : Colors.transparent,
            width: border?.all.pixels.logicalPixels ?? 0.0,
            strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
          ),
        )
      : InputBorder.none;
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
  final TwOpacity? opacity;

  // Border styling
  final TwBorder? border;
  final TwBorderColor? borderColor;
  final TwBorderRadius? borderRadius;
  final double? borderStrokeAlign;

  // Sizing styling
  final TwMinWidth? minWidth;
  final TwWidth? width;
  final TwMaxWidth? maxWidth;
  final TwMinHeight? minHeight;
  final TwHeight? height;
  final TwMaxHeight? maxHeight;

  // Spacing styling
  final TwPadding? padding;
  final TwMargin? margin;

  // Transition styling
  final TwTransitionProperty? transition;
  final TwTransitionDuration? transitionDuration;
  final TwTransitionTimingFunction? transitionTimingFn;
  final TwTransitionDelay? transitionDelay;

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
    this.opacity,

    // Border styling
    this.border,
    this.borderColor,
    this.borderRadius,
    this.borderStrokeAlign,

    // Sizing styling
    this.minWidth,
    this.width,
    this.maxWidth,
    this.minHeight,
    this.height,
    this.maxHeight,

    // Spacing styling
    this.padding,
    this.margin,

    // Transition styling
    this.transition,
    this.transitionDuration,
    this.transitionTimingFn,
    this.transitionDelay,
  });

  static MaterialStateProperty<T> resolveStatus<T>(
    final TwStyle normal,
    final StyleValueResolver resolver, {
    required final T defaultValue,
    required final TwStyle? disabled,
    required final TwStyle? dragged,
    required final TwStyle? error,
    required final TwStyle? focused,
    required final TwStyle? selected,
    required final TwStyle? pressed,
    required final TwStyle? hovered,
  }) =>
      MaterialStateProperty.resolveWith<T>(
        (final Set<MaterialState> states) => switch (getWidgetState(states)) {
          TwWidgetState.disabled =>
            resolver(disabled) ?? resolver(normal) ?? defaultValue,
          TwWidgetState.dragged =>
            resolver(dragged) ?? resolver(normal) ?? defaultValue,
          TwWidgetState.error =>
            resolver(error) ?? resolver(normal) ?? defaultValue,
          TwWidgetState.focused =>
            resolver(focused) ?? resolver(normal) ?? defaultValue,
          TwWidgetState.selected =>
            resolver(selected) ?? resolver(normal) ?? defaultValue,
          TwWidgetState.pressed =>
            resolver(pressed) ?? resolver(normal) ?? defaultValue,
          TwWidgetState.hovered =>
            resolver(hovered) ?? resolver(normal) ?? defaultValue,
          TwWidgetState.normal => resolver(normal) ?? defaultValue,
        },
      );

  bool get hasConstraints =>
      minWidth != null ||
      maxWidth != null ||
      minHeight != null ||
      maxHeight != null;

  bool get hasSizing => width != null || height != null || hasConstraints;

  bool get hasTightWidth =>
      minWidth != null &&
      maxWidth != null &&
      minWidth!.value == maxWidth!.value;

  bool get hasTightHeight =>
      minHeight != null &&
      maxHeight != null &&
      minHeight!.value == maxHeight!.value;

  bool get hasPercentageConstraints =>
      (minWidth?.value.isPercentageBased ?? false) ||
      (maxWidth?.value.isPercentageBased ?? false) ||
      (minHeight?.value.isPercentageBased ?? false) ||
      (maxHeight?.value.isPercentageBased ?? false);

  bool get hasPercentageSize =>
      (width?.value.isPercentageBased ?? false) ||
      (height?.value.isPercentageBased ?? false);

  bool get hasBackgroundDecoration =>
      backgroundColor != null ||
      backgroundImage != null ||
      backgroundGradient != null;

  bool get hasBorderDecoration =>
      (border != null && !(border?.isEmpty ?? true)) || borderRadius != null;

  bool get hasBoxShadowDecoration => boxShadow != null;

  bool get hasDecorations =>
      hasBackgroundDecoration || hasBorderDecoration || hasBoxShadowDecoration;

  bool get hasOnlyBackgroundColorDecoration =>
      hasBackgroundDecoration &&
      !hasBorderDecoration &&
      !hasBoxShadowDecoration &&
      backgroundImage == null &&
      backgroundGradient == null;

  double widthPx(final double parentWidth) {
    final width = this.width;
    if (width == null) return double.infinity;

    return width.value.isPercentageBased
        ? parentWidth * width.value.percentage
        : width.value.logicalPixels;
  }

  double heightPx(final double parentHeight) {
    final height = this.height;
    if (height == null) return double.infinity;

    return height.value.isPercentageBased
        ? parentHeight * height.value.percentage
        : height.value.logicalPixels;
  }

  Decoration? getBoxDecoration(
    final TwStyle defaultStyle,
    final BoxConstraints? constraints,
  ) {
    if (!hasDecorations && !defaultStyle.hasDecorations) {
      return null;
    }
    final bool isCircle =
        borderRadius?.isCircle ?? defaultStyle.borderRadius?.isCircle ?? false;
    final borderColor =
        this.borderColor?.color ?? defaultStyle.borderColor?.color;
    final borderStrokeAlign =
        this.borderStrokeAlign ?? defaultStyle.borderStrokeAlign;
    return BoxDecoration(
      color: backgroundColor?.color ?? defaultStyle.backgroundColor?.color,
      image: backgroundImage ?? defaultStyle.backgroundImage,
      gradient: backgroundGradient ?? defaultStyle.backgroundGradient,
      border: border?.toBorder(borderColor, borderStrokeAlign) ??
          defaultStyle.border?.toBorder(borderColor, borderStrokeAlign),
      borderRadius: isCircle
          ? BorderRadius.circular(constraints?.circleRadius ?? 9999)
          : borderRadius?.toBorderRadius() ??
              defaultStyle.borderRadius?.toBorderRadius(),
      boxShadow: boxShadow?.withColor(boxShadowColor) ??
          defaultStyle.boxShadow?.withColor(boxShadowColor),
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

  /// Gets the [BorderSide] from a [TwStyle], which includes the border color
  /// and width. Note that Material buttons only support a single border width
  /// via TwBorder.all(...)
  BorderSide toBorderSide() => BorderSide(
        color: hasBorderDecoration
            ? borderColor?.color ?? Colors.transparent
            : Colors.transparent,
        width: border?.all.pixels.logicalPixels ?? 0.0,
        strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
      );

  @override
  String toString() {
    final buf = <String>[];
    if (backgroundColor != null) {
      buf.add('backgroundColor: $backgroundColor');
    }
    if (backgroundImage != null) {
      buf.add('backgroundImage: $backgroundImage');
    }
    if (backgroundGradient != null) {
      buf.add('backgroundGradient: $backgroundGradient');
    }
    if (textColor != null) buf.add('textColor: $textColor');
    if (boxShadow != null) buf.add('boxShadow: $boxShadow');
    if (boxShadowColor != null) buf.add('boxShadowColor: $boxShadowColor');
    if (opacity != null) buf.add('opacity: $opacity');
    if (border != null) buf.add('border: $border');
    if (borderColor != null) buf.add('borderColor: $borderColor');
    if (borderRadius != null) buf.add('borderRadius: $borderRadius');
    if (borderStrokeAlign != null) {
      buf.add('borderStrokeAlign: $borderStrokeAlign');
    }
    if (minWidth != null) buf.add('minWidth: $minWidth');
    if (width != null) buf.add('width: $width');
    if (maxWidth != null) buf.add('maxWidth: $maxWidth');
    if (minHeight != null) buf.add('minHeight: $minHeight');
    if (height != null) buf.add('height: $height');
    if (maxHeight != null) buf.add('maxHeight: $maxHeight');
    if (padding != null) buf.add('padding: $padding');
    if (margin != null) buf.add('margin: $margin');
    if (transition != null) buf.add('transition: $transition');
    if (transitionDuration != null) {
      buf.add('transitionDuration: $transitionDuration');
    }
    if (transitionTimingFn != null) {
      buf.add('transitionTimingFn: $transitionTimingFn');
    }
    if (transitionDelay != null) {
      buf.add('transitionDelay: $transitionDelay');
    }
    return 'TwStyle{${buf.join(', ')}}';
  }
}
