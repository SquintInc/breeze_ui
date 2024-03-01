import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

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
