// This file will be included as part of the generated tailwind_config.g.dart
/* For IDE completion purposes when editing this template file */
import 'dart:core';

import 'package:tailwind_elements/config/options/theme/units.dart';

const Map<String, dynamic> _defaultConfigFull = {};
const Map<String, dynamic> _config = {};

/* Remove everything before this line */

class TailwindConfig {
  final Map<dynamic, dynamic> _theme;

  const TailwindConfig(this._theme);

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

enum Category {
  theme,
  aria,
  backgrounds,
  borders,
  effects,
  extend,
  filters,
  flexboxAndGrid,
  interactivity,
  layout,
  sizing,
  spacing,
  svg,
  tables,
  transforms,
  transitionsAndAnimations,
  typography,
}

const Map<Category, Set<String>> _keysByCategory = {
  Category.theme: {
    'colors',
    'screens',
    'spacing',
  },
  Category.extend: {
    'extend',
  },
  Category.aria: {
    'aria',
    'supports',
    'data',
  },
  Category.backgrounds: {
    'backgroundColor',
    'backgroundImage',
    'backgroundOpacity',
    'backgroundPosition',
    'backgroundSize',
    'gradientColorStops',
    'gradientColorStopPositions',
  },
  Category.borders: {
    'borderColor',
    'borderOpacity',
    'borderRadius',
    'borderSpacing',
    'borderWidth',
    'divideColor',
    'divideOpacity',
    'divideWidth',
    'outlineColor',
    'outlineOffset',
    'outlineWidth',
    'ringColor',
    'ringOffsetColor',
    'ringOffsetWidth',
    'ringOpacity',
    'ringWidth',
  },
  Category.effects: {
    'boxShadow',
    'boxShadowColor',
    'opacity',
  },
  Category.filters: {
    'backdropBlur',
    'backdropBrightness',
    'backdropContrast',
    'backdropGrayscale',
    'backdropHueRotate',
    'backdropInvert',
    'backdropOpacity',
    'backdropSaturate',
    'backdropSepia',
    'blur',
    'brightness',
    'contrast',
    'dropShadow',
    'grayscale',
    'hueRotate',
    'invert',
    'saturate',
    'sepia',
  },
  Category.flexboxAndGrid: {
    'flex',
    'flexBasis',
    'flexGrow',
    'flexShrink',
    'gap',
    'gridAutoColumns',
    'gridAutoRows',
    'gridColumn',
    'gridColumnEnd',
    'gridColumnStart',
    'gridRow',
    'gridRowEnd',
    'gridRowStart',
    'gridTemplateColumns',
    'gridTemplateRows',
    'order',
  },
  Category.interactivity: {
    'accentColor',
    'caretColor',
    'cursor',
    'scrollMargin',
    'scrollPadding',
    'willChange',
  },
  Category.layout: {
    'aspectRatio',
    'columns',
    'container',
    'inset',
    'objectPosition',
    'zIndex',
  },
  Category.sizing: {
    'height',
    'maxHeight',
    'maxWidth',
    'minHeight',
    'minWidth',
    'width',
    'size',
  },
  Category.spacing: {
    'margin',
    'padding',
    'space',
  },
  Category.svg: {
    'fill',
    'stroke',
    'strokeWidth',
  },
  Category.tables: {},
  Category.transforms: {
    'rotate',
    'scale',
    'skew',
    'transformOrigin',
    'translate',
  },
  Category.transitionsAndAnimations: {
    'animation',
    'keyframes',
    'transitionDelay',
    'transitionDuration',
    'transitionProperty',
    'transitionTimingFunction',
  },
  Category.typography: {
    'content',
    'fontFamily',
    'fontSize',
    'fontWeight',
    'letterSpacing',
    'lineHeight',
    'listStyleType',
    'listStyleImage',
    'lineClamp',
    'placeholderColor',
    'placeholderOpacity',
    'textColor',
    'textDecorationColor',
    'textDecorationThickness',
    'textIndent',
    'textOpacity',
    'textUnderlineOffset',
  },
};

final Map<String, Category> _keysToCategory = Map.unmodifiable(
  _keysByCategory.entries.fold({}, (
    final previousValue,
    final element,
  ) {
    previousValue.addEntries(
      element.value.map((final String key) => MapEntry(key, element.key)),
    );
    return previousValue;
  }),
);

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

final TailwindConfig tailwindConfig = TailwindConfig(_combinedTheme());
