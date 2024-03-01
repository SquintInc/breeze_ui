import 'package:breeze_ui/widgets/style/style.dart';
import 'package:flutter/material.dart';

/// A [Text] widget wrapper with support for Tailwind styled properties. If
/// animated property transitions are wanted, use [TwAnimatedText] instead.
@immutable
class TwText extends Text {
  /// Tailwind text style properties
  final TwStyle? _style;

  /// Takes in a Flutter [TextStyle] to merge and override the Tailwind styles
  final TextStyle? overrideStyle;

  const TwText(
    super.data, {
    final TwStyle? style,
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
    super.key,
  })  : _style = style,
        super();

  const TwText.rich(
    super.textSpan, {
    final TwStyle? style,
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
    super.key,
  })  : _style = style,
        super.rich();

  @override
  TextStyle? get style => _style?.toTextStyle().merge(overrideStyle);

  @override
  Color? get selectionColor => _style?.selectionColor?.color;
}
