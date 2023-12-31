import 'package:meta/meta.dart';

const double _defaultTailwindFontSize = 16.0;

/// Represents a CSS measurement unit type.
enum MeasurementType {
  px,
  em,
  rem,
  percent,
  viewport,
  smallViewport,
  largeViewport,
  dynamicViewport,
}

/// Represents a CSS measurement unit using a sealed class.
@immutable
sealed class CssMeasurementUnit {
  MeasurementType get type;

  double get value;
}

extension IsZeroExtension on CssMeasurementUnit {
  bool get isZero => value == 0;
}

/// Represents a CSS measurement unit that provides absolute values in logical
/// pixels.
@immutable
sealed class CssAbsoluteUnit implements CssMeasurementUnit {
  double pixels([final double? fontSizePx]);
}

/// Represents a CSS measurement unit that provides relative values (e.g.
/// percentage).
@immutable
sealed class CssRelativeUnit implements CssMeasurementUnit {
  double percentageFloat();
}

/// Represents a pixel unit (e.g. 50px).
@immutable
class PxUnit implements CssAbsoluteUnit {
  @override
  final double value;

  const PxUnit(this.value);

  @override
  MeasurementType get type => MeasurementType.px;

  @override
  double pixels([final double? fontSizePx]) => value;

  @override
  String toString() {
    return '$value${type.name}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      isZero && other is CssMeasurementUnit && other.isZero ||
      other is PxUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents an em unit (e.g. 1.5em).
@immutable
class EmUnit implements CssAbsoluteUnit {
  @override
  final double value;

  const EmUnit(this.value);

  @override
  MeasurementType get type => MeasurementType.em;

  @override
  double pixels([final double? fontSizePx]) {
    if (fontSizePx == null) {
      return _defaultTailwindFontSize * value;
    }
    return fontSizePx * value;
  }

  @override
  String toString() {
    return '$value${type.name}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      isZero && other is CssMeasurementUnit && other.isZero ||
      other is EmUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a rem unit (e.g. 1.5rem).
@immutable
class RemUnit implements CssAbsoluteUnit {
  @override
  final double value;

  const RemUnit(this.value);

  @override
  MeasurementType get type => MeasurementType.rem;

  @override
  double pixels([final double? fontSizePx]) => _defaultTailwindFontSize * value;

  @override
  String toString() {
    return '$value${type.name}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      isZero && other is CssMeasurementUnit && other.isZero ||
      other is RemUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a percentage unit normalized to a double value with a % value
/// basis (e.g. 50.0 percent for a float value of 0.5).
@immutable
class PercentUnit implements CssRelativeUnit {
  @override
  final double value;

  const PercentUnit(this.value);

  const PercentUnit.fromFloat(final double value) : value = value * 100;

  @override
  MeasurementType get type => MeasurementType.percent;

  @override
  double percentageFloat() => value / 100;

  @override
  String toString() {
    return '$value${type.name}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      isZero && other is CssMeasurementUnit && other.isZero ||
      other is PercentUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a viewport unit (e.g. vh, vw).
@immutable
class ViewportUnit implements CssRelativeUnit {
  @override
  final double value;

  const ViewportUnit(this.value);

  @override
  MeasurementType get type => MeasurementType.viewport;

  @override
  double percentageFloat() => value / 100;

  @override
  String toString() {
    return '$value${type.name}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      isZero && other is CssMeasurementUnit && other.isZero ||
      other is ViewportUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a small viewport unit (e.g. svh, svw).
@immutable
class SmallViewportUnit implements CssRelativeUnit {
  @override
  final double value;

  const SmallViewportUnit(this.value);

  @override
  MeasurementType get type => MeasurementType.smallViewport;

  @override
  double percentageFloat() => value / 100;

  @override
  String toString() {
    return '$value${type.name}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      isZero && other is CssMeasurementUnit && other.isZero ||
      other is SmallViewportUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a large viewport unit (e.g. lvh, lvw).
@immutable
class LargeViewportUnit implements CssRelativeUnit {
  @override
  final double value;

  const LargeViewportUnit(this.value);

  @override
  MeasurementType get type => MeasurementType.largeViewport;

  @override
  double percentageFloat() => value / 100;

  @override
  String toString() {
    return '$value${type.name}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      isZero && other is CssMeasurementUnit && other.isZero ||
      other is LargeViewportUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Represents a dynamic viewport unit (e.g. dvh, dvw).
@immutable
class DynamicViewportUnit implements CssRelativeUnit {
  @override
  final double value;

  const DynamicViewportUnit(this.value);

  @override
  MeasurementType get type => MeasurementType.dynamicViewport;

  @override
  double percentageFloat() => value / 100;

  @override
  String toString() {
    return '$value${type.name}';
  }

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      isZero && other is CssMeasurementUnit && other.isZero ||
      other is DynamicViewportUnit &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
