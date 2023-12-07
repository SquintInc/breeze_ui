const breakpointGetterTypeName = '_BreakpointGetter';
const breakpointGetterTypeDef =
    'Map<String, dynamic> Function(Map<String, dynamic>)';
const themeValueGetterTypeName = '_ThemeValueGetter';
const themeValueGetterTypeDef = 'dynamic Function(String, [String])';

String replaceConfigJsToDart(
  final String configJs,
  final String dartVarName,
) {
  return configJs
      // Replace module.exports with a valid Dart declaration
      .replaceAll(
        'module.exports',
        'final Map<String, dynamic> $dartVarName',
      )
      // Add extra type properties to anonymous functions in tailwind config
      .replaceAll(
        '({ theme })',
        '({ required $themeValueGetterTypeName theme, $breakpointGetterTypeName? breakpoints })',
      )
      // Replace all Javascript object keys with string form
      .replaceAllMapped(
        RegExp('([a-zA-Z0-9._-]+):'),
        (final match) => "'${match.group(1)}':",
      )
      // Specify theme parameter return type when performing spread operator
      .replaceAllMapped(
        RegExp(r"\.\.\.theme\('.*?'\)"),
        (final match) => '${match.group(0)} as Map<String, dynamic>',
      )
      // Add semi-colon to map declaration in case there was none
      .replaceFirstMapped(RegExp(r'}\s+$'), (final match) => '};\n');
}
