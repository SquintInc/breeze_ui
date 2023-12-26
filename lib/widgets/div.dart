import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements/widgets/state/animated_state.dart';
import 'package:tailwind_elements/widgets/state/state.dart';
import 'package:tailwind_elements/widgets/state/widget_state.dart';

/// A [Container] widget wrapper with support for Tailwind styled properties.
class TwDiv extends TwStatefulWidget {
  // Passthrough [Container] properties
  final Widget? child;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final bool scrollable;
  final Axis scrollDirection;

  const TwDiv({
    super.style = const TwStyle(),
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    this.child,
    this.alignment,
    this.clipBehavior = Clip.none,
    this.transform,
    this.transformAlignment,
    this.scrollable = false,
    this.scrollDirection = Axis.vertical,
    super.isDisabled = false,
    super.isSelectable = false,
    super.statesController,
    super.key,
  });

  @override
  State createState() => _DivState();
}

class _DivState extends TwAnimatedState<TwDiv> {
  @override
  void animationListener(final AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
      case AnimationStatus.dismissed:
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
    }
  }

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

    final Widget? child = widget.child;
    final AlignmentGeometry? alignment = widget.alignment;
    final Clip clipBehavior = widget.clipBehavior;
    final EdgeInsetsGeometry? margin = mergedStyle.margin?.toEdgeInsets();
    final Matrix4? transform = widget.transform;
    final AlignmentGeometry? transformAlignment = widget.transformAlignment;

    Widget? current = child;

    // Render a [LimitedBox] if the widget has no child and no constraints.
    if (child == null &&
        (!mergedStyle.hasConstraints ||
            (!mergedStyle.hasTightWidth && !mergedStyle.hasTightHeight))) {
      current = LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      );
    } else if (alignment != null) {
      current = Align(alignment: alignment, child: current);
    }

    // Render effective padding (including border widths) around the current
    // widget if applicable.
    final EdgeInsetsGeometry? effectivePadding =
        _paddingIncludingDecoration(mergedStyle);
    if (effectivePadding != null) {
      current = Padding(padding: effectivePadding, child: current);
    }

    // Render a [ColoredBox] if the widget has its background color property set
    // and no other decoration settings.
    if (mergedStyle.hasOnlyBackgroundColorDecoration) {
      final backgroundColor = mergedStyle.backgroundColor?.color;
      current = ColoredBox(
        color: animationController?.backgroundColor ??
            backgroundColor ??
            Colors.transparent,
        child: current,
      );
    }

    // Render [ClipPath]
    final Decoration? decoration = animationController?.getBoxDecoration(
          mergedStyle,
        ) ??
        mergedStyle.getBoxDecoration(mergedStyle, constraints);
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
    if (mergedStyle.hasDecorations && decoration != null) {
      current = DecoratedBox(decoration: decoration, child: current);
    }

    // Use constraints passed in to render a [ConstrainedBox] if applicable.
    if (constraints != null) {
      current = ConstrainedBox(
        constraints: animationController?.boxConstraints ?? constraints,
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
        opacity:
            animationController?.opacity ?? mergedStyle.opacity?.value ?? 1.0,
        child: current,
      );
    }

    if (current == null) {
      throw Exception('current widget returned by _buildDiv is null');
    }
    return current;
  }

  /// Gets a [BoxConstraints] object that assumes usage of simple [PxUnit]
  /// values.
  BoxConstraints? _tightenConstraints(
    final double? width,
    final double? height,
    final BoxConstraints? constraints,
  ) {
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
    final currentStyle = getStyle(widgetState);
    final mergedStyle = widget.style.merge(currentStyle);
    final bool usesLayoutBuilder =
        mergedStyle.hasPercentageSize || mergedStyle.hasPercentageConstraints;

    if (usesLayoutBuilder) {
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
                  widthPx,
                  heightPx,
                  mergedStyle.getPercentageBoxConstraints(
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

    final double? widthPx = mergedStyle.width?.value.logicalPixels;
    final double? heightPx = mergedStyle.height?.value.logicalPixels;
    final simpleConstraints = _tightenConstraints(
      widthPx,
      heightPx,
      mergedStyle.getSimpleConstraints(),
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
    if (widget.hasTransitions &&
        animationController?.trackedConstraints != constraints &&
        (animationController?.canAnimate ?? false)) {
      animationController?.updateTrackedConstraints(
        constraints: constraints,
        mergedStyle: mergedStyle,
      );
    }
  }
}

/// Lifted from [Container].
class DecorationClipper extends CustomClipper<Path> {
  DecorationClipper({
    required this.decoration,
    final TextDirection? textDirection,
  }) : textDirection = textDirection ?? TextDirection.ltr;

  final TextDirection textDirection;
  final Decoration decoration;

  @override
  Path getClip(final Size size) {
    return decoration.getClipPath(Offset.zero & size, textDirection);
  }

  @override
  bool shouldReclip(final DecorationClipper oldClipper) {
    return oldClipper.decoration != decoration ||
        oldClipper.textDirection != textDirection;
  }
}
