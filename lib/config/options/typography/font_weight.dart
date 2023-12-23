import 'package:meta/meta.dart';

@immutable
class TwFontWeight {
  final int weight;

  const TwFontWeight(this.weight);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwFontWeight &&
          runtimeType == other.runtimeType &&
          weight == other.weight;

  @override
  int get hashCode => weight.hashCode;
}
