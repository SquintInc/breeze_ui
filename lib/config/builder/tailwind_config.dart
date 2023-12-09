import 'package:meta/meta.dart';
import 'package:tailwind_elements/config/builder/unit_parser.dart';
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

  Map<String, TwUnit> getUsable(final String key) {
    final Map<String, TwUnit> values =
        (theme['width'] as Map<String, dynamic>).map(
      (final key, final value) => MapEntry(key, parseUnit(value)),
    );
    return Map.unmodifiable(
      Map.fromEntries(
        values.entries
            .where((final entry) => entry.value.type != UnitType.ignored),
      ),
    );
  }

  Map<String, String> getColors(final String key) {
    final Map<String, String> flatListColors = {};
    final Map<String, dynamic> colors = {...theme['colors']};
    for (final entry in colors.entries) {
      if (ignoredColorKeys.contains(entry.key)) {
        continue;
      }
      if (entry.value is String) {
        final color = parseColor(entry.value);
        flatListColors[entry.key] = color;
      } else {
        final Map<String, dynamic> colorShades = {...entry.value};
        for (final colorShadeEntry in colorShades.entries) {
          if (colorShadeEntry.value is String) {
            final color = parseColor(colorShadeEntry.value);
            flatListColors['${entry.key}-${colorShadeEntry.key}'] = color;
          }
        }
      }
    }
    return Map.unmodifiable(flatListColors);
  }
}
