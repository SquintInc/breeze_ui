import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwMinWidth {
  final TwUnit value;

  const TwMinWidth(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwMinWidth &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
