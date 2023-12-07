import 'dart:io';

import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/config_parser.dart';

/// A [SharedPartBuilder] that generates a portion of a Dart class containing
/// the local TailwindCSS config. The TailwindCSS config is fetched from the
/// current working directory, and if not found, will default to an empty map.
class TailwindLocalConfigBuilder extends Generator {
  final BuilderOptions options;

  const TailwindLocalConfigBuilder(this.options);

  static Future<String> fetchLocalConfig() async {
    final cwd = Directory.current;
    final localConfigFile = File(path.join(cwd.path, 'tailwind.config.js'));
    if (await localConfigFile.exists()) {
      final localConfig = await localConfigFile.readAsString();
      return replaceConfigJsToDart(localConfig, '_config');
    }
    return 'final Map<String, dynamic> _config = {};\n';
  }

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    return fetchLocalConfig();
  }
}
