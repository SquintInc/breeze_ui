import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:build/build.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/tailwind_config.dart';

const String configFullJsUrl =
    'https://raw.githubusercontent.com/tailwindlabs/tailwindcss/master/stubs/config.full.js';
const String configColorsJsUrl =
    'https://raw.githubusercontent.com/tailwindlabs/tailwindcss/master/src/public/colors.js';
const additionalFunctionsPackage =
    'package:tailwind_elements/config/builder/config_functions.template.dart';
const templateRemovePriorIdentifier =
    '/* WARNING: build_runner will remove everything before this line */';

const breakpointGetterTypeName = '_BreakpointGetter';
const breakpointGetterTypeDef = 'dynamic Function(Map<String, dynamic>)';
const themeValueGetterTypeName = '_ThemeValueGetter';
const themeValueGetterTypeDef = 'dynamic Function(String, [String])';
const colorsGetterTypeName = '_ColorsGetter';
const colorsGetterTypeDef = 'dynamic Function(String)';

String replaceColorsJsToDart(
  final String colorsJs,
  final String dartVarName,
) {
  final lines = colorsJs.split('\n');
  final exportIndex = lines.indexOf('export default {');
  return lines
      .sublist(exportIndex)
      .join('\n')
      // Replace module.exports / export default with a valid Dart declaration
      .replaceFirstMapped(
        RegExp(r'(export default)|(module\.exports)'),
        (final match) => 'final Map<String, dynamic> $dartVarName = ',
      )
      // Replace all Javascript object keys with string form
      .replaceAllMapped(
        RegExp('([a-zA-Z0-9._-]+):'),
        (final match) => "'${match.group(1)}':",
      )
      // Remove all getter functions from colors config
      .replaceAllMapped(RegExp(r'get.*{((.|\n)*?)},\s*'), (final match) => '')
      // Add semi-colon to map declaration in case there was none
      .replaceFirstMapped(RegExp(r'}\s+$'), (final match) => '};\n');
}

String replaceConfigJsToDart(
  final String configJs,
  final String dartVarName,
) {
  return configJs
      // Replace module.exports / export default with a valid Dart declaration
      .replaceFirstMapped(
        RegExp(r'(export default)|(module\.exports =)'),
        (final match) => 'final Map<String, dynamic> $dartVarName =',
      )
      // Add extra type properties to anonymous functions in tailwind config
      .replaceAllMapped(
        RegExp(r'\(\s*{\s*(([a-zA-Z],*\s*)+)\s*}\s*\)'),
        (final match) =>
            '({ required $themeValueGetterTypeName theme, required $breakpointGetterTypeName breakpoints, required $colorsGetterTypeName colors })',
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
      // Replace all colors Javascript object notation with a function call
      .replaceAllMapped(
        RegExp(r'colors(\.([^.]*?)),'),
        (final match) => "colors('${match.group(2)}'),",
      )
      // Add semi-colon to map declaration in case there was none
      .replaceFirstMapped(RegExp(r'}\s+$'), (final match) => '};\n');
}

/// A [SharedPartBuilder] that is used to parse TailwindCSS config files and
/// generate Dart code in-memory so that it can be used by subsequent builders
/// for generating Tailwind constants.
///
/// This builder doesn't generate any output to the .g.dart file.
class TailwindConfigBuilder extends Generator {
  final BuilderOptions options;
  final TailwindConfig config;

  const TailwindConfigBuilder(this.options, this.config);

  static Future<String> fetchFullConfig() async {
    final response = await http.get(Uri.parse(configFullJsUrl));
    return replaceConfigJsToDart(response.body, '_fullConfig');
  }

  static Future<String> fetchColorsConfig() async {
    final response = await http.get(Uri.parse(configColorsJsUrl));
    return replaceColorsJsToDart(response.body, '_colorsConfig');
  }

  static Future<String> fetchLocalConfig() async {
    const dartVarName = '_localConfig';
    final cwd = Directory.current;
    final localConfigFile = File(path.join(cwd.path, 'tailwind.config.js'));
    if (await localConfigFile.exists()) {
      final localConfig = await localConfigFile.readAsString();
      return replaceConfigJsToDart(localConfig, dartVarName);
    }
    return 'final Map<String, dynamic> $dartVarName = {};\n';
  }

  static Future<String> fetchAdditionalFunctionsTemplate() async {
    final uri = Uri.parse(additionalFunctionsPackage);
    final packageUri = await Isolate.resolvePackageUri(uri);
    if (packageUri == null) {
      throw Exception(
        'Failed to locate and read $additionalFunctionsPackage',
      );
    }

    final templateSrcFilePath =
        packageUri.toFilePath(windows: Platform.isWindows);
    final srcFile = File(templateSrcFilePath);
    if (!(await srcFile.exists())) {
      throw Exception('Failed to read ${packageUri.path}');
    }
    final template = await srcFile.readAsString();
    final templateLines = template.split('\n');
    final removeBeforeIndex = templateLines
        .indexWhere((final line) => line == templateRemovePriorIdentifier);
    return templateLines.sublist(removeBeforeIndex + 1).join('\n');
  }

  /// Generate a temporary Dart source file containing the full TailwindCSS
  /// configuration.
  static Future<String> generateConfig() async {
    final colorsConfig = await fetchColorsConfig();
    final fullConfig = await fetchFullConfig();
    final localConfig = await fetchLocalConfig();
    final additionalFunctions = await fetchAdditionalFunctionsTemplate();

    final buffer = StringBuffer()
      ..writeln("import 'dart:convert';\n")
      ..writeln(
        "import 'package:tailwind_elements/config/builder/tailwind_config.dart';\n",
      )
      ..writeln(
        'typedef $themeValueGetterTypeName = $themeValueGetterTypeDef;\n',
      )
      ..writeln(
        'typedef $breakpointGetterTypeName = $breakpointGetterTypeDef;\n',
      )
      ..writeln(
        'typedef $colorsGetterTypeName = $colorsGetterTypeDef;\n',
      )
      ..writeln(colorsConfig)
      ..writeln(fullConfig)
      ..writeln(localConfig)
      ..writeln(additionalFunctions);
    return buffer.toString();
  }

  Future<Map<String, dynamic>> decodeConfig(final String configSrcCode) async {
    final uri = Uri.dataFromString(
      """import 'dart:isolate';

$configSrcCode

void main(_, final SendPort port) {
  port.send(tailwindConfig.toJson());
}
""",
      mimeType: 'application/dart',
    );
    final port = ReceivePort();
    await Isolate.spawnUri(uri, [], port.sendPort);
    final jsonString = await port.first;
    port.close();
    return jsonDecode(jsonString);
  }

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final configSrcCode = await generateConfig();
    final Map<String, dynamic> themeConfigMapping =
        await decodeConfig(configSrcCode);

    config.setTheme(themeConfigMapping);

    return '// TailwindConfigBuilder ran successfully. Constants are outputted below this.';
  }
}
