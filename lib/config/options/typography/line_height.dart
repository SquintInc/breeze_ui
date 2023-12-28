import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwLineHeight {
  /// Default line height percentage taken from
  /// https://tailwindcss.com/docs/line-height
  static const double defaultLineHeightPercentage = 1.5;

  /// Default line height using [defaultLineHeightPercentage].
  static const TwLineHeight defaultLineHeight = TwLineHeight(
    PercentUnit.fromFloat(defaultLineHeightPercentage),
  );

  final CssMeasurementUnit value;

  const TwLineHeight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwLineHeight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwLineHeight{value: $value}';
  }

  double asPercentageFloat(final double fontSizePx) {
    switch (value) {
      case CssRelativeUnit():
        return (value as CssRelativeUnit).percentageFloat();
      case CssAbsoluteUnit():
        return (value as CssAbsoluteUnit).pixels(fontSizePx) / fontSizePx;
    }
  }
}
