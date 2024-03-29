import 'package:breeze_ui/config/builder/build_runner/rgba_color.dart';
import 'package:breeze_ui/config/builder/tailwind_config.dart';
import 'package:breeze_ui/config/builder/units_parser.dart';
import 'package:breeze_ui/config/options/units.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';

extension StringExt on String {
  String toSnakeCase() {
    return replaceAllMapped(
      RegExp('([-/.])'),
      (final match) => '_',
    ).toLowerCase();
  }
}

class CodeWriter {
  static String variableName(
    final String variablePrefix,
    final String variableSuffix,
  ) =>
      variablePrefix.isEmpty
          ? variableSuffix.toSnakeCase()
          : '$variablePrefix${variableSuffix.isEmpty ? '' : "_$variableSuffix"}'
              .toSnakeCase();

  static String percentageVarNameSuffix(final String key, final double value) {
    // If the key contains a slash, then it's a fraction. For ease of use, we
    // prepend 'frac_' as part of the variable name suffix for fractions.
    // e.g. '1/2' -> 'frac_1_2'
    if (key.contains('/')) {
      return 'frac_${key.toSnakeCase()}';
    }
    // Otherwise treat the variable suffix as a normal variable name.
    return key.toSnakeCase();
  }

  static String variableNameSuffix(final String key, final dynamic unit) {
    if (unit is CssMeasurementUnit) {
      return switch (unit.type) {
        MeasurementType.px ||
        MeasurementType.em ||
        MeasurementType.rem =>
          key == 'DEFAULT' ? '' : key.toSnakeCase(),
        MeasurementType.percent => percentageVarNameSuffix(key, unit.value),
        MeasurementType.viewport => key.toSnakeCase(),
        MeasurementType.smallViewport => key.toSnakeCase(),
        MeasurementType.largeViewport => key.toSnakeCase(),
        MeasurementType.dynamicViewport => key.toSnakeCase(),
      };
    } else if (unit is CssTimeUnit) {
      return switch (unit.type) {
        TimeType.ms || TimeType.s => key == 'DEFAULT' ? '' : key.toSnakeCase(),
      };
    } else if (unit is double || unit is int || unit is String) {
      return key == 'DEFAULT' ? '' : key.toSnakeCase();
    }
    throw Exception(
      'Invalid unit type for conversion to identifier: ${unit.runtimeType}',
    );
  }

  static String dartLineUnitDeclaration({
    required final String variableName,
    required final String valueClassName,
    required final dynamic unit,
  }) {
    var valueConstructor = '';
    if (unit is CssMeasurementUnit) {
      valueConstructor = switch (unit.type) {
        MeasurementType.px ||
        MeasurementType.em ||
        MeasurementType.rem ||
        MeasurementType.percent ||
        MeasurementType.viewport ||
        MeasurementType.smallViewport ||
        MeasurementType.largeViewport ||
        MeasurementType.dynamicViewport =>
          valueClassName.isEmpty
              ? unit.toDartConstructor()
              : '$valueClassName(${unit.toDartConstructor()})',
      };
    } else if (unit is CssTimeUnit) {
      valueConstructor = switch (unit.type) {
        TimeType.ms => '$valueClassName(${unit.toDartConstructor()})',
        TimeType.s => valueClassName.isEmpty
            ? unit.toDartConstructor()
            : '$valueClassName(${unit.toDartConstructor()})',
      };
    } else if (unit is double || unit is int || unit is String) {
      valueConstructor = '$valueClassName($unit)';
    } else {
      throw Exception(
        'Invalid unit type for converting unit to a Dart declaration: ${unit.runtimeType}',
      );
    }

    return dartLineDeclaration(
      variableName: variableName,
      valueConstructor: valueConstructor,
    );
  }

  static String dartLineDeclaration({
    required final String variableName,
    required final String valueConstructor,
  }) {
    return 'const $variableName = $valueConstructor;';
  }
}

enum GeneratorType {
  distanceUnits,
  timeUnits,
  rawValues,
}

/// A [Generator] used to generate Tailwind constants to the .g.dart part file.
@immutable
abstract class ConstantsGenerator extends Generator {
  final BuilderOptions options;
  final TailwindConfig config;
  final GeneratorType generatorType;

  Map<String, dynamic> getThemeValues() => switch (generatorType) {
        GeneratorType.distanceUnits => config.getUnits(themeConfigKey),
        GeneratorType.timeUnits => config.getTimeUnits(themeConfigKey),
        GeneratorType.rawValues => config.getRawValues(themeConfigKey),
      };

  /// The Tailwind config key to use for fetching the key : unit mappings.
  String get themeConfigKey;

  /// The prefix to use for the generated variable names, as a mapping to their
  /// wrapper value classes' names.
  ///
  /// e.g.
  /// {
  ///   'p': (TwPaddingAll).toString(),
  ///   'pt': (TwPaddingTop).toString(),
  ///   ... etc.
  /// }
  Map<String, String> get variablePrefixToValueClassName;

  const ConstantsGenerator(
    this.options,
    this.config, {
    this.generatorType = GeneratorType.distanceUnits,
  });

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final Map<String, dynamic> themeValues = getThemeValues();
    final allDeclarations = variablePrefixToValueClassName.entries.map((
      final prefix,
    ) {
      final prefixDeclarations = themeValues.entries.map((final themeValue) {
        final String varName = CodeWriter.variableName(
          prefix.key,
          CodeWriter.variableNameSuffix(themeValue.key, themeValue.value),
        );
        final String lineDeclaration = CodeWriter.dartLineUnitDeclaration(
          variableName: varName,
          valueClassName: prefix.value,
          unit: themeValue.value,
        );
        return lineDeclaration;
      });
      return prefixDeclarations.join('\n');
    });
    return allDeclarations.join('\n');
  }
}

/// A [Generator] used to generate color-related Tailwind constants to the
/// .g.dart part file.
@immutable
abstract class ColorConstantsGenerator extends Generator {
  final BuilderOptions options;
  final TailwindConfig config;

  /// The Tailwind config key to use for fetching the key : unit mappings.
  String get themeConfigKey;

  /// The prefix to use for the generated variable names
  String get variablePrefix;

  /// The name of the Color wrapper value class (the wrapper class must take in
  /// a [Color] in its constructor).
  ///
  /// Usually a hard-coded string, since build_runner can't resolve 'dart:ui'
  /// types when running the build.
  String get colorValueClassName;

  const ColorConstantsGenerator(this.options, this.config);

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final Map<String, RgbaColor> colors = config.getColors(themeConfigKey);
    final allDeclarations = colors.entries.map((final colorEntry) {
      final String varName =
          CodeWriter.variableName(variablePrefix, colorEntry.key);
      final String lineDeclaration =
          'const $varName = $colorValueClassName(Color(${colorEntry.value.toDartHexString()}));';
      return lineDeclaration;
    });
    return allDeclarations.join('\n');
  }
}
