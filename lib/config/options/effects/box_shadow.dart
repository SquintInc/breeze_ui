import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/colors.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwBoxShadow {
  final TwBoxShadowColor color;
  final TwUnit offsetX;
  final TwUnit offsetY;
  final TwUnit blurRadius;
  final TwUnit spreadRadius;

  const TwBoxShadow({
    required this.color,
    required this.offsetX,
    required this.offsetY,
    required this.blurRadius,
    required this.spreadRadius,
  });
}
