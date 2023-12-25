import 'package:flutter/material.dart';

enum TwWidgetState {
  disabled,
  dragged,
  error,
  focused,
  selected,
  pressed,
  hovered,
  normal,
}

/// Returns the 'most important' state of the widget from the current set of
/// material states, to specify which style should be used.
TwWidgetState getPrimaryWidgetState(final Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) return TwWidgetState.disabled;
  if (states.contains(MaterialState.dragged)) return TwWidgetState.dragged;
  if (states.contains(MaterialState.error)) return TwWidgetState.error;
  if (states.contains(MaterialState.focused)) return TwWidgetState.focused;
  if (states.contains(MaterialState.selected)) return TwWidgetState.selected;
  if (states.contains(MaterialState.pressed)) return TwWidgetState.pressed;
  if (states.contains(MaterialState.hovered)) return TwWidgetState.hovered;
  return TwWidgetState.normal;
}
