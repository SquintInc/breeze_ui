import 'package:meta/meta.dart';

/// Represents a CSS unit type.
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

/// Represents a CSS unit using a sealed class.
@immutable
sealed class TwUnit {
  UnitType get type;

  double get value;

  /// Parses a CSS unit value from a string representation into one of the many
  /// possible sealed [TwUnit] representations.
  ///
  /// See also:
  ///   - [PxUnit]
  ///   - [PercentUnit]
  ///   - [EmUnit]
  ///   - [RemUnit]
  ///   - [ViewportUnit]
  ///   - [SmallViewportUnit]
  ///   - [DynamicViewportUnit]
  ///   - [LargeViewportUnit]
  ///   - [IgnoreUnit]
  static TwUnit parse(final String value) {
    if (value == '0') return const PxUnit(0);

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
}

/// Represents a pixel unit (e.g. 50px).
@immutable
class PxUnit implements TwUnit {
  @override
  final double value;

  const PxUnit(this.value);

  @override
  UnitType get type => UnitType.px;

  @override
  String toString() => '$value (${type.name})';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is PxUnit &&
          runtimeType == other.runtimeType &&
          value == other.value ||
      other is TwUnit && other.value == 0 && value == 0;

  @override
  int get hashCode => value.hashCode;
}

/// Represents an em unit (e.g. 1.5em).
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

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is EmUnit &&
          runtimeType == other.runtimeType &&
          value == other.value ||
      other is TwUnit && other.value == 0 && value == 0;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a rem unit (e.g. 1.5rem).
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

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is RemUnit &&
          runtimeType == other.runtimeType &&
          value == other.value ||
      other is TwUnit && other.value == 0 && value == 0;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a percentage unit (e.g. 50%).
@immutable
class PercentUnit implements TwUnit {
  @override
  final double value;

  const PercentUnit(this.value);

  @override
  UnitType get type => UnitType.percent;

  @override
  String toString() => '$value (${type.name})';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is PercentUnit &&
          runtimeType == other.runtimeType &&
          value == other.value ||
      other is TwUnit && other.value == 0 && value == 0;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a viewport unit (e.g. vh, vw).
@immutable
class ViewportUnit implements TwUnit {
  @override
  final double value;

  const ViewportUnit(this.value);

  @override
  UnitType get type => UnitType.viewport;

  @override
  String toString() => '$value (${type.name})';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is ViewportUnit &&
          runtimeType == other.runtimeType &&
          value == other.value ||
      other is TwUnit && other.value == 0 && value == 0;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a small viewport unit (e.g. svh, svw).
@immutable
class SmallViewportUnit implements TwUnit {
  @override
  final double value;

  const SmallViewportUnit(this.value);

  @override
  UnitType get type => UnitType.smallViewport;

  @override
  String toString() => '$value (${type.name})';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is SmallViewportUnit &&
          runtimeType == other.runtimeType &&
          value == other.value ||
      other is TwUnit && other.value == 0 && value == 0;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a large viewport unit (e.g. lvh, lvw).
@immutable
class LargeViewportUnit implements TwUnit {
  @override
  final double value;

  const LargeViewportUnit(this.value);

  @override
  UnitType get type => UnitType.largeViewport;

  @override
  String toString() => '$value (${type.name})';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is LargeViewportUnit &&
          runtimeType == other.runtimeType &&
          value == other.value ||
      other is TwUnit && other.value == 0 && value == 0;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a dynamic viewport unit (e.g. dvh, dvw).
@immutable
class DynamicViewportUnit implements TwUnit {
  @override
  final double value;

  const DynamicViewportUnit(this.value);

  @override
  UnitType get type => UnitType.dynamicViewport;

  @override
  String toString() => '$value (${type.name})';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is DynamicViewportUnit &&
          runtimeType == other.runtimeType &&
          value == other.value ||
      other is TwUnit && other.value == 0 && value == 0;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a CSS unit that is not supported by tailwind_elements.
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

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is IgnoreUnit &&
          runtimeType == other.runtimeType &&
          rawType == other.rawType;

  @override
  int get hashCode => rawType.hashCode;
}
