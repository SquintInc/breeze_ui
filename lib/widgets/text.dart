import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/style.dart';

/// A [Text] widget wrapper with support for Tailwind styled properties.
@immutable
class TwText extends Text {
  /// Tailwind text style properties
  final TwTextStyle? textStyle;

  /// Takes in a Flutter [TextStyle] to merge and override the Tailwind styles
  final TextStyle? overrideStyle;

  const TwText(
    super.data, {
    final TwTextStyle? style,
    this.overrideStyle,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.key,
  })  : textStyle = style,
        super();

  const TwText.rich(
    super.textSpan, {
    final TwTextStyle? style,
    this.overrideStyle,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
    super.key,
  })  : textStyle = style,
        super.rich();

  @override
  TextStyle? get style => textStyle?.toTextStyle().merge(overrideStyle);
}
