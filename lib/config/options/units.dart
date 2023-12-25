import 'package:meta/meta.dart';

/// Represents a CSS time unit type.
enum TimeUnitType {
  ms,
  s,
}

/// Represents a CSS measurement unit type.
enum UnitType {
  px,
  em,
  rem,
  percent,
  viewport,
  smallViewport,
  largeViewport,
  dynamicViewport,
  ignored,
}

double _getLogicalPixels(final UnitType type, final double value) =>
    switch (type) {
      UnitType.px => value,
      UnitType.rem || UnitType.em => value * 16,
      _ => 0,
    };

/// Represents a CSS time unit using a sealed class.
@immutable
sealed class TwTimeUnit {
  TimeUnitType get type;

  Duration get value;

  static TwTimeUnit parse(final String value) {
    if (value == '0') {
      return const MillisecondsTimeUnit(Duration(microseconds: 0));
    }
    if (value.endsWith('ms')) {
      final ms = double.parse(value.substring(0, value.length - 2));
      return MillisecondsTimeUnit(
        Duration(
          microseconds: (ms * Duration.microsecondsPerMillisecond).toInt(),
        ),
      );
    } else if (value.endsWith('s')) {
      final s = double.parse(value.substring(0, value.length - 1));
      return SecondsTimeUnit(
        Duration(milliseconds: (s * Duration.millisecondsPerSecond).toInt()),
      );
    }
    throw UnsupportedError('Unsupported CSS time unit type: $value');
  }
}

/// Represents a CSS measurement unit using a sealed class.
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
    } else if (value.endsWith('em')) {
      return EmUnit(double.parse(value.substring(0, value.length - 2)));
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

    final double? tryPercentage = double.tryParse(value);
    if (tryPercentage != null) {
      return PercentUnit(tryPercentage * 100);
    }

    return IgnoreUnit(value);
  }
}

extension TwUnitExtension on TwUnit {
  /// Returns the value of this unit in logical pixels, for [PxUnit], [RemUnit],
  /// and [EmUnit] units only. Will return 0 for all other unit types.
  double get logicalPixels => _getLogicalPixels(type, value);

  /// Returns the value of this unit in logical pixels for [EmUnit], and
  /// defaults to the [logicalPixels] value if the unit is not an [EmUnit]
  double emPixels(final double fontSize) =>
      type == UnitType.em ? value * fontSize : logicalPixels;

  /// Returns the value of this unit as a percentage between 0.0 and 1.0
  /// inclusive, for [PercentUnit], [ViewportUnit], [SmallViewportUnit],
  /// [DynamicViewportUnit], and [LargeViewportUnit] units. Will return 0.0 (0%)
  /// for all other unit types.
  double get percentage => isPercentageBased ? value / 100 : 0;

  bool get isPercentageBased =>
      type == UnitType.percent ||
      type == UnitType.viewport ||
      type == UnitType.smallViewport ||
      type == UnitType.largeViewport ||
      type == UnitType.dynamicViewport;

  String toDartConstructor() => '$runtimeType($value)';
}

extension TwTimeUnitExtension on TwTimeUnit {
  String toDartConstructor() {
    return switch (type) {
      TimeUnitType.ms =>
        '$runtimeType(Duration(microseconds: ${value.inMicroseconds}))',
      TimeUnitType.s =>
        '$runtimeType(Duration(milliseconds: ${value.inMilliseconds}))',
    };
  }
}

@immutable
class MillisecondsTimeUnit implements TwTimeUnit {
  @override
  final Duration value;

  const MillisecondsTimeUnit(this.value);

  @override
  TimeUnitType get type => TimeUnitType.ms;

  @override
  String toString() => '$value${type.name}';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is MillisecondsTimeUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

@immutable
class SecondsTimeUnit implements TwTimeUnit {
  @override
  final Duration value;

  const SecondsTimeUnit(this.value);

  @override
  TimeUnitType get type => TimeUnitType.s;

  @override
  String toString() => '$value${type.name}';

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is SecondsTimeUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
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
  String toString() => '$value${type.name}';

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

  @override
  String toString() => '$value${type.name}';

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

  @override
  String toString() => '$value${type.name}';

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
  String toString() => '$value${type.name}';

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
  String toString() => '$value${type.name}';

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
  String toString() => '$value${type.name}';

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
  String toString() => '$value${type.name}';

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
  String toString() => '$value${type.name}';

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
