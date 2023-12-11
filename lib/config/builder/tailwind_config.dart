import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/builder/build_runner/rgba_color.dart';
import 'package:tailwind_elements/config/options/theme/units.dart';

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

  /// Returns an empty [TailwindConfig] instance.
  TailwindConfig.empty();

  void setTheme(final Map<String, dynamic> theme) {
    this.theme
      ..clear()
      ..addAll(theme);
  }

  Map<String, String> getRawValues(final String key) {
    final Map<String, String> values = (theme[key] as Map<String, dynamic>).map(
      (final key, final value) => MapEntry(key, value.toString()),
    );
    return Map.unmodifiable(values);
  }

  Map<String, TwUnit> getUsable(final String key) {
    final Map<String, TwUnit> values = (theme[key] as Map<String, dynamic>).map(
      (final key, final value) => MapEntry(key, TwUnit.parse(value)),
    );
    return Map.unmodifiable(
      Map.fromEntries(
        values.entries
            .where((final entry) => entry.value.type != UnitType.ignored),
      ),
    );
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
