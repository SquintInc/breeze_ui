import 'package:flutter/widgets.dart';
import 'package:tailwind_elements/widgets/style.dart';

/// A [Container] widget wrapper with support for Tailwind styled properties.
class TwDiv extends StatelessWidget {
  // Tailwind style properties
  final TwStyle style;

  // Passthrough [Container] properties
  final Widget? child;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;

  const TwDiv({
    required this.style,
    this.child,
    this.alignment,
    this.clipBehavior = Clip.none,
    this.transform,
    this.transformAlignment,
    super.key,
  });

  Decoration? _boxDecoration() {
    if (!style.hasDecorations) {
      return null;
    }

    return BoxDecoration(
      color: style.backgroundColor?.color,
      image: style.backgroundImage,
      gradient: style.backgroundGradient,
      border:
          style.border?.toBorder(style.borderColor, style.borderStrokeAlign),
      borderRadius: style.borderRadius?.toBorderRadius(),
      boxShadow: style.boxShadow?.toBoxShadows(style.boxShadowColor),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      key: key,
      alignment: alignment,
      padding: style.padding?.toEdgeInsets(),
      color: !style.hasDecorations ? style.backgroundColor?.color : null,
      decoration: _boxDecoration(),
      foregroundDecoration: null,
      width: style.width.value.logicalPixels,
      height: style.height.value.logicalPixels,
      constraints: null,
      margin: style.margin?.toEdgeInsets(),
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
