import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/widgets/div.dart';
import 'package:tailwind_elements/widgets/style.dart';

extension TwStyleButtonExtension on TwStyle {
  /// Gets the [BorderSide] from a [TwStyle], which includes the border color
  /// and width. Note that Material buttons only support a single border width
  /// via TwBorder.all(...)
  BorderSide toBorderSide() => BorderSide(
        color: hasBorderDecoration
            ? borderColor?.color ?? Colors.transparent
            : Colors.transparent,
        width: border?.all.value.logicalPixels ?? 0.0,
        strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
      );

  bool get requiresDivWrapper =>
      boxShadow != null ||
      margin != null ||
      hasConstraints ||
      hasPercentageSize ||
      hasPercentageConstraints;
}

/// A [TextButton] widget wrapper with support for Tailwind styled properties.
@immutable
class TwButton extends StatelessWidget {
  /// Tailwind style properties (including styling for different button states)
  final TwStyle style;

  /// Style override for when the button is disabled
  final TwStyle? disabled;

  /// Style override for when the button is focused
  final TwStyle? focused;

  /// Style override for when the button is pressed
  final TwStyle? pressed;

  /// Style override for when the button is hovered
  final TwStyle? hovered;

  // Pass-through properties for [TextButton]
  final Widget? child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final MaterialStatesController? statesController;
  final bool isSemanticButton;

  // Pass-through properties for [ButtonStyle]
  final MaterialTapTargetSize tapTargetSize;
  final Duration animationDuration;
  final AlignmentGeometry? alignment;

  const TwButton({
    this.style = const TwStyle(),
    this.disabled,
    this.focused,
    this.pressed,
    this.hovered,
    this.child,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    this.isSemanticButton = true,
    this.tapTargetSize = MaterialTapTargetSize.padded,
    this.animationDuration = const Duration(milliseconds: 0),
    this.alignment,
    super.key,
  });

  ButtonStyle _buttonStyle({
    required final double widthPx,
    required final double heightPx,
  }) {
    return ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (final states) => switch (getSelectableState(states)) {
          SelectableState.normal ||
          SelectableState.dragged ||
          SelectableState.selected =>
            style.textColor?.color ?? Colors.black,
          SelectableState.disabled => disabled?.textColor?.color ??
              style.textColor?.color ??
              Colors.black,
          SelectableState.hovered =>
            hovered?.textColor?.color ?? style.textColor?.color ?? Colors.black,
          SelectableState.focused =>
            focused?.textColor?.color ?? style.textColor?.color ?? Colors.black,
          SelectableState.pressed =>
            pressed?.textColor?.color ?? style.textColor?.color ?? Colors.black,
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (final states) => switch (getSelectableState(states)) {
          SelectableState.normal ||
          SelectableState.dragged ||
          SelectableState.selected =>
            style.backgroundColor?.color ?? Colors.transparent,
          SelectableState.disabled => disabled?.backgroundColor?.color ??
              style.backgroundColor?.color ??
              Colors.transparent,
          SelectableState.hovered => hovered?.backgroundColor?.color ??
              style.backgroundColor?.color ??
              Colors.transparent,
          SelectableState.focused => focused?.backgroundColor?.color ??
              style.backgroundColor?.color ??
              Colors.transparent,
          SelectableState.pressed => pressed?.backgroundColor?.color ??
              style.backgroundColor?.color ??
              Colors.transparent,
        },
      ),
      minimumSize: MaterialStateProperty.all<Size>(
        Size(widthPx, heightPx),
      ),
      fixedSize: MaterialStateProperty.all<Size>(
        Size(widthPx, heightPx),
      ),
      maximumSize: MaterialStateProperty.all<Size>(
        Size(widthPx, heightPx),
      ),
      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
        (final states) => switch (getSelectableState(states)) {
          SelectableState.normal ||
          SelectableState.dragged ||
          SelectableState.selected =>
            style.padding?.toEdgeInsets() ?? EdgeInsets.zero,
          SelectableState.disabled => disabled?.padding?.toEdgeInsets() ??
              style.padding?.toEdgeInsets() ??
              EdgeInsets.zero,
          SelectableState.hovered => hovered?.padding?.toEdgeInsets() ??
              style.padding?.toEdgeInsets() ??
              EdgeInsets.zero,
          SelectableState.focused => focused?.padding?.toEdgeInsets() ??
              style.padding?.toEdgeInsets() ??
              EdgeInsets.zero,
          SelectableState.pressed => pressed?.padding?.toEdgeInsets() ??
              style.padding?.toEdgeInsets() ??
              EdgeInsets.zero,
        },
      ),
      shape: style.hasBorderDecoration
          ? MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (final states) => RoundedRectangleBorder(
                borderRadius: style.borderRadius?.type == BoxCornerType.all
                    ? style.borderRadius?.toBorderRadius() ?? BorderRadius.zero
                    : BorderRadius.zero,
                side: switch (getSelectableState(states)) {
                  SelectableState.normal ||
                  SelectableState.dragged ||
                  SelectableState.selected =>
                    style.toBorderSide(),
                  SelectableState.disabled =>
                    disabled?.toBorderSide() ?? style.toBorderSide(),
                  SelectableState.hovered =>
                    hovered?.toBorderSide() ?? style.toBorderSide(),
                  SelectableState.focused =>
                    focused?.toBorderSide() ?? style.toBorderSide(),
                  SelectableState.pressed =>
                    pressed?.toBorderSide() ?? style.toBorderSide(),
                },
              ),
            )
          : null,
      side: style.hasBorderDecoration
          ? MaterialStateProperty.resolveWith<BorderSide?>(
              (final states) => switch (getSelectableState(states)) {
                SelectableState.normal ||
                SelectableState.dragged ||
                SelectableState.selected =>
                  style.toBorderSide(),
                SelectableState.disabled =>
                  disabled?.toBorderSide() ?? style.toBorderSide(),
                SelectableState.hovered =>
                  hovered?.toBorderSide() ?? style.toBorderSide(),
                SelectableState.focused =>
                  focused?.toBorderSide() ?? style.toBorderSide(),
                SelectableState.pressed =>
                  pressed?.toBorderSide() ?? style.toBorderSide(),
              },
            )
          : null,
      // Currently no support for overlay color
      overlayColor: MaterialStateProperty.all<Color>(
        Colors.transparent,
      ),
      // Currently no support for elevation color
      elevation: MaterialStateProperty.all<double>(0),
      shadowColor: null,
      animationDuration: animationDuration,
      tapTargetSize: tapTargetSize,
      alignment: alignment,
    );
  }

  bool get requiresDivWrapper =>
      style.requiresDivWrapper ||
      (disabled?.requiresDivWrapper ?? false) ||
      (focused?.requiresDivWrapper ?? false) ||
      (pressed?.requiresDivWrapper ?? false) ||
      (hovered?.requiresDivWrapper ?? false);

  TextButton _textButton({
    required final double widthPx,
    required final double heightPx,
  }) =>
      TextButton(
        key: key,
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: _buttonStyle(
          widthPx: widthPx,
          heightPx: heightPx,
        ),
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        isSemanticButton: isSemanticButton,
        child: child ?? const SizedBox(),
      );

  @override
  Widget build(final BuildContext context) {
    if (requiresDivWrapper) {
      return TwDiv(
        key: key,
        alignment: alignment,
        clipBehavior: clipBehavior,
        style: TwStyle(
          width: style.width,
          height: style.height,
          borderRadius: style.borderRadius,
          boxShadow: style.boxShadow,
          margin: style.margin,
          minWidth: style.minWidth,
          minHeight: style.minHeight,
          maxWidth: style.maxWidth,
          maxHeight: style.maxHeight,
        ),
        child: (style.hasPercentageSize || style.hasPercentageConstraints)
            ? LayoutBuilder(
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

                  return _textButton(
                    widthPx: widthPx,
                    heightPx: heightPx,
                  );
                },
              )
            : _textButton(
                widthPx: style.width.value.logicalPixels,
                heightPx: style.height.value.logicalPixels,
              ),
      );
    }

    return _textButton(
      widthPx: style.width.value.logicalPixels,
      heightPx: style.height.value.logicalPixels,
    );
  }
}
