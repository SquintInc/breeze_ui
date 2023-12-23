import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwFontSize {
  final TwUnit value;
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
}
