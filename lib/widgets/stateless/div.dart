import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements/widgets/inherited/parent_constraints_data.dart';
import 'package:tailwind_elements/widgets/stateless/stateless_widget.dart';

/// A [Container] widget wrapper with support for Tailwind styled properties.
class Div extends TwStatelessWidget {
  // Passthrough [Container] properties
  final Widget? child;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  const Div({
    super.style = const TwStyle(),
    this.child,
    this.alignment = Alignment.topLeft,
    this.clipBehavior = Clip.none,
    this.transform,
    this.transformAlignment,
    super.key,
  });

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

  Widget buildDiv(
    final BuildContext context,
    final BoxConstraints? constraints,
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
    final Decoration? decoration = style.getBoxDecoration(constraints);
    if (clipBehavior != Clip.none && decoration != null) {
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
    if (style.hasDecorations && decoration != null) {
      current = DecoratedBox(decoration: decoration, child: current);
    }

    // Use constraints passed in to render a [ConstrainedBox] if applicable.
    if (constraints != null) {
      current = ParentConstraintsData(
        constraints: constraints,
        child: ConstrainedBox(
          constraints: constraints,
          child: current,
        ),
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
    if (style.opacity != null) {
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

  /// Computes the min and max sizing constraints for the given widget, using
  /// the parent constraints. Then tightens the constraints using the given
  /// width and height values if they exist.
  BoxConstraints computeRelativeConstraints(
    final BoxConstraints parentConstraints,
    final TwStyle style,
  ) {
    final minWidthPx = switch (style.minWidth?.value) {
      CssAbsoluteUnit() => (style.minWidth!.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() =>
        (style.minWidth!.value as CssRelativeUnit).percentageFloat() *
            parentConstraints.maxWidth,
      _ => 0.0,
    };
    final minHeightPx = switch (style.minHeight?.value) {
      CssAbsoluteUnit() => (style.minHeight!.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() =>
        (style.minHeight!.value as CssRelativeUnit).percentageFloat() *
            parentConstraints.maxHeight,
      _ => 0.0,
    };
    final maxWidthPx = switch (style.maxWidth?.value) {
      CssAbsoluteUnit() => (style.maxWidth!.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() =>
        (style.maxWidth!.value as CssRelativeUnit).percentageFloat() *
            parentConstraints.maxWidth,
      _ => double.infinity,
    };
    final maxHeightPx = switch (style.maxHeight?.value) {
      CssAbsoluteUnit() => (style.maxHeight!.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() =>
        (style.maxHeight!.value as CssRelativeUnit).percentageFloat() *
            parentConstraints.maxHeight,
      _ => double.infinity,
    };

    final constraints = BoxConstraints(
      minWidth: minWidthPx,
      minHeight: minHeightPx,
      maxWidth: maxWidthPx,
      maxHeight: maxHeightPx,
    );

    final widthPx = switch (style.width?.value) {
      CssAbsoluteUnit() => (style.width!.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() =>
        (style.width!.value as CssRelativeUnit).percentageFloat() *
            parentConstraints.maxWidth,
      _ => null,
    };
    final heightPx = switch (style.height?.value) {
      CssAbsoluteUnit() => (style.height!.value as CssAbsoluteUnit).pixels(),
      CssRelativeUnit() =>
        (style.height!.value as CssRelativeUnit).percentageFloat() *
            parentConstraints.maxHeight,
      _ => null,
    };

    final tightConstraints = constraints.tighten(
      width: widthPx,
      height: heightPx,
    );

    return tightConstraints;
  }

  @override
  Widget build(final BuildContext context) {
    if (style.hasPercentageSize || style.hasPercentageConstraints) {
      final ParentConstraintsData? parentConstraintsData =
          ParentConstraintsData.of(context);
      if (parentConstraintsData != null) {
        final constraints = computeRelativeConstraints(
          parentConstraintsData.constraints,
          style,
        );
        return buildDiv(context, constraints);
      } else {
        return LayoutBuilder(
          builder: (
            final BuildContext context,
            final BoxConstraints parentConstraints,
          ) {
            final constraints =
                computeRelativeConstraints(parentConstraints, style);
            return buildDiv(
              context,
              constraints,
            );
          },
        );
      }
    }

    final simpleConstraints = _tightenConstraints(
      width: switch (style.width?.value) {
        CssAbsoluteUnit() => (style.width!.value as CssAbsoluteUnit).pixels(),
        _ => null,
      },
      height: switch (style.height?.value) {
        CssAbsoluteUnit() => (style.height!.value as CssAbsoluteUnit).pixels(),
        _ => null,
      },
      constraints: style.getSimpleConstraints(),
    );
    return buildDiv(
      context,
      simpleConstraints,
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
