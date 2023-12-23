import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/build_runner/box_shadow_parser.dart';
import 'package:tailwind_elements/config/builder/builders/generators.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'shadow-*' box shadow
/// constants to the .g.dart part file.
class BoxShadowBuilder extends ConstantsGenerator {
  const BoxShadowBuilder(
    super.options,
    super.config, {
    super.generatorType = GeneratorType.rawValues,
  });

  @override
  String get themeConfigKey => 'boxShadow';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'shadow': 'TwBoxShadow',
      };

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final Map<String, String> boxShadowsMap = getThemeValues()
        .map((final key, final value) => MapEntry(key, value.toString()));
    final allDeclarations = variablePrefixToValueClassName.entries.map((
      final prefix,
    ) {
      final prefixDeclarations =
          boxShadowsMap.entries.map((final boxShadowEntry) {
        final String varName = CodeWriter.variableName(
          prefix.key,
          boxShadowEntry.key == 'DEFAULT'
              ? ''
              : boxShadowEntry.key.toSnakeCase(),
        );
        final boxShadows = BoxShadowParser.parse(boxShadowEntry.value);
        final String lineDeclaration = CodeWriter.dartLineDeclaration(
          variableName: varName,
          valueConstructor:
              boxShadows.toDartConstructor(wrapperClassName: 'TwBoxShadows'),
        );
        return lineDeclaration;
      });
      return prefixDeclarations
          .where((final declaration) => declaration.isNotEmpty)
          .join('\n');
    });
    return allDeclarations.join('\n');
  }
}
