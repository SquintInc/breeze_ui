import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets/inherited/parent_constraints_data.dart';
import 'package:tailwind_elements/widgets/stateless/constraints.dart';
import 'package:tailwind_elements/widgets/stateless/stateless_widget.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A [Container]-like widget with support for Tailwind styled properties.
class Div extends TwStatelessWidget {
  // Passthrough [Container] properties
  final Widget? child;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  /// Whether to use opacity from this widget's style, or if it is determined
  /// by the parent widget.
  final bool? parentControlsOpacity;

  const Div({
    required super.style,
    this.child,
    this.alignment = Alignment.topLeft,
    this.clipBehavior = Clip.none,
    this.transform,
    this.transformAlignment,
    this.parentControlsOpacity,
    super.alwaysIncludeFilters,
    super.staticConstraints,
    super.key,
  });

  EdgeInsetsGeometry? _paddingIncludingDecoration(
    final TwStyle style,
    final BoxDecoration? decoration,
  ) {
    final stylePadding = style.padding;
    final padding = stylePadding?.toEdgeInsets();
    if (decoration == null) {
      return padding;
    }
    final EdgeInsetsGeometry decorationPadding = decoration.padding;
    if (padding == null) {
      return decorationPadding;
    }
    return padding.add(decorationPadding);
  }

  Widget buildDiv(
    final BuildContext context,
    final BoxConstraints? constraints,
    final BoxConstraints? staticConstraints,
  ) {
    final Widget? child = this.child;
    final AlignmentGeometry? alignment = this.alignment;
    final Clip clipBehavior = this.clipBehavior;
    final EdgeInsetsGeometry? margin = style.margin?.toEdgeInsets();
    final Matrix4? transform = this.transform;
    final AlignmentGeometry? transformAlignment = this.transformAlignment;

    Widget? current = child;

    // Render a [LimitedBox] if the widget has no child and no constraints.
    if (child == null &&
        (!style.hasConstraints ||
            (!style.hasTightWidth && !style.hasTightHeight))) {
      current = LimitedBox(
        maxWidth: 0.0,
        maxHeight: 0.0,
        child: ConstrainedBox(constraints: const BoxConstraints.expand()),
      );
    } else if (alignment != null) {
      current = Align(alignment: alignment, child: current);
    }

    // Set a [DefaultTextStyle] if the widget has any typography styling set, so
    // that text styling can be inherited by child [Text] widgets.
    if (style.hasTypographyProperties) {
      final DefaultTextStyle parentTextStyle = DefaultTextStyle.of(context);
      final textStyle = style.toTextStyle();
      current = DefaultTextStyle(
        style: parentTextStyle.style.merge(textStyle),
        child: current!,
      );
    }

    final bool hasOnlyBackgroundColor =
        style.hasDecorations && style.hasOnlyBackgroundColorDecoration;
    final BoxDecoration? decoration =
        hasOnlyBackgroundColor ? null : style.getBoxDecoration(constraints);

    // Render effective padding (including border widths) around the current
    // widget if applicable.
    final EdgeInsetsGeometry? effectivePadding =
        _paddingIncludingDecoration(style, decoration);
    if (effectivePadding != null) {
      current = Padding(padding: effectivePadding, child: current);
    }

    // Render a [ColoredBox] if the widget has its background color property set
    // and no other decoration settings.
    if (hasOnlyBackgroundColor) {
      current = ColoredBox(
        color: style.backgroundColor?.color ?? Colors.transparent,
        child: current,
      );
    }

    // Render [ClipPath]
    if (clipBehavior != Clip.none &&
        decoration != null &&
        !hasOnlyBackgroundColor) {
      current = ClipPath(
        clipper: DecorationClipper(
          textDirection: Directionality.maybeOf(context),
          decoration: decoration,
        ),
        clipBehavior: clipBehavior,
        child: current,
      );
    }

    // Render a [DecoratedBox] only if the background decoration exists and is not
    // just a background color (otherwise a [ColoredBox] would be rendered).
    if (decoration != null && !hasOnlyBackgroundColor) {
      current = DecoratedBox(decoration: decoration, child: current);
    }

    // Render filters if applicable.
    if ((alwaysIncludeFilters == true || style.hasFilters) &&
        decoration != null) {
      final backdropBlur = style.backdropBlur ?? TwBackdropBlur.zero;
      current = ClipRRect(
        borderRadius: decoration.borderRadius ?? BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: backdropBlur.blur.pixels(style.fontSizePx),
            sigmaY: backdropBlur.blur.pixels(style.fontSizePx),
          ),
          child: current,
        ),
      );
    }

    // Use constraints passed in to render a [ConstrainedBox] if applicable.
    if (constraints != null) {
      current = ConstrainedBox(
        constraints: constraints,
        child: current,
      );
      if (staticConstraints != null) {
        current = ParentConstraintsData(
          constraints: staticConstraints,
          child: current,
        );
      }
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
    if (style.opacity != null && parentControlsOpacity != true) {
      current = Opacity(
        opacity: style.opacity?.value ?? 1.0,
        child: current,
      );
    }

    if (current == null) {
      throw Exception(
        'Current widget being built by ${toStringShort()} is null',
      );
    }

    return current;
  }

  @override
  Widget build(final BuildContext context) {
    if (style.hasPercentageSize ||
        style.hasPercentageConstraints ||
        (staticConstraints?.hasPercentageSize ?? false) ||
        (staticConstraints?.hasPercentageConstraints ?? false)) {
      final ParentConstraintsData? parentConstraintsData =
          ParentConstraintsData.of(context);
      if (parentConstraintsData != null) {
        final constraints = computeRelativeConstraints(
          parentConstraintsData.constraints,
          style.toConstraints(),
        );
        final staticBoxConstraints = staticConstraints != null
            ? computeRelativeConstraints(
                parentConstraintsData.constraints,
                staticConstraints!,
              )
            : null;
        return buildDiv(context, constraints, staticBoxConstraints);
      } else {
        return LayoutBuilder(
          builder: (
            final BuildContext context,
            final BoxConstraints parentConstraints,
          ) {
            final constraints = computeRelativeConstraints(
              parentConstraints,
              style.toConstraints(),
            );
            final staticBoxConstraints = staticConstraints != null
                ? computeRelativeConstraints(
                    parentConstraints,
                    staticConstraints!,
                  )
                : null;
            return buildDiv(
              context,
              constraints,
              staticBoxConstraints,
            );
          },
        );
      }
    }

    final simpleConstraints =
        tightenAbsoluteConstraints(style.toConstraints(), style.fontSizePx);
    final staticBoxConstraints = staticConstraints != null
        ? tightenAbsoluteConstraints(staticConstraints!, style.fontSizePx)
        : null;
    return buildDiv(
      context,
      simpleConstraints,
      staticBoxConstraints,
    );
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
