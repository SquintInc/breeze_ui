import 'package:breeze_ui/config/options/units.dart';

CssTimeUnit parseTimeUnit(final String value) {
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
  throw UnsupportedError('Unsupported CSS time unit "$value"');
}

/// Parses a CSS unit value from a string representation into one of the many
/// possible sealed [CssMeasurementUnit] representations.
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
CssMeasurementUnit parseMeasurementUnit(final String value) {
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

  throw UnsupportedError('Unsupported CSS measurement unit "$value"');
}

extension MeasurementUnitConstructorExtension on CssMeasurementUnit {
  String toDartConstructor() => '$runtimeType($value)';
}

extension TimeUnitDartConstructorExtension on CssTimeUnit {
  String toDartConstructor() {
    return switch (type) {
      TimeType.ms =>
        '$runtimeType(Duration(microseconds: ${value.inMicroseconds}))',
      TimeType.s =>
        '$runtimeType(Duration(milliseconds: ${value.inMilliseconds}))',
    };
  }
}
