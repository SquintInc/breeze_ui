import 'package:breeze_ui/config/builder/build_runner/rgba_color.dart';
import 'package:breeze_ui/config/builder/units_parser.dart';
import 'package:breeze_ui/config/options/units.dart';
import 'package:meta/meta.dart';

/// TailwindCSS config representation in Dart. This class is used by the
/// [TailwindConfigBuilder] to aid in generating Tailwind constants.
///
/// The underlying config theme mapping is mutable because it is updated by the
/// first shared part builder: [TailwindConfigBuilder], and is then used by
/// subsequent constants builders.
@immutable
class TailwindConfig {
  final Map<String, dynamic> theme = {};
  static const Set<String> ignoredColorKeys = {
    'DEFAULT',
    'inherit',
    'current',
  };
  static const Set<String> ignoredMeasurementValues = {
    'auto',
    'min-content',
    'max-content',
    'fit-content',
    'none',
    '65ch',
    'from-font',
  };

  /// Returns an empty [TailwindConfig] instance.
  TailwindConfig.empty();

  void setTheme(final Map<String, dynamic> theme) {
    this.theme
      ..clear()
      ..addAll(theme);
  }

  Map<String, dynamic> getRawValues(final String key) {
    final Map<String, dynamic> values = theme[key] as Map<String, dynamic>;
    return Map.unmodifiable(values);
  }

  Map<String, CssMeasurementUnit> getUnits(final String key) {
    final values = (theme[key] as Map<String, dynamic>)
        .entries
        .where(
          (final entry) => (entry.value is String)
              ? !ignoredMeasurementValues.contains(entry.value)
              : true,
        )
        .map((final entry) {
      try {
        final parsedValue = parseMeasurementUnit(entry.value);
        return MapEntry(entry.key, parsedValue);
      } catch (e) {
        throw Exception(
          'Failed to parse value for key: ${entry.key}, value: ${entry.value}. $e',
        );
      }
    });
    return Map.unmodifiable(Map.fromEntries(values));
  }

  Map<String, CssTimeUnit> getTimeUnits(final String key) {
    final Map<String, CssTimeUnit> values =
        (theme[key] as Map<String, dynamic>).map(
      (final key, final value) => MapEntry(key, parseTimeUnit(value)),
    );
    return Map.unmodifiable(values);
  }

  Map<String, RgbaColor> getColors(final String key) {
    final Map<String, RgbaColor> flatListColors = {};
    final Map<String, dynamic> colors = {...theme[key]};
    for (final entry in colors.entries) {
      if (ignoredColorKeys.contains(entry.key)) {
        continue;
      }
      if (entry.value is String) {
        final color = RgbaColor.fromCssHex(entry.value);
        flatListColors[entry.key] = color;
      } else {
        final Map<String, dynamic> colorShades = {...entry.value};
        for (final colorShadeEntry in colorShades.entries) {
          if (colorShadeEntry.value is String) {
            final color = RgbaColor.fromCssHex(colorShadeEntry.value);
            flatListColors['${entry.key}-${colorShadeEntry.key}'] = color;
          }
        }
      }
    }
    return Map.unmodifiable(flatListColors);
  }
}
