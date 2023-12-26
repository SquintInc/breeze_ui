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

/// Flattened style data class for Tailwind CSS properties.
/// Some properties may not be applicable to certain widgets (e.g. typography
/// properties won't be applicable to widgets that are not meant to render text
/// at their level).
@immutable
class TwStyle {
  static const defaultFontSize =
      TwFontSize(RemUnit(1.0), TwLineHeight(RemUnit(1.5)));
  static const defaultFontWeight = TwFontWeight(400);

  // Background styling
  final TwBackgroundColor? backgroundColor;
  final DecorationImage? backgroundImage;
  final Gradient? backgroundGradient;

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

  // Typography styling (not applicable to widgets without text)
  final TwFontSize fontSize;
  final FontStyle fontStyle;
  final TwFontWeight fontWeight;
  final TwLetterSpacing? letterSpacing;
  final TwLineHeight? lineHeight;
  final TwTextColor? textColor;
  final TextDecoration? textDecoration;
  final TwTextDecorationColor? textDecorationColor;
  final TextDecorationStyle? textDecorationStyle;
  final TwTextDecorationThickness? textDecorationThickness;
  final TextLeadingDistribution leadingDistribution;
  final double? wordSpacing;

  const TwStyle({
    // Background
    this.backgroundColor,
    this.backgroundImage,
    this.backgroundGradient,

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

    // Typography styling
    this.fontSize = defaultFontSize,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = defaultFontWeight,
    this.letterSpacing,
    this.lineHeight,
    this.textColor,
    this.textDecoration,
    this.textDecorationColor,
    this.textDecorationStyle,
    this.textDecorationThickness,
    this.leadingDistribution = TextLeadingDistribution.even,
    this.wordSpacing,
  });

  /// Merges another [TwStyle] with this style, and overwrites any existing
  /// properties from this style with the [other]'s property if set.
  TwStyle merge(final TwStyle? other) {
    if (other == null || other == this) {
      return this;
    }

    return copyWith(
      backgroundColor: other.backgroundColor,
      backgroundImage: other.backgroundImage,
      backgroundGradient: other.backgroundGradient,
      boxShadow: other.boxShadow,
      boxShadowColor: other.boxShadowColor,
      opacity: other.opacity,
      border: other.border,
      borderColor: other.borderColor,
      borderRadius: other.borderRadius,
      borderStrokeAlign: other.borderStrokeAlign,
      minWidth: other.minWidth,
      width: other.width,
      maxWidth: other.maxWidth,
      minHeight: other.minHeight,
      height: other.height,
      maxHeight: other.maxHeight,
      padding: other.padding,
      margin: other.margin,
      transition: other.transition,
      transitionDuration: other.transitionDuration,
      transitionTimingFn: other.transitionTimingFn,
      transitionDelay: other.transitionDelay,
      fontSize: other.fontSize,
      fontStyle: other.fontStyle,
      fontWeight: other.fontWeight,
      letterSpacing: other.letterSpacing,
      lineHeight: other.lineHeight,
      textColor: other.textColor,
      textDecoration: other.textDecoration,
      textDecorationColor: other.textDecorationColor,
      textDecorationStyle: other.textDecorationStyle,
      textDecorationThickness: other.textDecorationThickness,
      leadingDistribution: other.leadingDistribution,
      wordSpacing: other.wordSpacing,
    );
  }

  TwStyle copyWith({
    // Background styling
    final TwBackgroundColor? backgroundColor,
    final DecorationImage? backgroundImage,
    final Gradient? backgroundGradient,
    final TwBoxShadows? boxShadow,
    final TwBoxShadowColor? boxShadowColor,
    final TwOpacity? opacity,
    final TwBorder? border,
    final TwBorderColor? borderColor,
    final TwBorderRadius? borderRadius,
    final double? borderStrokeAlign,
    final TwMinWidth? minWidth,
    final TwWidth? width,
    final TwMaxWidth? maxWidth,
    final TwMinHeight? minHeight,
    final TwHeight? height,
    final TwMaxHeight? maxHeight,
    final TwPadding? padding,
    final TwMargin? margin,
    final TwTransitionProperty? transition,
    final TwTransitionDuration? transitionDuration,
    final TwTransitionTimingFunction? transitionTimingFn,
    final TwTransitionDelay? transitionDelay,
    final TwFontSize? fontSize,
    final FontStyle? fontStyle,
    final TwFontWeight? fontWeight,
    final TwLetterSpacing? letterSpacing,
    final TwLineHeight? lineHeight,
    final TwTextColor? textColor,
    final TextDecoration? textDecoration,
    final TwTextDecorationColor? textDecorationColor,
    final TextDecorationStyle? textDecorationStyle,
    final TwTextDecorationThickness? textDecorationThickness,
    final TextLeadingDistribution? leadingDistribution,
    final double? wordSpacing,
  }) =>
      TwStyle(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        backgroundImage: backgroundImage ?? this.backgroundImage,
        backgroundGradient: backgroundGradient ?? this.backgroundGradient,
        boxShadow: boxShadow ?? this.boxShadow,
        boxShadowColor: boxShadowColor ?? this.boxShadowColor,
        opacity: opacity ?? this.opacity,
        border: border ?? this.border,
        borderColor: borderColor ?? this.borderColor,
        borderRadius: borderRadius ?? this.borderRadius,
        borderStrokeAlign: borderStrokeAlign ?? this.borderStrokeAlign,
        minWidth: minWidth ?? this.minWidth,
        width: width ?? this.width,
        maxWidth: maxWidth ?? this.maxWidth,
        minHeight: minHeight ?? this.minHeight,
        height: height ?? this.height,
        maxHeight: maxHeight ?? this.maxHeight,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        transition: transition ?? this.transition,
        transitionDuration: transitionDuration ?? this.transitionDuration,
        transitionTimingFn: transitionTimingFn ?? this.transitionTimingFn,
        transitionDelay: transitionDelay ?? this.transitionDelay,
        fontSize: fontSize ?? this.fontSize,
        fontStyle: fontStyle ?? this.fontStyle,
        fontWeight: fontWeight ?? this.fontWeight,
        letterSpacing: letterSpacing ?? this.letterSpacing,
        lineHeight: lineHeight ?? this.lineHeight,
        textColor: textColor ?? this.textColor,
        textDecoration: textDecoration ?? this.textDecoration,
        textDecorationColor: textDecorationColor ?? this.textDecorationColor,
        textDecorationStyle: textDecorationStyle ?? this.textDecorationStyle,
        textDecorationThickness:
            textDecorationThickness ?? this.textDecorationThickness,
        leadingDistribution: leadingDistribution ?? this.leadingDistribution,
        wordSpacing: wordSpacing ?? this.wordSpacing,
      );

  /// Determines whether the style has min/max width and height constraints.
  bool get hasConstraints =>
      minWidth != null ||
      maxWidth != null ||
      minHeight != null ||
      maxHeight != null;

  /// Determines whether the style has any sizing properties for width and
  /// height.
  bool get hasSizing => width != null || height != null || hasConstraints;

  /// Determines whether the style has its min and max width set
  bool get hasTightWidth =>
      minWidth != null &&
      maxWidth != null &&
      minWidth!.value == maxWidth!.value;

  /// Determines whether the style has its min and max height set
  bool get hasTightHeight =>
      minHeight != null &&
      maxHeight != null &&
      minHeight!.value == maxHeight!.value;

  /// Determines if the style has any percentage based min/max sizing
  /// constraints
  bool get hasPercentageConstraints =>
      (minWidth?.value.isPercentageBased ?? false) ||
      (maxWidth?.value.isPercentageBased ?? false) ||
      (minHeight?.value.isPercentageBased ?? false) ||
      (maxHeight?.value.isPercentageBased ?? false);

  /// Determines if the style has any percentage based sizing constraints
  bool get hasPercentageSize =>
      (width?.value.isPercentageBased ?? false) ||
      (height?.value.isPercentageBased ?? false);

  /// Determines if the style has any background decoration at all (e.g. color,
  /// image, gradient)
  bool get hasBackgroundDecoration =>
      backgroundColor != null ||
      backgroundImage != null ||
      backgroundGradient != null;

  /// Determines if the style has any border decoration at all (e.g. border
  /// thickness, border radius)
  bool get hasBorderDecoration =>
      (border != null && !(border?.isEmpty ?? true)) || borderRadius != null;

  /// Determines if the style has any box shadow decoration at all
  bool get hasBoxShadowDecoration => boxShadow != null;

  /// Determines if the style has any decoration at all (e.g. background,
  /// borders, shadows)
  bool get hasDecorations =>
      hasBackgroundDecoration || hasBorderDecoration || hasBoxShadowDecoration;

  /// Determines if the style has only background color decoration, for
  /// optimized rendering of a [ColoredBox] widget.
  bool get hasOnlyBackgroundColorDecoration =>
      hasBackgroundDecoration &&
      !hasBorderDecoration &&
      !hasBoxShadowDecoration &&
      backgroundImage == null &&
      backgroundGradient == null;

  /// Calculates the width of this widget in pixels, based on a percentage of
  /// its parent widget's width, or via this widget's own logical pixel width.
  double widthPx(final double parentWidth) {
    final width = this.width;
    if (width == null) return double.infinity;

    return width.value.isPercentageBased
        ? parentWidth * width.value.percentage
        : width.value.logicalPixels;
  }

  /// Calculates the height of this widget in pixels, based on a percentage of
  /// its parent widget's height, or via this widget's own logical pixel height.
  double heightPx(final double parentHeight) {
    final height = this.height;
    if (height == null) return double.infinity;

    return height.value.isPercentageBased
        ? parentHeight * height.value.percentage
        : height.value.logicalPixels;
  }

  /// Compute the box decoration for this style, based on the merged style and
  /// the current widget's constraints (if applicable, e.g. computed from a
  /// [LayoutBuilder]).
  Decoration? getBoxDecoration(
    final TwStyle mergedStyle,
    final BoxConstraints? constraints,
  ) {
    if (!hasDecorations && !mergedStyle.hasDecorations) {
      return null;
    }
    final bool isCircle =
        borderRadius?.isCircle ?? mergedStyle.borderRadius?.isCircle ?? false;
    final borderColor =
        this.borderColor?.color ?? mergedStyle.borderColor?.color;
    final borderStrokeAlign =
        this.borderStrokeAlign ?? mergedStyle.borderStrokeAlign;
    return BoxDecoration(
      color: backgroundColor?.color ?? mergedStyle.backgroundColor?.color,
      image: backgroundImage ?? mergedStyle.backgroundImage,
      gradient: backgroundGradient ?? mergedStyle.backgroundGradient,
      border: border?.toBorder(borderColor, borderStrokeAlign) ??
          mergedStyle.border?.toBorder(borderColor, borderStrokeAlign),
      borderRadius: isCircle
          ? BorderRadius.circular(constraints?.circleRadius ?? 9999)
          : borderRadius?.toBorderRadius() ??
              mergedStyle.borderRadius?.toBorderRadius(),
      boxShadow: boxShadow?.withColor(boxShadowColor) ??
          mergedStyle.boxShadow?.withColor(boxShadowColor),
    );
  }

  /// Compute the box constraints for this style based on a percentage of the
  /// parent widget's sizing.
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

  /// Compute simple box constraints for this style, using the min/max width and
  /// height sizing values, assuming that they are logical pixels.
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
        (final Set<MaterialState> states) =>
            switch (getPrimaryWidgetState(states)) {
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

  /// Converts this style to a [TextStyle] for use in a widget that may render
  /// [Text].
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

  static InputBorder? toMaterialInputBorder(
    final TwStyle normal, {
    required final TwStyle? disabled,
    required final TwStyle? dragged,
    required final TwStyle? error,
    required final TwStyle? focused,
    required final TwStyle? selected,
    required final TwStyle? pressed,
    required final TwStyle? hovered,
  }) =>
      MaterialStateOutlineInputBorder.resolveWith(
          (final Set<MaterialState> states) {
        final TwStyle? statusStyle = switch (getPrimaryWidgetState(states)) {
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

  static MaterialStateTextStyle toMaterialTextStyle(
    final TwStyle normal, {
    required final TwStyle? disabled,
    required final TwStyle? dragged,
    required final TwStyle? error,
    required final TwStyle? focused,
    required final TwStyle? selected,
    required final TwStyle? pressed,
    required final TwStyle? hovered,
  }) {
    return MaterialStateTextStyle.resolveWith(
        (final Set<MaterialState> states) {
      final TwStyle? statusStyle = switch (getPrimaryWidgetState(states)) {
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

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          backgroundImage == other.backgroundImage &&
          backgroundGradient == other.backgroundGradient &&
          boxShadow == other.boxShadow &&
          boxShadowColor == other.boxShadowColor &&
          opacity == other.opacity &&
          border == other.border &&
          borderColor == other.borderColor &&
          borderRadius == other.borderRadius &&
          borderStrokeAlign == other.borderStrokeAlign &&
          minWidth == other.minWidth &&
          width == other.width &&
          maxWidth == other.maxWidth &&
          minHeight == other.minHeight &&
          height == other.height &&
          maxHeight == other.maxHeight &&
          padding == other.padding &&
          margin == other.margin &&
          transition == other.transition &&
          transitionDuration == other.transitionDuration &&
          transitionTimingFn == other.transitionTimingFn &&
          transitionDelay == other.transitionDelay &&
          fontSize == other.fontSize &&
          fontStyle == other.fontStyle &&
          fontWeight == other.fontWeight &&
          letterSpacing == other.letterSpacing &&
          lineHeight == other.lineHeight &&
          textColor == other.textColor &&
          textDecoration == other.textDecoration &&
          textDecorationColor == other.textDecorationColor &&
          textDecorationStyle == other.textDecorationStyle &&
          textDecorationThickness == other.textDecorationThickness &&
          leadingDistribution == other.leadingDistribution &&
          wordSpacing == other.wordSpacing;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      backgroundImage.hashCode ^
      backgroundGradient.hashCode ^
      boxShadow.hashCode ^
      boxShadowColor.hashCode ^
      opacity.hashCode ^
      border.hashCode ^
      borderColor.hashCode ^
      borderRadius.hashCode ^
      borderStrokeAlign.hashCode ^
      minWidth.hashCode ^
      width.hashCode ^
      maxWidth.hashCode ^
      minHeight.hashCode ^
      height.hashCode ^
      maxHeight.hashCode ^
      padding.hashCode ^
      margin.hashCode ^
      transition.hashCode ^
      transitionDuration.hashCode ^
      transitionTimingFn.hashCode ^
      transitionDelay.hashCode ^
      fontSize.hashCode ^
      fontStyle.hashCode ^
      fontWeight.hashCode ^
      letterSpacing.hashCode ^
      lineHeight.hashCode ^
      textColor.hashCode ^
      textDecoration.hashCode ^
      textDecorationColor.hashCode ^
      textDecorationStyle.hashCode ^
      textDecorationThickness.hashCode ^
      leadingDistribution.hashCode ^
      wordSpacing.hashCode;
}
