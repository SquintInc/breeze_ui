import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/constants/converter.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/tailwind_config.dart';

@immutable
abstract class ConstantsGenerator extends Generator {
  final BuilderOptions options;
  final TailwindConfig config;

  String get identifierPrefix;

  String get themeConfigKey;

  String get wrappedClassName;

  String getIdentifier(final String keySuffix) =>
      '${identifierPrefix}_$keySuffix';

  const ConstantsGenerator(this.options, this.config);

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final values = config.getUsable(themeConfigKey);
    final declarations = values.entries.map((final entry) {
      final identifier = getIdentifier(
        getDartIdentifierSuffix(entry.key, entry.value),
      );
      final declaration =
          getDartDeclaration(identifier, wrappedClassName, entry.value);
      return declaration;
    });
    return declarations.join('\n');
  }
}
