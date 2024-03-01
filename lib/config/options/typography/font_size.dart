import 'package:breeze_ui/config/options/typography/line_height.dart';
import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

@immutable
class TwFontSize {
  /// Default font size in pixels taken from
  /// https://tailwindcss.com/docs/font-size
  static const double defaultFontSizePx = 16.0;

  /// Default font size using [defaultFontSizePx] and
  /// [TwLineHeight.defaultLineHeight].
  static const TwFontSize defaultFontSize = TwFontSize(
    PxUnit(defaultFontSizePx),
    TwLineHeight.defaultLineHeight,
  );

  final CssAbsoluteUnit value;
  final TwLineHeight lineHeight;

  const TwFontSize(this.value, this.lineHeight);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwFontSize &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          lineHeight == other.lineHeight;

  @override
  int get hashCode => value.hashCode ^ lineHeight.hashCode;

  double getLineHeight(final TwLineHeight? customHeight) {
    final double fontSize = value.pixels(defaultFontSizePx);
    final TwLineHeight lineHeight = customHeight ?? this.lineHeight;
    return switch (lineHeight.value) {
      CssAbsoluteUnit() =>
        (lineHeight.value as CssAbsoluteUnit).pixels(fontSize) / fontSize,
      CssRelativeUnit() =>
        (lineHeight.value as CssRelativeUnit).percentageFloat(),
    };
  }

  @override
  String toString() {
    return 'TwFontSize{value: $value, lineHeight: $lineHeight}';
  }
}
