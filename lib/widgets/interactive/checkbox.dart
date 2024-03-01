import 'package:breeze_ui/config/options/colors.dart';
import 'package:breeze_ui/config/options/sizing/height.dart';
import 'package:breeze_ui/config/options/sizing/width.dart';
import 'package:breeze_ui/config/options/units/measurement_unit.dart';
import 'package:breeze_ui/widgets/rendering/input_padding.dart';
import 'package:breeze_ui/widgets/state/animated_material_state.dart';
import 'package:breeze_ui/widgets/state/stateful_widget.dart';
import 'package:breeze_ui/widgets/stateless/div.dart';
import 'package:breeze_ui/widgets/stateless/icon.dart';
import 'package:breeze_ui/widgets/style/style.dart';
import 'package:flutter/material.dart';

typedef IconStyleResolver = Function(
  TwStyle currStyle,
  Set<MaterialState> states,
);

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

  /// Initial value of the checkbox.
  /// The value can only be set to null if [isTristate] is true.
  /// Defaults to false.
  final bool? value;

  /// Called when the internal selected state of the checkbox changes.
  /// The boolean value can be null if [isTristate] is true.
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

  /// A custom function that resolves the style for the checked icon based on the current state.
  final IconStyleResolver? checkedIconStyleResolver;

  /// A custom function that resolves the style for the unchecked icon based on the current state.
  final IconStyleResolver? uncheckedIconStyleResolver;

  /// A custom function that resolves the style for the neutral icon based on the current state.
  final IconStyleResolver? neutralIconStyleResolver;

  const TwCheckbox({
    this.onToggled,
    this.value = false,
    this.tapTargetSize = minTapTargetSize,
    this.checkedIcon = const IconDataFont(Icons.check),
    this.neutralIcon = const IconDataFont(Icons.remove),
    this.uncheckedIcon,
    this.checkedIconStyleResolver,
    this.uncheckedIconStyleResolver,
    this.neutralIconStyleResolver,
    // Style properties
    super.style = defaultCheckboxStyle,
    super.disabled,
    super.pressed,
    super.hovered,
    super.dragged,
    super.focused,
    super.selected,
    super.errored,
    super.styleResolver,
    // Toggleable booleans
    super.isDisabled,
    super.isToggleable = true,
    super.isTristate = false,
    // Input controllers,
    super.statesController,
    super.focusNode,
    super.key,
  })  : assert(isTristate || value != null),
        super(
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
  TwIconData? get iconData {
    return switch (isSelected) {
      true => widget.checkedIcon,
      null => widget.neutralIcon,
      false => widget.uncheckedIcon,
    };
  }

  TwStyle? iconStyle(final TwStyle currStyle) => switch (isSelected) {
        true => widget.checkedIconStyleResolver?.call(currStyle, currentStates),
        null => widget.neutralIconStyleResolver?.call(currStyle, currentStates),
        false =>
          widget.uncheckedIconStyleResolver?.call(currStyle, currentStates),
      };

  @override
  Widget build(final BuildContext context) {
    final currentStyle = getCurrentStyle(currentStates);
    final animatedStyle = currentStyle.merge(getAnimatedStyle());

    final TwIcon? icon = iconData != null
        ? TwIcon(
            icon: iconData!,
            expand: true,
            staticConstraints: currentStyle.toConstraints(),
            alwaysIncludeFilters: widget.hasFilters,
            style: TwCheckbox.defaultCheckboxStyle
                .copyWith(
                  textColor: animatedStyle.textColor ??
                      TwCheckbox.defaultCheckboxStyle.textColor,
                  width: animatedStyle.width ??
                      TwCheckbox.defaultCheckboxStyle.width,
                  height: animatedStyle.height ??
                      TwCheckbox.defaultCheckboxStyle.height,
                )
                .merge(iconStyle(animatedStyle)),
          )
        : null;

    final div = Div(
      style: animatedStyle,
      staticConstraints: currentStyle.toConstraints(),
      parentControlsOpacity: true,
      alwaysIncludeFilters: widget.hasFilters,
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
