import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwLetterSpacing {
  /// Default letter spacing in em taken from
  /// https://tailwindcss.com/docs/letter-spacing
  static const defaultLetterSpacingEm = 0.0;

  /// Default letter spacing using [defaultLetterSpacingEm].
  static const defaultLetterSpacing = TwLetterSpacing(
    EmUnit(defaultLetterSpacingEm),
  );

  final CssAbsoluteUnit value;

  const TwLetterSpacing(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwLetterSpacing &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwLetterSpacing{value: $value}';
  }
}
