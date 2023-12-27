import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A [TextSpan] widget wrapper with support for Tailwind styled properties.
@immutable
class TwTextSpan extends TextSpan {
  /// Tailwind text style properties
  final TwStyle? _style;

  /// Takes in a Flutter [TextStyle] to merge and override the Tailwind styles
  final TextStyle? overrideStyle;

  const TwTextSpan({
    super.text,
    super.children,
    final TwStyle? style,
    this.overrideStyle,
    super.recognizer,
    super.mouseCursor,
    super.onEnter,
    super.onExit,
    super.semanticsLabel,
    super.locale,
    super.spellOut,
  })  : _style = style,
        super();

  @override
  TextStyle? get style => _style?.toTextStyle().merge(overrideStyle);
}
