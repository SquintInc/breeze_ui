import 'package:tailwind_elements/config/options/theme/units.dart';

extension StringExt on String {
  String toSnakeCase() {
    return replaceAllMapped(
      RegExp('([-/.])'),
      (final match) => '_',
    ).toLowerCase();
  }
}

extension TwUnitExt on TwUnit {
  String toDartConstructor(final String wrappedClassName) =>
      wrappedClassName.isNotEmpty
          ? '$wrappedClassName($runtimeType($value))'
          : '$runtimeType($value)';
}

String getDartIdentifierSuffix(final String key, final TwUnit unit) {
  final identifier = switch (unit.type) {
    UnitType.px ||
    UnitType.em ||
    UnitType.rem =>
      key == 'DEFAULT' ? '' : key.toSnakeCase(),
    UnitType.percent => 'frac_${key.toSnakeCase()}',
    UnitType.viewport => key.toSnakeCase(),
    UnitType.smallViewport => key.toSnakeCase(),
    UnitType.largeViewport => key.toSnakeCase(),
    UnitType.dynamicViewport => key.toSnakeCase(),
    _ => throw Exception(
        'Invalid unit type for conversion to identifier: ${unit.type}',
      ),
  };
  return identifier;
}

String getDartDeclaration(
  final String identifier,
  final String wrappedClassName,
  final TwUnit unit,
) {
  final value = switch (unit.type) {
    UnitType.px ||
    UnitType.em ||
    UnitType.rem ||
    UnitType.percent ||
    UnitType.viewport ||
    UnitType.smallViewport ||
    UnitType.largeViewport ||
    UnitType.dynamicViewport =>
      unit.toDartConstructor(wrappedClassName),
    _ => throw Exception(
        'Invalid unit type for converting unit to a Dart declaration: ${unit.type}',
      ),
  };
  return 'const $identifier = $value;';
}
