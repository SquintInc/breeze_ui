import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/options/units.dart';

@immutable
class TwTextDecorationThickness {
  final CssAbsoluteUnit value;

  const TwTextDecorationThickness(this.value);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwTextDecorationThickness &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'TwTextDecorationThickness{value: $value}';
  }
}
