/* This file is used as part of the build_runner process for generating a
 * tailwind_config.g.dart. Everything in-between below this comment and before
 * the next comment is for IDE completion purposes only, and will be stripped
 * during the build_runner process.
 */
import 'dart:core';

import 'package:tailwind_elements/config/options/theme/units.dart';

const Map<String, dynamic> _defaultConfigFull = {};
const Map<String, dynamic> _config = {};

/* WARNING: build_runner will remove everything before this line */

/// Generated TailwindCSS config class.
///
/// Contains methods to help read TailwindCSS options.
class TailwindConfig {
  final Map<dynamic, dynamic> _theme;

  const TailwindConfig._(this._theme);

  /// Getter function to retrieve a value from tailwind.config.js given a JSON key.
  ///
  /// e.g. themeKey = 'spacing' => return theme['spacing']
  ///
  /// e.g. themeKey = 'colors.blue.500' => theme['colors']['blue']['500']
  dynamic _themeValueGetter(
    final String themeKey, [
    final String? defaultValue,
  ]) {
    final List<String> keys = themeKey.split('.');
    dynamic curr = _theme;
    for (final key in keys) {
      curr = curr[key];
    }
    if (curr == null && defaultValue != null) {
      return defaultValue;
    } else if (curr != null) {
      return curr;
    }
    throw Exception(
      'Failed to call _themeValueGetter with themeKey $themeKey and defaultValue $defaultValue',
    );
  }

  /// Getter function to retrieve the current breakpoints from tailwind.config.js.
  /// Takes in the breakpoints map and returns the same map with all keys prefixed
  /// with 'screen-'.
  Map<String, dynamic> _breakpointGetter(
    final Map<String, dynamic> breakpoints,
  ) =>
      breakpoints
          .map((final key, final value) => MapEntry('screen-$key', value));

  /// Gets a mapping from the overall 'theme' object using the provided string
  /// key. Tries to return a mapping of key-value pairs, where the value is a
  /// CSS unit ([TwUnit]) parsed via [parseUnit].
  ///
  /// Returns null if the key is not found in the 'theme' object.
  ///
  /// Note that this method will return all key-value pairs, including CSS units
  /// that are not usable by tailwind_elements. To get only usable CSS units,
  /// use [getUsable].
  Map<String, TwUnit>? get(final String key) {
    final dynamic entriesOrFunc = _theme[key];
    if (entriesOrFunc == null) return null;
    final Map<String, dynamic> entries = entriesOrFunc is Function
        ? entriesOrFunc(
            theme: _themeValueGetter,
            breakpoints: _breakpointGetter,
          )
        : entriesOrFunc;

    return entries
        .map((final key, final value) => MapEntry(key, parseUnit(value)));
  }

  /// Gets a filtered mapping from the overall 'theme' object using the provided
  /// string key. Tries to return a mapping of key-value pairs, where the value
  /// is a CSS unit ([TwUnit]) parsed via [parseUnit]. This method filters out
  /// any CSS units that are not usable by tailwind_elements.
  ///
  /// Returns null if the key is not found in the 'theme' object.
  Map<String, TwUnit>? getUsable(final String key) {
    final entries = get(key);
    if (entries == null) return null;
    return Map.unmodifiable(
      Map.fromEntries(
        entries.entries
            .where((final entry) => entry.value.type != UnitType.ignored),
      ),
    );
  }
}

/// Combines the 'theme' objects from the full TailwindCSS config and the local
/// TailwindCSS config. Handles local config overrides, as well as the 'extend'
/// option in the local config.
Map<dynamic, dynamic> _combinedTheme() {
  final Map<dynamic, dynamic> configThemeCopy =
      _config.isNotEmpty ? {..._config['theme']} : {};
  final Map<dynamic, dynamic>? extend = configThemeCopy.remove('extend');
  final Map<dynamic, dynamic> combinedTheme = {
    ..._defaultConfigFull['theme'],
    ...configThemeCopy,
  };
  if (extend != null) {
    for (final entry in extend.entries) {
      final String key = entry.key;
      final Map<String, dynamic> toAdd = entry.value;
      (combinedTheme[key] as Map<String, dynamic>).addAll(toAdd);
    }
  }
  return Map.unmodifiable(combinedTheme);
}

/// Top-level generated [TailwindConfig] instance.
final TailwindConfig tailwindConfig = TailwindConfig._(_combinedTheme());
