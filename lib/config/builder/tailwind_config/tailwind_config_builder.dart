import 'dart:io';
import 'dart:isolate';

import 'package:build/build.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';

const String configFullJsUrl =
    'https://raw.githubusercontent.com/tailwindlabs/tailwindcss/master/stubs/config.full.js';

const breakpointGetterTypeName = '_BreakpointGetter';
const breakpointGetterTypeDef =
    'Map<String, dynamic> Function(Map<String, dynamic>)';
const themeValueGetterTypeName = '_ThemeValueGetter';
const themeValueGetterTypeDef = 'dynamic Function(String, [String])';
const additionalFunctionsPackage =
    'package:tailwind_elements/config/builder/tailwind_config/tailwind_config_fns.template.dart';
const templateRemovePriorIdentifier =
    '/* Remove everything before this line */';

class TailwindConfigBuilder extends Generator {
  final BuilderOptions options;

  const TailwindConfigBuilder(this.options);

  static String replaceConfigJsToDart(
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

  static Future<String> fetchFullConfig() async {
    final response = await http.get(Uri.parse(configFullJsUrl));
    return replaceConfigJsToDart(response.body, '_defaultConfigFull');
  }

  static Future<String> fetchLocalConfig() async {
    final cwd = Directory.current;
    final localConfigFile = File(path.join(cwd.path, 'tailwind.config.js'));
    if (await localConfigFile.exists()) {
      final localConfig = await localConfigFile.readAsString();
      return replaceConfigJsToDart(localConfig, '_config');
    }
    return 'final Map<String, dynamic> _config = {};\n';
  }

  static Future<String> fetchAdditionalFunctionsTemplate() async {
    final uri = Uri.parse(additionalFunctionsPackage);
    final packageUri = await Isolate.resolvePackageUri(uri);
    if (packageUri == null) {
      throw Exception(
        'Failed to locate and read $additionalFunctionsPackage',
      );
    }

    // Clean path string if it starts with a leading slash '/' as prefix
    final packageUriPath = packageUri.path.startsWith('/')
        ? packageUri.path.substring(1)
        : packageUri.path;
    final srcFile = File(packageUriPath);
    if (!(await srcFile.exists())) {
      throw Exception('Failed to read ${packageUri.path}');
    }
    final template = await srcFile.readAsString();
    final templateLines = template.split('\n');
    final removeBeforeIndex = templateLines
        .indexWhere((final line) => line == templateRemovePriorIdentifier);
    return templateLines.sublist(removeBeforeIndex + 1).join('\n');
  }

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final buffer = StringBuffer();
    final config = await fetchFullConfig();
    final localConfig = await fetchLocalConfig();
    final additionalFunctions = await fetchAdditionalFunctionsTemplate();

    buffer
      ..writeln(
        'typedef $themeValueGetterTypeName = $themeValueGetterTypeDef;',
      )
      ..writeln()
      ..writeln(
        'typedef $breakpointGetterTypeName = $breakpointGetterTypeDef;',
      )
      ..writeln()
      ..writeln(config)
      ..writeln(localConfig)
      ..writeln()
      ..writeln(additionalFunctions);

    return buffer.toString();
  }
}
