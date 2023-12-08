import 'package:meta/meta.dart';
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
}
