import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tailwind_elements/widgets/style.dart';

@immutable
class TwLabel {
  final String? text;
  final Widget? widget;

  final TwTextStyle? style;
  final TwTextStyle? disabled;
  final TwTextStyle? error;
  final TwTextStyle? focused;
  final TwTextStyle? hovered;

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
    final TwTextStyle defaultTextStyle,
  ) =>
      TwTextStyle.toMaterialTextStyle(
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
  final TwTextStyle? style;
  final TwTextStyle? disabled;
  final TwTextStyle? error;
  final TwTextStyle? focused;
  final TwTextStyle? hovered;
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
    final TwTextStyle defaultTextStyle,
  ) =>
      TwTextStyle.toMaterialTextStyle(
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
  final TwTextStyle? style;
  final TwTextStyle? disabled;
  final TwTextStyle? error;
  final TwTextStyle? focused;
  final TwTextStyle? hovered;
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
    final TwTextStyle defaultTextStyle,
  ) =>
      TwTextStyle.toMaterialTextStyle(
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
  final TwTextStyle? style;
  final TwTextStyle? disabled;
  final TwTextStyle? error;
  final TwTextStyle? focused;
  final TwTextStyle? hovered;
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
          'Cannot provide both text and widget to an error subcomponent',
        );

  MaterialStateTextStyle toMaterialTextStyle(
    final TwTextStyle defaultTextStyle,
  ) =>
      TwTextStyle.toMaterialTextStyle(
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
  /// Tailwind text style properties
  final TwTextInputStyle textInputStyle;

  /// Style override for when the text field is disabled
  final TwTextInputStyle? disabled;

  /// Style override for when the text field has an error
  final TwTextInputStyle? error;

  /// Style override for when the text field is focused
  final TwTextInputStyle? focused;

  /// Style override for when the text field is hovered
  final TwTextInputStyle? hovered;

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
    final TwTextInputStyle style = const TwTextInputStyle(),
    this.disabled,
    this.error,
    this.focused,
    this.hovered,
    this.isCollapsed,
    this.isDense,
    this.inputLabel,
    this.subtext,
    this.placeholder,
    this.errorLabel,
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
  })  : textInputStyle = style,
        super();

  @override
  TextStyle? get style => TwTextStyle.toMaterialTextStyle(
        textInputStyle,
        disabled: disabled,
        dragged: null,
        error: error,
        focused: focused,
        selected: null,
        pressed: null,
        hovered: hovered,
      );

  InputBorder? _getMaterialInputBorder() =>
      TwTextInputStyle.toMaterialInputBorder(
        textInputStyle,
        disabled: disabled,
        dragged: null,
        error: error,
        focused: focused,
        selected: null,
        pressed: null,
        hovered: hovered,
      );

  @override
  InputDecoration get decoration {
    final labelStyle = inputLabel?.toMaterialTextStyle(textInputStyle);
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
      helperStyle: subtext?.toMaterialTextStyle(textInputStyle),
      helperMaxLines: subtext?.maxLines,

      // Placeholder sub-component
      hintText: placeholder?.text,
      hintStyle: placeholder?.toMaterialTextStyle(textInputStyle),
      hintMaxLines: placeholder?.maxLines,
      hintTextDirection: placeholder?.textDirection,
      hintFadeDuration: placeholder?.fadeDuration,

      // Error sub-component
      errorText: errorLabel?.text,
      error: errorLabel?.widget,
      errorStyle: errorLabel?.toMaterialTextStyle(textInputStyle),
      errorMaxLines: errorLabel?.maxLines,

      // TextField container
      constraints: textInputStyle.getBoxConstraints(),
      contentPadding: textInputStyle.padding?.toEdgeInsets(),
      // Don't set errorBorder, focusedBorder, focusedErrorBorder,
      // disabledBorder, nor enabledBorder, since we are using material state
      // resolver for the border
      border: _getMaterialInputBorder(),
    );
  }
}
