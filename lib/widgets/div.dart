import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/widgets/style.dart';

/// A [Container] widget wrapper with support for Tailwind styled properties.
class TwDiv extends StatelessWidget {
  /// Tailwind style properties
  final TwStyle style;

  // Passthrough [Container] properties
  final Widget? child;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  const TwDiv({
    this.style = const TwStyle(),
    this.child,
    this.alignment,
    this.clipBehavior = Clip.none,
    this.transform,
    this.transformAlignment,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    if (style.hasPercentageSize || style.hasPercentageConstraints) {
      return LayoutBuilder(
        builder: (
          final BuildContext context,
          final BoxConstraints parentConstraints,
        ) {
          final parentWidth = parentConstraints.maxWidth;
          final parentHeight = parentConstraints.maxHeight;
          final widthPx = style.width.value.isPercentageBased
              ? parentWidth * style.width.value.percentage
              : style.width.value.logicalPixels;
          final heightPx = style.height.value.isPercentageBased
              ? parentHeight * style.height.value.percentage
              : style.height.value.logicalPixels;
          final constraints = style.hasConstraints
              ? style.getPercentageBoxConstraints(parentWidth, parentHeight)
              : null;

          return Container(
            key: key,
            alignment: alignment,
            padding: style.padding?.toEdgeInsets(),
            color: !style.hasDecorations ? style.backgroundColor?.color : null,
            decoration: style.boxDecoration,
            foregroundDecoration: null,
            width: widthPx,
            height: heightPx,
            constraints: constraints,
            margin: style.margin?.toEdgeInsets(),
            transform: transform,
            transformAlignment: transformAlignment,
            clipBehavior: clipBehavior,
            child: child,
          );
        },
      );
    }

    return Container(
      key: key,
      alignment: alignment,
      padding: style.padding?.toEdgeInsets(),
      color: !style.hasDecorations ? style.backgroundColor?.color : null,
      decoration: style.boxDecoration,
      foregroundDecoration: null,
      width: style.width.value.logicalPixels,
      height: style.height.value.logicalPixels,
      constraints: style.getSimpleConstraints(),
      margin: style.margin?.toEdgeInsets(),
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
