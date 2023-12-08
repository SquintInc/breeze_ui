import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/constants/converter.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/tailwind_config.dart';

/// A [Generator] used to generate Tailwind constants to the .g.dart part file.
@immutable
abstract class ConstantsGenerator extends Generator {
  final BuilderOptions options;
  final TailwindConfig config;

  /// The prefix to use for the generated Dart identifier (variable name).
  /// This is often just the first letter of the Tailwind config key.
  String get identifierPrefix;

  /// The Tailwind config key to use for fetching the key : unit mappings.
  String get themeConfigKey;

  /// The name of the class to wrap the generated unit constants in, for
  /// constrained type safety.
  String get wrappedClassName;

  /// Returns the full Dart identifier (variable name) for the given
  /// [keySuffix]. This is simply a snake_case concatenation of the
  /// [identifierPrefix] and [keySuffix].
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
