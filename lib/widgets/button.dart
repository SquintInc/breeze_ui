import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/div.dart';
import 'package:tailwind_elements/widgets/state/animated_state.dart';
import 'package:tailwind_elements/widgets/state/state.dart';
import 'package:tailwind_elements/widgets/state/widget_state.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A [TextButton] widget wrapper with support for Tailwind styled properties.
@immutable
class TwButton extends TwStatefulWidget {
  // Pass-through properties for [TextButton]
  final Widget? child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final bool isSemanticButton;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  // Pass-through properties for [ButtonStyle]
  final MaterialTapTargetSize tapTargetSize;
  final AlignmentGeometry? alignment;

  const TwButton({
    super.style = const TwStyle(),
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    this.child,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.isSemanticButton = true,
    this.tapTargetSize = MaterialTapTargetSize.padded,
    this.alignment,
    this.transform,
    this.transformAlignment,
    super.statesController,
    super.key,
  });

  @override
  State createState() => _TwButtonState();
}

extension TwButtonStyleExtension on TwStyle {
  bool get requiresDivWrapper =>
      boxShadow != null ||
      margin != null ||
      hasConstraints ||
      hasPercentageSize ||
      hasPercentageConstraints;

  ButtonStyle toButtonStyle(
    final MaterialTapTargetSize tapTargetSize,
    final AlignmentGeometry? alignment,
  ) {
    return ButtonStyle(
      backgroundColor: always(Colors.transparent),
      foregroundColor: always(textColor?.color ?? Colors.transparent),
      overlayColor: always(Colors.transparent),
      textStyle: always(toTextStyle()),
      splashFactory: NoSplash.splashFactory,
      shape: always(
        RoundedRectangleBorder(
          borderRadius: borderRadius?.toBorderRadius() ?? BorderRadius.zero,
        ),
      ),
      tapTargetSize: tapTargetSize,
      alignment: alignment,
    );
  }
}

class _TwButtonState extends TwAnimatedState<TwButton> {
  /// This is set to false as buttons need their own material states controller.
  @override
  bool get shouldInheritAnimationGroupStatesController => false;

  /// This is set to false as we pass the [statesController] down to the
  /// underlying [TextButton] widget, which handles the material states
  /// properties for us.
  @override
  bool get enableInternalGestureDetector => false;

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

  bool get requiresDivWrapper =>
      widget.style.requiresDivWrapper ||
      (widget.disabled?.requiresDivWrapper ?? false) ||
      (widget.pressed?.requiresDivWrapper ?? false) ||
      (widget.hovered?.requiresDivWrapper ?? false) ||
      (widget.focused?.requiresDivWrapper ?? false) ||
      (widget.dragged?.requiresDivWrapper ?? false) ||
      (widget.selected?.requiresDivWrapper ?? false) ||
      (widget.errored?.requiresDivWrapper ?? false);

  TextButton _buildTextButton(final TwStyle mergedStyle) {
    return TextButton(
      key: widget.key,
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: widget.onHover,
      onFocusChange: widget.onFocusChange,
      style: mergedStyle.toButtonStyle(
        widget.tapTargetSize,
        widget.alignment,
      ),
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      statesController: statesController,
      isSemanticButton: widget.isSemanticButton,
      child: widget.child ?? const SizedBox(),
    );
  }

  /// Loosely copied from [Container.build]. The main difference is that we
  /// choose to explicitly not support 'foregroundDecoration'.
  /// Note that [mergedStyle] is the style for the current state of the widget
  /// merged with the widget's default style.
  Widget _buildDiv(
    final TwStyle mergedStyle,
    final BoxConstraints? constraints,
  ) {
    _trackConstraintsForAnimation(
      constraints: constraints,
      mergedStyle: mergedStyle,
    );

    final Widget button = _buildTextButton(mergedStyle);
    final AlignmentGeometry? alignment = widget.alignment;
    final Clip clipBehavior = widget.clipBehavior;
    final EdgeInsetsGeometry? margin = mergedStyle.margin?.toEdgeInsets();
    final Matrix4? transform = widget.transform;
    final AlignmentGeometry? transformAlignment = widget.transformAlignment;

    Widget current = button;

    final style = mergedStyle.merge(animationController?.animatedStyle);
    final dynamicConstraints =
        animationController?.animatedBoxConstraints ?? constraints;

    if (alignment != null) {
      current = Align(alignment: alignment, child: current);
    }

    // Render effective padding (including border widths) around the current
    // widget if applicable.
    final EdgeInsetsGeometry? effectivePadding =
        _paddingIncludingDecoration(style);
    if (effectivePadding != null) {
      current = Padding(padding: effectivePadding, child: current);
    }

    // Render a [ColoredBox] if the widget has its background color property set
    // and no other decoration settings.
    if (style.hasOnlyBackgroundColorDecoration) {
      current = ColoredBox(
        color: style.backgroundColor?.color ?? Colors.transparent,
        child: current,
      );
    }

    // Render [ClipPath]
    final Decoration? decoration = style.getBoxDecoration(dynamicConstraints);
    if (clipBehavior != Clip.none) {
      assert(decoration != null);
      current = ClipPath(
        clipper: DecorationClipper(
          textDirection: Directionality.maybeOf(context),
          decoration: decoration!,
        ),
        clipBehavior: clipBehavior,
        child: current,
      );
    }

    // Render a [DecoratedBox] only if the background decoration exists and is not
    // just a background color (otherwise a [ColoredBox] would be rendered).
    if (style.hasDecorations && decoration != null) {
      current = DecoratedBox(decoration: decoration, child: current);
    }

    // Use constraints passed in to render a [ConstrainedBox] if applicable.
    if (constraints != null) {
      current = ConstrainedBox(
        constraints: animationController?.animatedBoxConstraints ?? constraints,
        child: current,
      );
    }

    // Wrap current widget with [Padding] to represent the margin if applicable.
    if (margin != null) {
      current = Padding(padding: margin, child: current);
    }

    // Apply transform via [Transform] widget if applicable.
    if (transform != null) {
      current = Transform(
        transform: transform,
        alignment: transformAlignment,
        child: current,
      );
    }

    // Apply opacity effect if applicable.
    if (widget.hasOpacity) {
      current = Opacity(
        opacity: style.opacity?.value ?? 1.0,
        child: current,
      );
    }

    return current;
  }

  /// Gets a [BoxConstraints] object that assumes usage of simple [PxUnit]
  /// values.
  BoxConstraints? _tightenConstraints({
    required final double? width,
    required final double? height,
    required final BoxConstraints? constraints,
  }) {
    final fullConstraints = (width != null || height != null)
        ? constraints?.tighten(
              width: width,
              height: height,
            ) ??
            BoxConstraints.tightFor(
              width: width,
              height: height,
            )
        : constraints;
    return fullConstraints;
  }

  @override
  Widget buildForState(
    final BuildContext context,
    final MaterialStatesController controller,
    final TwWidgetState state,
  ) {
    final mergedStyle = currentStyle;

    if (widget.requiresLayoutBuilder) {
      return LayoutBuilder(
        builder: (
          final BuildContext context,
          final BoxConstraints parentConstraints,
        ) {
          final parentWidth = parentConstraints.limitedMaxWidth(context);
          final parentHeight = parentConstraints.maxHeight;
          final widthPx = mergedStyle.widthPx(parentWidth);
          final heightPx = mergedStyle.heightPx(parentHeight);
          final constraints = mergedStyle.hasSizing
              ? _tightenConstraints(
                  width: widthPx,
                  height: heightPx,
                  constraints: mergedStyle.getPercentageBoxConstraints(
                    parentWidth,
                    parentHeight,
                  ),
                )
              : null;
          return _buildDiv(
            mergedStyle,
            constraints,
          );
        },
      );
    }

    final simpleConstraints = _tightenConstraints(
      width: mergedStyle.width?.value.logicalPixels,
      height: mergedStyle.height?.value.logicalPixels,
      constraints: mergedStyle.getSimpleConstraints(),
    );
    return _buildDiv(
      mergedStyle,
      simpleConstraints,
    );
  }

  /// Updates the constraints tween to use the current calculated constraints
  /// on build time. This is necessary because the constraints are calculated
  /// in the build method and may additionally use a [LayoutBuilder] to
  /// calculate percentage constraints.
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
}
