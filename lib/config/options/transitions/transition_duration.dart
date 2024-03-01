import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

@immutable
class TwTransitionDuration {
  final CssTimeUnit duration;

  const TwTransitionDuration(this.duration);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwTransitionDuration &&
          runtimeType == other.runtimeType &&
          duration == other.duration;

  @override
  int get hashCode => duration.hashCode;

  @override
  String toString() {
    return 'TwTransitionDuration{duration: $duration}';
  }
}
