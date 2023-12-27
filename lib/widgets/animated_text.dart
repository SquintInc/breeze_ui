import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements/widgets/state/animated_state.dart';
import 'package:tailwind_elements/widgets/state/state.dart';
import 'package:tailwind_elements/widgets/state/widget_state.dart';

/// A [TwText] widget wrapper with support for animations via an internal
/// [MaterialStatesController] or when nested underneath a [TwAnimationGroup].
class TwAnimatedText extends TwStatefulWidget {
  final String? data;
  final InlineSpan? textSpan;

  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// Takes in a Flutter [TextStyle] to merge and override the Tailwind styles.
  /// Note that this override style is global and will apply to all internal
  /// widget state styles, and will not animate!.
  final TextStyle? overrideStyleStatic;

  const TwAnimatedText(
    String this.data, {
    this.overrideStyleStatic,
    super.style = const TwStyle(),
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.isDisabled = false,
    super.isSelectable = false,
    super.statesController,
    super.key,
  }) : textSpan = null;

  const TwAnimatedText.rich(
    InlineSpan this.textSpan, {
    this.overrideStyleStatic,
    super.style = const TwStyle(),
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    super.isDisabled = false,
    super.isSelectable = false,
    super.statesController,
    super.key,
  }) : data = null;

  @override
  State createState() => _AnimatedText();
}

class _AnimatedText extends TwAnimatedState<TwAnimatedText> {
  @override
  void animationListener(final AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
    }
  }

  @override
  Widget buildForState(
    final BuildContext context,
    final MaterialStatesController controller,
    final TwWidgetState state,
  ) {
    assert(widget.data != null || widget.textSpan != null);
    final mergedStyle = currentStyle;
    final animatedStyle = mergedStyle.merge(animationController?.animatedStyle);

    if (widget.data != null) {
      return TwText(
        widget.data!,
        style: animatedStyle,
        overrideStyle: widget.overrideStyleStatic,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaler: widget.textScaler,
        maxLines: widget.maxLines,
        semanticsLabel: widget.semanticsLabel,
        textWidthBasis: widget.textWidthBasis,
        textHeightBehavior: widget.textHeightBehavior,
      );
    } else {
      return TwText.rich(
        widget.textSpan!,
        style: animatedStyle,
        overrideStyle: widget.overrideStyleStatic,
        strutStyle: widget.strutStyle,
        textAlign: widget.textAlign,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaler: widget.textScaler,
        maxLines: widget.maxLines,
        semanticsLabel: widget.semanticsLabel,
        textWidthBasis: widget.textWidthBasis,
        textHeightBehavior: widget.textHeightBehavior,
      );
    }
  }
}
