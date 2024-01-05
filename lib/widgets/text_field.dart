import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

@immutable
class TwLabel {
  final String? text;
  final Widget? widget;

  final TwStyle? style;
  final TwStyle? disabled;
  final TwStyle? error;
  final TwStyle? focused;
  final TwStyle? hovered;

  /// Whether the label should float above the content.
  final bool floating;

  /// If [floating], the label will always float above the
  /// content, otherwise it will only float when the content is focused or
  /// filled.
  final bool alwaysFloat;

  /// If [floating], this specifies the alignment of the floating label.
  final FloatingLabelAlignment? floatingLabelAlignment;

  /// If a label and hint is provided in the [TwTextField], this controls label
  /// placement. See [InputDecoration.alignLabelWithHint].
  final bool? alignLabelWithHint;

  const TwLabel({
    this.text,
    this.widget,
    this.style,
    this.disabled,
    this.error,
    this.focused,
    this.hovered,
    this.floating = false,
    this.alwaysFloat = false,
    this.floatingLabelAlignment,
    this.alignLabelWithHint,
  }) : assert(
          !(text != null && widget != null),
          'Cannot provide both text and widget to a floating label',
        );

  MaterialStateTextStyle toMaterialTextStyle(
    final TwStyle defaultTextStyle,
  ) =>
      TwStyle.resolveMaterialTextStyle(
        style ?? defaultTextStyle,
        disabled: disabled,
        dragged: null,
        error: error,
        focused: focused,
        selected: null,
        pressed: null,
        hovered: hovered,
      );
}

@immutable
class TwSubtext {
  final String? text;
  final TwStyle? style;
  final TwStyle? disabled;
  final TwStyle? error;
  final TwStyle? focused;
  final TwStyle? hovered;
  final int? maxLines;

  const TwSubtext({
    this.text,
    this.style,
    this.disabled,
    this.error,
    this.focused,
    this.hovered,
    this.maxLines,
  });

  MaterialStateTextStyle toMaterialTextStyle(
    final TwStyle defaultTextStyle,
  ) =>
      TwStyle.resolveMaterialTextStyle(
        style ?? defaultTextStyle,
        disabled: disabled,
        dragged: null,
        error: error,
        focused: focused,
        selected: null,
        pressed: null,
        hovered: hovered,
      );
}

@immutable
class TwHint {
  final String? text;
  final TwStyle? style;
  final TwStyle? disabled;
  final TwStyle? error;
  final TwStyle? focused;
  final TwStyle? hovered;
  final int? maxLines;
  final TextDirection? textDirection;
  final Duration? fadeDuration;

  const TwHint({
    this.text,
    this.style,
    this.disabled,
    this.error,
    this.focused,
    this.hovered,
    this.maxLines,
    this.textDirection,
    this.fadeDuration,
  });

  MaterialStateTextStyle toMaterialTextStyle(
    final TwStyle defaultTextStyle,
  ) =>
      TwStyle.resolveMaterialTextStyle(
        style ?? defaultTextStyle,
        disabled: disabled,
        dragged: null,
        error: error,
        focused: focused,
        selected: null,
        pressed: null,
        hovered: hovered,
      );
}

@immutable
class TwError {
  final String? text;
  final Widget? widget;
  final TwStyle? style;
  final TwStyle? disabled;
  final TwStyle? error;
  final TwStyle? focused;
  final TwStyle? hovered;
  final int? maxLines;

  const TwError({
    this.text,
    this.widget,
    this.style,
    this.disabled,
    this.error,
    this.focused,
    this.hovered,
    this.maxLines,
  }) : assert(
          !(text != null && widget != null),
          'Cannot provide both text and widget to an error label subcomponent',
        );

  MaterialStateTextStyle toMaterialTextStyle(
    final TwStyle defaultTextStyle,
  ) =>
      TwStyle.resolveMaterialTextStyle(
        style ?? defaultTextStyle,
        disabled: disabled,
        dragged: null,
        error: error,
        focused: focused,
        selected: null,
        pressed: null,
        hovered: hovered,
      );
}

@immutable
class TwCounter {
  final String? text;
  final Widget? widget;
  final TwStyle? style;
  final TwStyle? disabled;
  final TwStyle? error;
  final TwStyle? focused;
  final TwStyle? hovered;
  final String? semanticText;

  const TwCounter({
    this.text,
    this.widget,
    this.style,
    this.disabled,
    this.error,
    this.focused,
    this.hovered,
    this.semanticText,
  }) : assert(
          !(text != null && widget != null),
          'Cannot provide both text and widget to a counter subcomponent',
        );

  MaterialStateTextStyle toMaterialTextStyle(
    final TwStyle defaultTextStyle,
  ) =>
      TwStyle.resolveMaterialTextStyle(
        style ?? defaultTextStyle,
        disabled: disabled,
        dragged: null,
        error: error,
        focused: focused,
        selected: null,
        pressed: null,
        hovered: hovered,
      );
}

@immutable
class TwTextField extends TextField {
  /// Default style properties for this widget.
  /// Corresponds to [TwWidgetState.normal].
  final TwStyle _style;

  /// Style override for when the widget is disabled.
  /// Corresponds to [TwWidgetState.disabled].
  final TwStyle? disabled;

  /// Style override for when the widget is hovered
  /// Corresponds to [TwWidgetState.hovered].
  final TwStyle? hovered;

  /// Style override for when the widget is focused (if applicable).
  /// Corresponds to [TwWidgetState.focused].
  final TwStyle? focused;

  /// Style override for when the widget has an error (if applicable).
  /// Corresponds to [TwWidgetState.error].
  final TwStyle? errored;

  /// See [InputDecoration.isCollapsed]
  final bool? isCollapsed;

  /// See [InputDecoration.isDense]
  final bool? isDense;

  /// TextField label sub-component (can also float)
  final TwLabel? inputLabel;

  /// TextField subtext sub-component (helper text)
  final TwSubtext? subtext;

  /// TextField placeholder sub-component
  final TwHint? placeholder;

  /// TextField error label sub-component
  final TwError? errorLabel;

  /// TextField counter sub-component
  final TwCounter? counter;

  /// Copied directly from [TextField._defaultContextMenuBuilder]
  static Widget _defaultContextMenuBuilder(
    final BuildContext context,
    final EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  const TwTextField({
    final TwStyle style = const TwStyle(),
    this.disabled,
    this.errored,
    this.focused,
    this.hovered,
    this.isCollapsed,
    this.isDense,
    this.inputLabel,
    this.subtext,
    this.placeholder,
    this.errorLabel,
    this.counter,
    // Passthrough properties
    super.controller,
    super.focusNode,
    super.undoController,
    super.textInputAction,
    super.textCapitalization = TextCapitalization.none,
    super.strutStyle,
    super.textAlign = TextAlign.start,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly = false,
    super.showCursor,
    super.autofocus = false,
    super.obscuringCharacter = '•',
    super.obscureText = false,
    super.autocorrect = true,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions = true,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onAppPrivateCommand,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorOpacityAnimates,
    super.cursorColor,
    super.selectionHeightStyle = BoxHeightStyle.tight,
    super.selectionWidthStyle = BoxWidthStyle.tight,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.dragStartBehavior = DragStartBehavior.start,
    super.enableInteractiveSelection,
    super.selectionControls,
    super.onTap,
    super.onTapOutside,
    super.mouseCursor,
    super.buildCounter,
    super.scrollController,
    super.scrollPhysics,
    super.autofillHints = const <String>[],
    super.contentInsertionConfiguration,
    super.clipBehavior = Clip.hardEdge,
    super.restorationId,
    super.scribbleEnabled = true,
    super.enableIMEPersonalizedLearning = true,
    super.contextMenuBuilder = _defaultContextMenuBuilder,
    super.canRequestFocus = true,
    super.spellCheckConfiguration,
    super.magnifierConfiguration,
    super.key,
  })  : _style = style,
        super();

  @override
  TextStyle? get style => TwStyle.resolveMaterialTextStyle(
        _style,
        disabled: disabled,
        dragged: null,
        error: errored,
        focused: focused,
        selected: null,
        pressed: null,
        hovered: hovered,
      );

  InputBorder? _resolveMaterialInputBorder() =>
      TwStyle.resolveMaterialInputBorder(
        _style,
        disabled: disabled,
        dragged: null,
        error: errored,
        focused: focused,
        selected: null,
        pressed: null,
        hovered: hovered,
      );

  Color? _resolveBackgroundColor() =>
      MaterialStateColor.resolveWith((final Set<MaterialState> states) {
        final currentStyle = TwStyle.defaultStyleResolver(
          states,
          normal: _style,
          disabled: disabled,
          dragged: null,
          errored: errored,
          focused: focused,
          selected: null,
          pressed: null,
          hovered: hovered,
        );
        return currentStyle.backgroundColor?.color ?? Colors.transparent;
      });

  @override
  InputDecoration get decoration {
    final labelStyle = inputLabel?.toMaterialTextStyle(_style);
    return InputDecoration(
      isCollapsed: isCollapsed,
      isDense: isDense,

      // Label sub-component
      floatingLabelBehavior: inputLabel?.floating == true
          ? (inputLabel?.alwaysFloat == true
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto)
          : null,
      labelText: inputLabel?.text,
      label: inputLabel?.widget,
      labelStyle: labelStyle,
      floatingLabelStyle: labelStyle,
      floatingLabelAlignment: inputLabel?.floatingLabelAlignment,
      alignLabelWithHint: inputLabel?.alignLabelWithHint,

      // Subtext sub-component
      helperText: subtext?.text,
      helperStyle: subtext?.toMaterialTextStyle(_style),
      helperMaxLines: subtext?.maxLines,

      // Placeholder sub-component
      hintText: placeholder?.text,
      hintStyle: placeholder?.toMaterialTextStyle(_style),
      hintMaxLines: placeholder?.maxLines,
      hintTextDirection: placeholder?.textDirection,
      hintFadeDuration: placeholder?.fadeDuration,

      // Error sub-component
      errorText: errorLabel?.text,
      error: errorLabel?.widget,
      errorStyle: errorLabel?.toMaterialTextStyle(_style),
      errorMaxLines: errorLabel?.maxLines,

      // Counter sub-component
      counter: counter?.widget,
      counterText: counter?.text,
      counterStyle: counter?.toMaterialTextStyle(_style),
      semanticCounterText: counter?.semanticText,

      // TextField container
      constraints: _style.getSimpleConstraints(),
      contentPadding: _style.padding?.toEdgeInsets(),
      // Don't set errorBorder, focusedBorder, focusedErrorBorder,
      // disabledBorder, nor enabledBorder, since we are using material state
      // resolver for the border
      border: _resolveMaterialInputBorder(),
      filled: _style.backgroundColor != null,
      fillColor: _resolveBackgroundColor(),
    );
  }
}
