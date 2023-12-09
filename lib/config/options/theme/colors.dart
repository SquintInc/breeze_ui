import 'dart:ui';

class TwColor {
  final Color color;

  const TwColor(this.color);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwColor &&
          runtimeType == other.runtimeType &&
          color == other.color;

  @override
  int get hashCode => color.hashCode;
}

extension ColorExt on Color {
  TwColor get tw => TwColor(this);
}
