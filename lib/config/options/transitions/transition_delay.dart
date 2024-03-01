import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

@immutable
class TwTransitionDelay {
  final CssTimeUnit delay;

  const TwTransitionDelay(this.delay);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwTransitionDelay &&
          runtimeType == other.runtimeType &&
          delay == other.delay;

  @override
  int get hashCode => delay.hashCode;

  @override
  String toString() {
    return 'TwTransitionDelay{delay: $delay}';
  }
}
