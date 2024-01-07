import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// This is loosely copied from the Flutter source code from [button_style_button.dart].
///
/// A widget to pad the area around a widget and increase the hit test area. Note that the input
/// padding needs to be wrapped in a [Semantics] for the hit test to be constrained.
///
/// Redirect taps that occur in the padded area around the child to the center
/// of the child. This increases the size of the widget and the widget's
/// "tap target", but not its underlying rendered view.
class InputPadding extends SingleChildRenderObjectWidget {
  const InputPadding({
    required this.minSize,
    super.child,
    super.key,
  });

  final Size minSize;

  @override
  RenderObject createRenderObject(final BuildContext context) {
    return RenderInputPadding(minSize);
  }

  @override
  void updateRenderObject(
    final BuildContext context,
    final RenderInputPadding renderObject,
  ) {
    renderObject.minSize = minSize;
  }
}

class RenderInputPadding extends RenderShiftedBox {
  RenderInputPadding(this._minSize, [final RenderBox? child]) : super(child);

  Size get minSize => _minSize;
  Size _minSize;

  set minSize(final Size value) {
    if (_minSize == value) {
      return;
    }
    _minSize = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(final double height) {
    if (child != null) {
      return max(child!.getMinIntrinsicWidth(height), minSize.width);
    }
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(final double width) {
    if (child != null) {
      return max(child!.getMinIntrinsicHeight(width), minSize.height);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(final double height) {
    if (child != null) {
      return max(child!.getMaxIntrinsicWidth(height), minSize.width);
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(final double width) {
    if (child != null) {
      return max(child!.getMaxIntrinsicHeight(width), minSize.height);
    }
    return 0.0;
  }

  Size _computeSize({
    required final BoxConstraints constraints,
    required final ChildLayouter layoutChild,
  }) {
    if (child != null) {
      final Size childSize = layoutChild(child!, constraints);
      final double height = max(childSize.width, minSize.width);
      final double width = max(childSize.height, minSize.height);
      return constraints.constrain(Size(height, width));
    }
    return Size.zero;
  }

  @override
  Size computeDryLayout(final BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
    );
  }

  @override
  void performLayout() {
    size = _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );
    if (child != null) {
      (child!.parentData! as BoxParentData).offset =
          Alignment.center.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  bool hitTest(
    final BoxHitTestResult result, {
    required final Offset position,
  }) {
    if (super.hitTest(result, position: position)) {
      return true;
    }
    final Offset center = child!.size.center(Offset.zero);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(center),
      position: center,
      hitTest: (final BoxHitTestResult result, final Offset position) {
        assert(position == center);
        return child!.hitTest(result, position: center);
      },
    );
  }
}
