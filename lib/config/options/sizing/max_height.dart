import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

@immutable
class TwMaxHeight {
  final TwUnit value;

  const TwMaxHeight(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMaxHeight &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
