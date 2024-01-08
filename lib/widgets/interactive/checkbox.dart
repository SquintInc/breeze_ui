import 'package:flutter/material.dart';
import 'package:tailwind_elements/config/options/colors.dart';
import 'package:tailwind_elements/config/options/sizing/height.dart';
import 'package:tailwind_elements/config/options/sizing/width.dart';
import 'package:tailwind_elements/config/options/units/measurement_unit.dart';
import 'package:tailwind_elements/widgets/rendering/input_padding.dart';
import 'package:tailwind_elements/widgets/state/animated_material_state.dart';
import 'package:tailwind_elements/widgets/state/stateful_widget.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
import 'package:tailwind_elements/widgets/stateless/icon.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// A Checkbox widget with support for Tailwind styled properties.
@immutable
class TwCheckbox extends TwStatefulWidget {
  static const PxUnit minTapTargetSize = PxUnit(48.0);
  static const PxUnit defaultCheckmarkSize = PxUnit(16.0);
  static const TwStyle defaultCheckboxStyle = TwStyle(
    width: TwWidth(defaultCheckmarkSize),
    height: TwHeight(defaultCheckmarkSize),
    textColor: TwTextColor(Colors.black),
  );
  static const TwTextColor defaultUncheckedTextColor =
      TwTextColor(Colors.transparent);

  /// Initial value of the checkbox.
  final bool value;

  /// Called when the internal selected state of the checkbox changes.
  final ValueChanged<bool>? onToggled;

  /// The tap target size of the checkbox widget.
  /// Defaults to 48.0 pixels as per Material Design guidelines.
  final CssAbsoluteUnit tapTargetSize;

  /// Custom icon to use for the checkmark icon.
  final TwIconData icon;

  const TwCheckbox({
    this.onToggled,
    this.value = false,
    this.tapTargetSize = minTapTargetSize,
    this.icon = const IconDataFont(Icons.check),
    // Style properties
    super.style = defaultCheckboxStyle,
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    // Toggleable booleans
    super.isDisabled,
    super.isToggleable = true,
    // Input controllers,
    super.statesController,
    super.focusNode,
    super.key,
  }) : super(
          enableInputDetectors: isToggleable,
          enableFeedback: isToggleable,
          canRequestFocus: isToggleable,
          cursor: MaterialStateMouseCursor.clickable,
          onSelected: onToggled,
          isToggled: value,
          isDraggable: true,
        );

  @override
  State createState() => _CheckboxState();
}

class _CheckboxState extends TwAnimatedMaterialState<TwCheckbox>
    with SingleTickerProviderStateMixin {
  @override
  TwStyle getCurrentStyle(final Set<MaterialState> states) {
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
    final currentStyle = getCurrentStyle(currentStates);
    final animatedStyle = currentStyle.merge(getAnimatedStyle());

    final TwIcon checkmarkIcon = TwIcon(
      icon: widget.icon,
      expand: true,
      staticConstraints: currentStyle.toConstraints(),
      style: TwCheckbox.defaultCheckboxStyle.copyWith(
        textColor: animatedStyle.textColor ??
            (isSelected
                ? (widget.selected?.textColor ??
                    TwCheckbox.defaultCheckboxStyle.textColor)
                : TwCheckbox.defaultUncheckedTextColor),
        width: animatedStyle.width ?? TwCheckbox.defaultCheckboxStyle.width,
        height: animatedStyle.height ?? TwCheckbox.defaultCheckboxStyle.height,
      ),
    );

    final div = Div(
      style: animatedStyle,
      staticConstraints: currentStyle.toConstraints(),
      parentControlsOpacity: true,
      child: checkmarkIcon,
    );

    // Input padding needs to be wrapped in Semantics for hit test to be constrained
    return Semantics(
      container: true,
      checked: widget.value,
      enabled: !widget.isDisabled,
      child: InputPadding(
        minSize: Size.square(widget.tapTargetSize.pixels()),
        child: conditionallyWrapFocus(
          conditionallyWrapInputDetectors(
            conditionallyWrapOpacity(div, animatedStyle),
          ),
          includeFocusActions: true,
        ),
      ),
    );
  }

  @override
  TickerProvider getTickerProvider() => this;
}
