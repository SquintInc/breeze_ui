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
  /// The value can only be set to null if [tristate] is true.
  /// Defaults to false.
  final bool? value;

  /// Whether this checkbox is a tristate checkbox. If enabled, the checkbox supports
  /// three states: true, false, and null.
  final bool tristate;

  /// Called when the internal selected state of the checkbox changes.
  /// The boolean value can be null if [tristate] is true.
  final ValueChanged<bool?>? onToggled;

  /// The tap target size of the checkbox widget.
  /// Defaults to 48.0 pixels as per Material Design guidelines.
  final CssAbsoluteUnit tapTargetSize;

  /// Custom icon to use for when the checkbox is checked.
  final TwIconData checkedIcon;

  /// Custom icon to use for when [isTristate] is true and the checkbox is in the neutral (null)
  /// state.
  final TwIconData? neutralIcon;

  /// Custom icon to use for when the checkbox is unchecked.
  final TwIconData? uncheckedIcon;

  const TwCheckbox({
    this.onToggled,
    this.value = false,
    this.tristate = false,
    this.tapTargetSize = minTapTargetSize,
    this.checkedIcon = const IconDataFont(Icons.check),
    this.neutralIcon = const IconDataFont(Icons.remove),
    this.uncheckedIcon,
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
    super.isTristate = false,
    // Input controllers,
    super.statesController,
    super.focusNode,
    super.key,
  })  : assert(tristate || value != null),
        super(
          enableInputDetectors: isToggleable,
          enableFeedback: isToggleable,
          canRequestFocus: isToggleable,
          cursor: MaterialStateMouseCursor.clickable,
          onSelected: onToggled,
          isToggled: value != null && value,
          isDraggable: true,
        );

  @override
  State createState() => _CheckboxState();
}

class _CheckboxState extends TwAnimatedMaterialState<TwCheckbox>
    with SingleTickerProviderStateMixin {
  TwIconData? get iconData {
    return switch (isSelected) {
      true => widget.checkedIcon,
      null => widget.neutralIcon,
      false => widget.uncheckedIcon,
    };
  }

  @override
  Widget build(final BuildContext context) {
    final currentStyle = getCurrentStyle(currentStates);
    final animatedStyle = currentStyle.merge(getAnimatedStyle());

    final TwIcon? icon = iconData != null
        ? TwIcon(
            icon: iconData!,
            expand: true,
            staticConstraints: currentStyle.toConstraints(),
            style: TwCheckbox.defaultCheckboxStyle.copyWith(
              textColor: animatedStyle.textColor ??
                  ((isSelected ?? true)
                      ? (widget.selected?.textColor ??
                          TwCheckbox.defaultCheckboxStyle.textColor)
                      : TwCheckbox.defaultUncheckedTextColor),
              width:
                  animatedStyle.width ?? TwCheckbox.defaultCheckboxStyle.width,
              height: animatedStyle.height ??
                  TwCheckbox.defaultCheckboxStyle.height,
            ),
          )
        : null;

    final div = Div(
      style: animatedStyle,
      staticConstraints: currentStyle.toConstraints(),
      parentControlsOpacity: true,
      child: icon,
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
