import 'package:build/build.dart';
import 'package:http/http.dart' as http;
import 'package:source_gen/source_gen.dart';

import 'package:tailwind_elements/config/builder/tailwind_config/config_parser.dart';

const String configFullJsUrl =
    'https://raw.githubusercontent.com/tailwindlabs/tailwindcss/master/stubs/config.full.js';

/// A [SharedPartBuilder] that generates a portion of a Dart class containing
/// the full TailwindCSS config. The TailwindCSS config is fetched upstream from
/// the official TailwindCSS GitHub repo.
class TailwindFullConfigBuilder extends Generator {
  final BuilderOptions options;

  const TailwindFullConfigBuilder(this.options);

  static Future<String> fetchFullConfig() async {
    final response = await http.get(Uri.parse(configFullJsUrl));
    return replaceConfigJsToDart(response.body, '_defaultConfigFull');
  }

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final buffer = StringBuffer();
    final fullConfig = await fetchFullConfig();
    buffer
      ..writeln(
        'typedef $themeValueGetterTypeName = $themeValueGetterTypeDef;\n',
      )
      ..writeln(
        'typedef $breakpointGetterTypeName = $breakpointGetterTypeDef;\n',
      )
      ..writeln(fullConfig);
    return buffer.toString();
  }
}
