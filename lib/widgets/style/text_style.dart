import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/typography/font_size.dart';
import 'package:tailwind_elements/config/options/typography/font_weight.dart';
import 'package:tailwind_elements/config/options/typography/letter_spacing.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';
import 'package:tailwind_elements/config/options/typography/text_decoration_thickness.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A flattened style data class for Tailwind CSS typography properties.
@immutable
class TwTextStyle {
  // See `text-base` values from https://tailwindcss.com/docs/font-size
  static const defaultFontSize = 16.0; // 16px == 1rem
  static const defaultLineHeight = 1.5;

  // See `text-base` values from https://tailwindcss.com/docs/font-size
  static const defaultFontWeight = FontWeight.w400;

  // Typography styling only
  final TwFontSize? fontSize;
  final FontStyle? fontStyle;
  final TwFontWeight? fontWeight;
  final TwLetterSpacing? letterSpacing;
  final TwLineHeight? lineHeight;
  final TwTextColor? textColor;
  final TwTextColor? selectionColor;
  final TextDecoration? textDecoration;
  final TwTextDecorationColor? textDecorationColor;
  final TextDecorationStyle? textDecorationStyle;
  final TwTextDecorationThickness? textDecorationThickness;
  final TextLeadingDistribution? leadingDistribution;
  final double? wordSpacing;

  const TwTextStyle({
    this.fontSize,
    this.fontStyle,
    this.fontWeight,
    this.letterSpacing,
    this.lineHeight,
    this.textColor,
    this.selectionColor,
    this.textDecoration,
    this.textDecorationColor,
    this.textDecorationStyle,
    this.textDecorationThickness,
    this.leadingDistribution,
    this.wordSpacing,
  });

  /// Converts this style to a [TextStyle] for use in a widget that may render
  /// [Text].
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize?.value.logicalPixels ?? defaultFontSize,
      fontWeight: fontWeight?.fontWeight ?? defaultFontWeight,
      height: fontSize?.getLineHeight(lineHeight) ?? defaultLineHeight,
      fontStyle: fontStyle,
      color: textColor?.color,
      leadingDistribution: leadingDistribution,
      decoration: textDecoration,
      decorationColor: textDecorationColor?.color,
      decorationStyle: textDecorationStyle,
      decorationThickness: textDecorationThickness?.value.logicalPixels,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing?.value
          .emPixels(fontSize?.value.logicalPixels ?? defaultFontSize),
    );
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwTextStyle &&
          runtimeType == other.runtimeType &&
          fontSize == other.fontSize &&
          fontStyle == other.fontStyle &&
          fontWeight == other.fontWeight &&
          letterSpacing == other.letterSpacing &&
          lineHeight == other.lineHeight &&
          textColor == other.textColor &&
          selectionColor == other.selectionColor &&
          textDecoration == other.textDecoration &&
          textDecorationColor == other.textDecorationColor &&
          textDecorationStyle == other.textDecorationStyle &&
          textDecorationThickness == other.textDecorationThickness &&
          leadingDistribution == other.leadingDistribution &&
          wordSpacing == other.wordSpacing;

  @override
  int get hashCode =>
      fontSize.hashCode ^
      fontStyle.hashCode ^
      fontWeight.hashCode ^
      letterSpacing.hashCode ^
      lineHeight.hashCode ^
      textColor.hashCode ^
      selectionColor.hashCode ^
      textDecoration.hashCode ^
      textDecorationColor.hashCode ^
      textDecorationStyle.hashCode ^
      textDecorationThickness.hashCode ^
      leadingDistribution.hashCode ^
      wordSpacing.hashCode;
}

extension TwTextStyleCopyMerge on TwTextStyle {
  /// Merges another [TwTextStyle] with this style, and overwrites any existing
  /// properties from this style with the [other]'s property if set.
  TwTextStyle merge(final TwTextStyle? other) {
    if (other == null || other == this) {
      return this;
    }

    return copyWith(
      fontSize: other.fontSize,
      fontStyle: other.fontStyle,
      fontWeight: other.fontWeight,
      letterSpacing: other.letterSpacing,
      lineHeight: other.lineHeight,
      textColor: other.textColor,
      selectionColor: other.selectionColor,
      textDecoration: other.textDecoration,
      textDecorationColor: other.textDecorationColor,
      textDecorationStyle: other.textDecorationStyle,
      textDecorationThickness: other.textDecorationThickness,
      leadingDistribution: other.leadingDistribution,
      wordSpacing: other.wordSpacing,
    );
  }

  TwTextStyle copyWith({
    // Background styling
    final TwFontSize? fontSize,
    final FontStyle? fontStyle,
    final TwFontWeight? fontWeight,
    final TwLetterSpacing? letterSpacing,
    final TwLineHeight? lineHeight,
    final TwTextColor? textColor,
    final TwTextColor? selectionColor,
    final TextDecoration? textDecoration,
    final TwTextDecorationColor? textDecorationColor,
    final TextDecorationStyle? textDecorationStyle,
    final TwTextDecorationThickness? textDecorationThickness,
    final TextLeadingDistribution? leadingDistribution,
    final double? wordSpacing,
  }) =>
      TwTextStyle(
        fontSize: fontSize ?? this.fontSize,
        fontStyle: fontStyle ?? this.fontStyle,
        fontWeight: fontWeight ?? this.fontWeight,
        letterSpacing: letterSpacing ?? this.letterSpacing,
        lineHeight: lineHeight ?? this.lineHeight,
        textColor: textColor ?? this.textColor,
        selectionColor: selectionColor ?? this.selectionColor,
        textDecoration: textDecoration ?? this.textDecoration,
        textDecorationColor: textDecorationColor ?? this.textDecorationColor,
        textDecorationStyle: textDecorationStyle ?? this.textDecorationStyle,
        textDecorationThickness:
            textDecorationThickness ?? this.textDecorationThickness,
        leadingDistribution: leadingDistribution ?? this.leadingDistribution,
        wordSpacing: wordSpacing ?? this.wordSpacing,
      );
}
