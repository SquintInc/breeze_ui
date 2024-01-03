import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/div.dart';
import 'package:tailwind_elements/widgets/state/widget_state.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A [TextButton] widget wrapper with support for Tailwind styled properties.
///
/// See the [build] method for more details about the implementation choice.
@immutable
class TwButton extends StatefulWidget {
  /// Default style properties for this widget.
  /// Corresponds to [TwWidgetState.normal].
  final TwStyle style;

  /// Style override for when the widget is disabled.
  /// Corresponds to [TwWidgetState.disabled].
  final TwStyle? disabled;

  /// Style override for when the widget is pressed
  /// Corresponds to [TwWidgetState.pressed].
  final TwStyle? pressed;

  /// Style override for when the widget is hovered
  /// Corresponds to [TwWidgetState.hovered].
  final TwStyle? hovered;

  /// Style override for when the widget is dragged
  /// Corresponds to [TwWidgetState.dragged].
  final TwStyle? dragged;

  /// Style override for when the widget is focused (if applicable).
  /// Corresponds to [TwWidgetState.focused].
  final TwStyle? focused;

  /// Style override for when the widget is selected (if applicable).
  /// Corresponds to [TwWidgetState.selected].
  final TwStyle? selected;

  /// Style override for when the widget has an error (if applicable).
  /// Corresponds to [TwWidgetState.error].
  final TwStyle? errored;

  final MaterialStatesController? statesController;

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
  final AlignmentGeometry alignment;

  const TwButton({
    this.style = const TwStyle(),
    this.disabled,
    this.pressed,
    this.hovered,
    this.dragged,
    this.focused,
    this.selected,
    this.errored,
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
    this.alignment = Alignment.center,
    this.transform,
    this.transformAlignment,
    this.statesController,
    super.key,
  });

  @override
  State createState() => _TwButtonState();

  bool get enabled => onPressed != null || onLongPress != null;
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
      animationDuration: transition != null
          ? transitionDuration?.duration.value
          : Duration.zero,
    );
  }
}

class _TwButtonState extends State<TwButton> {
  MaterialStatesController? internalStatesController;

  MaterialStatesController get statesController =>
      widget.statesController ?? internalStatesController!;

  void handleStatesControllerChange() {
    // Force a rebuild in the next frame to resolve MaterialStateProperty
    // properties, because the underlying [TextButton] widget will already call
    // setState() in the current frame.
    WidgetsBinding.instance.addPostFrameCallback((final timestamp) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.statesController == null) {
      internalStatesController = MaterialStatesController();
    }
    statesController.addListener(handleStatesControllerChange);
  }

  @override
  void dispose() {
    statesController.removeListener(handleStatesControllerChange);
    internalStatesController?.dispose();
    super.dispose();
  }

  /// Wrap the button in a [TwDiv] for simplicity of applying styles with
  /// support for animated transitions. Use a [Stack] to render the
  /// [TextButton] over the [TwDiv] due to how [statesController] notifies
  /// its listeners and marks each widget listening in as dirty.
  ///
  /// Why not render the [TextButton] as a child of the [TwDiv]? This is because
  /// the [statesController] is shared between the [TwDiv] and the [TextButton].
  /// The [TwDiv] would be marked as dirty and would rebuild whenever the
  /// current widget state and style changes, which would propagate a rebuild
  /// to the child widget. However, the [statesController] is updated by the
  /// [TextButton], which would cause a setState() call on the [TextButton] but
  /// also a setState() call on the [TwDiv].  This would cause a `setState() or
  /// markNeedsBuild() called when widget tree was locked` error during
  /// rendering. Using a [Stack] prevents the setState() dependency loop when
  /// rebuilding both the [TwDiv] and [TextButton].
  @override
  Widget build(final BuildContext context) {
    final widgetState = getPrimaryWidgetState(statesController.value);
    final stateStyle = switch (widgetState) {
      TwWidgetState.disabled => widget.disabled,
      TwWidgetState.pressed => widget.pressed,
      TwWidgetState.hovered => widget.hovered,
      TwWidgetState.dragged => widget.dragged,
      TwWidgetState.focused => widget.focused,
      TwWidgetState.selected => widget.selected,
      TwWidgetState.error => widget.errored,
      _ => widget.style,
    };
    final mergedStyle = widget.style.merge(stateStyle);

    final child = widget.child ?? const SizedBox();

    return Stack(
      alignment: Alignment.center,
      children: [
        TwDiv(
          alignment: widget.alignment,
          key: widget.key,
          style: widget.style,
          disabled: widget.disabled,
          pressed: widget.pressed,
          hovered: widget.hovered,
          dragged: widget.dragged,
          focused: widget.focused,
          selected: widget.selected,
          errored: widget.errored,
          isDisabled: widget.onPressed == null && widget.onLongPress == null,
          isSelectable: false,
          useGestureDetector: false,
          useMouseRegion: false,
          statesController: statesController,
          child: child,
        ),
        Positioned.fill(
          child: TextButton(
            style: mergedStyle.toButtonStyle(
              widget.tapTargetSize,
              widget.alignment,
            ),
            onPressed: widget.onPressed,
            onLongPress: widget.onLongPress,
            onHover: widget.onHover,
            onFocusChange: widget.onFocusChange,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            clipBehavior: widget.clipBehavior,
            statesController: statesController,
            // Hide the button's child because it is rendered by the TwDiv for intrinsic height
            // values when calculating the TwButton's padding.
            child: const SizedBox(),
          ),
        ),
      ],
    );
  }
}
