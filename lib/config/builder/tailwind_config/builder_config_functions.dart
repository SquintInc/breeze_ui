import 'dart:io';
import 'dart:isolate';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

const additionalFunctionsPackage =
    'package:tailwind_elements/config/builder/tailwind_config/config_functions.template.dart';
const templateRemovePriorIdentifier =
    '/* WARNING: build_runner will remove everything before this line */';

/// A [SharedPartBuilder] that generates a portion of a Dart class containing
/// functions to operate on the generated TailwindCSS config.
class TailwindConfigFunctionsBuilder extends Generator {
  final BuilderOptions options;

  const TailwindConfigFunctionsBuilder(this.options);

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
    final additionalFunctions = await fetchAdditionalFunctionsTemplate();
    return additionalFunctions;
  }
}
