import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/typography/line_height.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwFontSize {
  final TwUnit fontSize;
  final TwLineHeight lineHeight;

  const TwFontSize(this.fontSize, this.lineHeight);
}
