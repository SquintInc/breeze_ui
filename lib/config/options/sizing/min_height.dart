import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwMinHeight {
  final TwUnit value;

  const TwMinHeight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMinHeight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
