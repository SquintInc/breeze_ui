/* This file is used as part of the build_runner process for generating a
 * tailwind_config.g.dart. Everything in-between below this comment and before
 * the next comment is for IDE completion purposes only, and will be stripped
 * during the build_runner process.
 */
import 'dart:convert';
import 'dart:core';

const Map<String, dynamic> _fullConfig = {};
const Map<String, dynamic> _localConfig = {};
const Map<String, dynamic> _colorsConfig = {};

/* WARNING: build_runner will remove everything before this line */

/// Generated Tailwind config class. Keeps track of the merged theme and colors.
class GeneratedTailwindConfig {
  final Map<String, dynamic> _theme;
  final Map<String, dynamic> _colors;

  const GeneratedTailwindConfig._(this._theme, this._colors);

  factory GeneratedTailwindConfig(
    final Map<String, dynamic> fullConfig,
    final Map<String, dynamic> localConfig,
    final Map<String, dynamic> colorsConfig,
  ) {
    final Map<dynamic, dynamic> configThemeCopy =
        localConfig.isNotEmpty ? {...localConfig['theme']} : {};
    final Map<dynamic, dynamic>? extend = configThemeCopy.remove('extend');
    final Map<dynamic, dynamic>? extendColors = extend?.remove('colors');
    final Map<dynamic, dynamic> combinedTheme = {
      ...fullConfig['theme'],
      ...configThemeCopy,
    };
    final Map<dynamic, dynamic> combinedColors = {
      ...colorsConfig,
    };

    if (extend != null) {
      for (final entry in extend.entries) {
        final String key = entry.key;
        final Map<dynamic, dynamic> toAdd = entry.value;
        if (combinedTheme[key] == null) {
          combinedTheme[key] = {};
        }
        (combinedTheme[key] as Map<dynamic, dynamic>).addAll(toAdd);
      }
    }
    if (extendColors != null) {
      for (final entry in extendColors.entries) {
        final String key = entry.key;
        final Map<dynamic, dynamic> toAdd = entry.value;
        if (combinedColors[key] == null) {
          combinedColors[key] = {};
        }
        (combinedColors[key] as Map<dynamic, dynamic>).addAll(toAdd);
      }
    }
    return GeneratedTailwindConfig._(
      Map.unmodifiable(combinedTheme),
      Map.unmodifiable(combinedColors),
    );
  }

  dynamic _colorsGetter(final String colorKey) {
    return _colors[colorKey];
  }

  /// Getter function to retrieve a value from tailwind.config.js given a JSON key.
  ///
  /// e.g. themeKey = 'spacing' => return theme['spacing']
  ///
  /// e.g. themeKey = 'colors.blue.500' => theme['colors']['blue']['500']
  dynamic _themeValueGetter(
    final String themeKey, [
    final String? defaultValue,
  ]) {
    if (themeKey == 'colors') {
      return _colors;
    }
    final List<String> keys = themeKey.split('.');
    dynamic curr = keys[0] == 'colors' ? _colors : _theme;
    for (final key in keys) {
      curr = curr[key];
      if (curr == null) break;
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
  /// CSS unit ([TwUnit]).
  ///
  /// Returns null if the key is not found in the 'theme' object.
  ///
  /// Note that this method will return all key-value pairs, including CSS units
  /// that are not usable by tailwind_elements. To get only usable CSS units,
  /// use [getUsable].
  Map<dynamic, dynamic>? get(final String key) {
    dynamic entriesOrFunc = _theme[key];
    if (entriesOrFunc == null) return null;
    while (entriesOrFunc is Function) {
      entriesOrFunc = entriesOrFunc(
        theme: _themeValueGetter,
        breakpoints: _breakpointGetter,
        colors: _colorsGetter,
      );
    }
    return entriesOrFunc;
  }

  String toJson() {
    return jsonEncode(
      _theme.map(
        (final String key, final dynamic value) => MapEntry(key, get(key)),
      ),
    );
  }
}

/// Top-level generated [TailwindConfig] instance.
final GeneratedTailwindConfig tailwindConfig =
    GeneratedTailwindConfig(_fullConfig, _localConfig, _colorsConfig);
