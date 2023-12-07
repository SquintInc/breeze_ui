import 'package:meta/meta.dart';

enum UnitType {
  px,
  em,
  rem,
  percent,
  viewport,
  smallViewport,
  largeViewport,
  dynamicViewport,
  ignored
}

@immutable
sealed class TwUnit {
  UnitType get type;

  double get value;
}

@immutable
class PxUnit implements TwUnit {
  @override
  final double value;

  const PxUnit(this.value);

  @override
  UnitType get type => UnitType.px;

  @override
  String toString() => '$value (${type.name})';
}

@immutable
class EmUnit implements TwUnit {
  @override
  final double value;

  const EmUnit(this.value);

  @override
  UnitType get type => UnitType.em;

  double toPx(final double rootFontSize) => value * rootFontSize;

  @override
  String toString() => '$value (${type.name})';
}

@immutable
class RemUnit implements TwUnit {
  @override
  final double value;

  const RemUnit(this.value);

  @override
  UnitType get type => UnitType.rem;

  double toPx(final double rootFontSize) => value * rootFontSize;

  @override
  String toString() => '$value (${type.name})';
}

@immutable
class PercentUnit implements TwUnit {
  @override
  final double value;

  const PercentUnit(this.value);

  @override
  UnitType get type => UnitType.percent;

  @override
  String toString() => '$value (${type.name})';
}

@immutable
class IgnoreUnit implements TwUnit {
  final String rawType;

  const IgnoreUnit(this.rawType);

  @override
  double get value => throw Exception('Unsupported CSS unit type');

  @override
  UnitType get type => UnitType.ignored;

  @override
  String toString() => '$rawType (${type.name})';
}

@immutable
class ViewportUnit implements TwUnit {
  @override
  final double value;

  const ViewportUnit(this.value);

  @override
  UnitType get type => UnitType.viewport;

  @override
  String toString() => '$value (${type.name})';
}

@immutable
class SmallViewportUnit implements TwUnit {
  @override
  final double value;

  const SmallViewportUnit(this.value);

  @override
  UnitType get type => UnitType.smallViewport;

  @override
  String toString() => '$value (${type.name})';
}

@immutable
class LargeViewportUnit implements TwUnit {
  @override
  final double value;

  const LargeViewportUnit(this.value);

  @override
  UnitType get type => UnitType.largeViewport;

  @override
  String toString() => '$value (${type.name})';
}

@immutable
class DynamicViewportUnit implements TwUnit {
  @override
  final double value;

  const DynamicViewportUnit(this.value);

  @override
  UnitType get type => UnitType.dynamicViewport;

  @override
  String toString() => '$value (${type.name})';
}

TwUnit parseUnit(final String value) {
  if (value.endsWith('px')) {
    return PxUnit(double.parse(value.substring(0, value.length - 2)));
  } else if (value.endsWith('rem')) {
    return RemUnit(double.parse(value.substring(0, value.length - 3)));
  } else if (value.endsWith('%')) {
    return PercentUnit(double.parse(value.substring(0, value.length - 1)));
  } else if (value.endsWith('svh') || value.endsWith('svw')) {
    return SmallViewportUnit(
      double.parse(value.substring(0, value.length - 3)),
    );
  } else if (value.endsWith('dvh') || value.endsWith('dvw')) {
    return DynamicViewportUnit(
      double.parse(value.substring(0, value.length - 3)),
    );
  } else if (value.endsWith('lvh') || value.endsWith('lvw')) {
    return LargeViewportUnit(
      double.parse(value.substring(0, value.length - 3)),
    );
  } else if (value.endsWith('vh') || value.endsWith('vw')) {
    return ViewportUnit(double.parse(value.substring(0, value.length - 2)));
  }
  return IgnoreUnit(value);
}
