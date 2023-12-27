import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/box_types.dart';
import 'package:tailwind_elements/widgets/div.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

extension TwStyleButtonExtension on TwStyle {
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

  Size _buttonSize({
    required final double? widthPx,
    required final double? heightPx,
  }) {
    if (widthPx != null && heightPx != null) return Size(widthPx, heightPx);
    if (widthPx != null) return Size.fromWidth(widthPx);
    if (heightPx != null) return Size.fromHeight(heightPx);
    return Size.infinite;
  }

  MaterialStateProperty<T> whenStyleStatus<T>(
    final StyleValueResolver resolver, {
    required final T defaultValue,
  }) =>
      TwStyle.resolveStatus(
        style,
        resolver,
        defaultValue: defaultValue,
        disabled: disabled,
        dragged: null,
        error: null,
        focused: focused,
        selected: null,
        pressed: pressed,
        hovered: hovered,
      );

  ButtonStyle _buttonStyle({
    required final double? widthPx,
    required final double? heightPx,
  }) =>
      ButtonStyle(
        foregroundColor: whenStyleStatus(
          (final statusStyle) => statusStyle?.textColor?.color,
          defaultValue: Colors.black,
        ),
        backgroundColor: whenStyleStatus(
          (final statusStyle) => statusStyle?.backgroundColor?.color,
          defaultValue: Colors.transparent,
        ),
        fixedSize: always(
          _buttonSize(
            widthPx: widthPx,
            heightPx: heightPx,
          ),
        ),
        padding: whenStyleStatus(
          (final statusStyle) => statusStyle?.padding?.toEdgeInsets(),
          defaultValue: EdgeInsets.zero,
        ),
        shape: style.hasBorderDecoration
            ? whenStyleStatus(
                (final statusStyle) => RoundedRectangleBorder(
                  borderRadius:
                      statusStyle?.borderRadius?.type == BoxCornerType.all
                          ? style.borderRadius?.toBorderRadius() ??
                              BorderRadius.zero
                          : BorderRadius.zero,
                  side: statusStyle?.toBorderSide() ?? style.toBorderSide(),
                ),
                defaultValue: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  side: style.toBorderSide(),
                ),
              )
            : always(const RoundedRectangleBorder()),
        side: style.hasBorderDecoration
            ? whenStyleStatus(
                (final statusStyle) => statusStyle?.toBorderSide(),
                defaultValue: style.toBorderSide(),
              )
            : null,
        // Currently no support for overlay color
        overlayColor: always(Colors.transparent),
        // Currently no support for elevation color
        elevation: always(0),
        shadowColor: null,
        animationDuration: animationDuration,
        tapTargetSize: tapTargetSize,
        alignment: alignment,
      );

  bool get requiresDivWrapper =>
      style.requiresDivWrapper ||
      (disabled?.requiresDivWrapper ?? false) ||
      (focused?.requiresDivWrapper ?? false) ||
      (pressed?.requiresDivWrapper ?? false) ||
      (hovered?.requiresDivWrapper ?? false);

  TextButton _createTextButton({
    required final double? widthPx,
    required final double? heightPx,
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
                  final parentWidth =
                      parentConstraints.limitedMaxWidth(context);
                  final parentHeight = parentConstraints.maxHeight;
                  final widthPx = style.widthPx(parentWidth);
                  final heightPx = style.heightPx(parentHeight);

                  return _createTextButton(
                    widthPx: widthPx,
                    heightPx: heightPx,
                  );
                },
              )
            : _createTextButton(
                widthPx: style.width?.value.logicalPixels,
                heightPx: style.height?.value.logicalPixels,
              ),
      );
    }

    return _createTextButton(
      widthPx: style.width?.value.logicalPixels,
      heightPx: style.height?.value.logicalPixels,
    );
  }
}
