import 'package:flutter/material.dart' show MaterialState;
import 'package:meta/meta.dart';
import 'package:tailwind_elements/widgets/state/material_state.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

typedef TwStyleResolver = TwStyle Function(
  Set<MaterialState> states, {
  required bool? isSelected,
  required bool? previousSelected,
  required bool isDisabled,
  required TwStyle style,
  required TwStyle? disabled,
  required TwStyle? pressed,
  required TwStyle? hovered,
  required TwStyle? dragged,
  required TwStyle? focused,
  required TwStyle? selected,
  required TwStyle? errored,
});

/// Data class to hold the main style and modifier styles as a single group.
@immutable
class TwStyleGroup {
  final TwStyle style;
  final TwStyle? disabled;
  final TwStyle? pressed;
  final TwStyle? hovered;
  final TwStyle? dragged;
  final TwStyle? focused;
  final TwStyle? selected;
  final TwStyle? errored;

  /// Optional style resolver to override the default style resolver in a [TwMaterialState] widget.
  final TwStyleResolver? styleResolver;

  const TwStyleGroup({
    required this.style,
    this.disabled,
    this.pressed,
    this.hovered,
    this.dragged,
    this.focused,
    this.selected,
    this.errored,
    this.styleResolver,
  });

  @override
  String toString() {
    return 'TwStyleGroup{style: $style, disabled: $disabled, pressed: $pressed, hovered: $hovered, dragged: $dragged, focused: $focused, selected: $selected, errored: $errored, styleResolver: $styleResolver}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwStyleGroup &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          disabled == other.disabled &&
          pressed == other.pressed &&
          hovered == other.hovered &&
          dragged == other.dragged &&
          focused == other.focused &&
          selected == other.selected &&
          errored == other.errored &&
          styleResolver == other.styleResolver;

  @override
  int get hashCode =>
      style.hashCode ^
      disabled.hashCode ^
      pressed.hashCode ^
      hovered.hashCode ^
      dragged.hashCode ^
      focused.hashCode ^
      selected.hashCode ^
      errored.hashCode ^
      styleResolver.hashCode;
}
