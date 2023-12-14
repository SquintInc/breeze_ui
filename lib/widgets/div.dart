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
  final bool scrollableChild;
  final Axis scrollDirection;

  const TwDiv({
    this.style = const TwStyle(),
    this.child,
    this.alignment,
    this.clipBehavior = Clip.none,
    this.transform,
    this.transformAlignment,
    this.scrollableChild = false,
    this.scrollDirection = Axis.vertical,
    super.key,
  });

  Container _createContainer({
    required final double? width,
    required final double? height,
    required final BoxConstraints? constraints,
  }) =>
      Container(
        key: key,
        alignment: alignment,
        padding: style.padding?.toEdgeInsets(),
        color: !style.hasDecorations ? style.backgroundColor?.color : null,
        decoration: style.boxDecoration,
        foregroundDecoration: null,
        width: style.width?.value.logicalPixels,
        height: style.height?.value.logicalPixels,
        constraints: style.getSimpleConstraints(),
        margin: style.margin?.toEdgeInsets(),
        transform: transform,
        transformAlignment: transformAlignment,
        clipBehavior: clipBehavior,
        child: scrollableChild
            ? SingleChildScrollView(
                scrollDirection: scrollDirection,
                child: child,
              )
            : child,
      );

  @override
  Widget build(final BuildContext context) {
    if (style.hasPercentageSize || style.hasPercentageConstraints) {
      return LayoutBuilder(
        builder: (
          final BuildContext context,
          final BoxConstraints parentConstraints,
        ) {
          final parentWidth = parentConstraints.limitedMaxWidth(context);
          final parentHeight = parentConstraints.maxHeight;
          final widthPx = style.widthPx(parentWidth);
          final heightPx = style.heightPx(parentHeight);
          final constraints = style.hasConstraints
              ? style.getPercentageBoxConstraints(parentWidth, parentHeight)
              : null;

          return _createContainer(
            width: widthPx,
            height: heightPx,
            constraints: constraints,
          );
        },
      );
    }

    return _createContainer(
      width: style.width?.value.logicalPixels,
      height: style.height?.value.logicalPixels,
      constraints: style.getSimpleConstraints(),
    );
  }
}
