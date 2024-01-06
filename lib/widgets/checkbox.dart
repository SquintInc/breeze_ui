import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/sizing/height.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/widgets.dart';
import 'package:tailwind_elements/widgets/state/animated_material_state.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';

/// A widget meant to represent a [Checkbox] with custom styling via Tailwind
/// styled properties.
@immutable
class TwCheckbox extends TwStatefulWidget {
  static const double minTapTargetSizePx = 48.0;
  static const double defaultCheckmarkSizePx = 16.0;
  static const TwStyle defaultCheckboxStyle = TwStyle(
    width: TwWidth(PxUnit(defaultCheckmarkSizePx)),
    height: TwHeight(PxUnit(defaultCheckmarkSizePx)),
    textColor: TwTextColor(Colors.black),
  );

  /// Initial value of the checkbox.
  final bool? value;

  /// Called when the internal selected state of the checkbox changes.
  final ValueChanged<bool>? onToggled;

  /// The tap target size of the checkbox widget, defaults to 48.0 pixels as per Material Design
  /// guidelines.
  final CssAbsoluteUnit tapTargetSize;

  /// Custom icon to use for the checkmark icon.
  final TwIconData icon;

  const TwCheckbox({
    required this.value,
    this.onToggled,
    this.tapTargetSize = const PxUnit(minTapTargetSizePx),
    this.icon = const IconFontData(Icons.check),
    super.style = defaultCheckboxStyle,
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    super.isDisabled,
    super.isToggleable = true,
    super.key,
  }) : super(
          // Have the checkbox for display only if "isSelectable" is false
          enableInputDetectors: isToggleable,
          enableFeedback: true,
          canRequestFocus: isToggleable,
          cursor: MaterialStateMouseCursor.clickable,
          onSelected: onToggled,
          isToggled: value ?? false,
          isDraggable: true,
        );

  @override
  State createState() => _CheckboxState();
}

class _CheckboxState extends TwAnimatedMaterialState<TwCheckbox> {
  @override
  TwStyle getCurrentStyle() {
    final states = currentStates;
    final normalStyle = widget.style.copyWith(
      textColor: isSelected
          ? widget.selected?.textColor ?? widget.style.textColor
          : const TwTextColor(Colors.transparent),
    );
    if (states.contains(MaterialState.disabled)) {
      return normalStyle.merge(widget.disabled);
    }
    if (states.contains(MaterialState.dragged)) {
      return normalStyle.merge(widget.pressed).merge(widget.dragged).copyWith(
            textColor: isSelected
                ? widget.selected?.textColor ?? widget.style.textColor
                : const TwTextColor(Colors.transparent),
          );
    }
    if (states.contains(MaterialState.error)) {
      return normalStyle.merge(widget.errored);
    }
    if (states.contains(MaterialState.focused)) {
      return normalStyle.merge(widget.focused);
    }
    if (states.contains(MaterialState.pressed)) {
      return normalStyle.merge(widget.pressed).copyWith(
            textColor: !isSelected
                ? widget.selected?.textColor ?? widget.style.textColor
                : const TwTextColor(Colors.transparent),
          );
    }
    if (states.contains(MaterialState.selected)) {
      return normalStyle.merge(widget.selected);
    }
    if (states.contains(MaterialState.hovered)) {
      return normalStyle.merge(widget.hovered);
    }
    return normalStyle;
  }

  @override
  Widget build(final BuildContext context) {
    final currentStyle = getCurrentStyle();
    final animatedStyle = currentStyle.merge(getAnimatedStyle());

    final TwIcon checkmarkIcon = TwIcon(
      icon: widget.icon,
      style: animatedStyle.copyWith(
        width: animatedStyle.width ?? TwCheckbox.defaultCheckboxStyle.width,
        height: animatedStyle.height ?? TwCheckbox.defaultCheckboxStyle.height,
      ),
    );

    final div = Div(
      key: widget.key,
      style: animatedStyle,
      staticConstraints: currentStyle.toConstraints(),
      child: checkmarkIcon,
    );

    Widget current = div;
    current = conditionallyWrapOpacity(current, animatedStyle);
    current = conditionallyWrapInputDetectors(current);
    current = conditionallyWrapFocus(current, includeFocusActions: true);

    // TODO: Implement tap target size

    return current;
  }
}
