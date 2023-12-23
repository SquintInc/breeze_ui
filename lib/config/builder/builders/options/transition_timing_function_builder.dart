import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/builders/generators.dart';

const String _linear = 'linear';
const String _cubicBezier = 'cubic-bezier';
final RegExp _cubicBezierRegExp =
    RegExp(r'^cubic-bezier\s*\(\s*(.*)\s*\)\s*;*$');

/// A [ConstantsGenerator] used to generate Tailwind 'ease-*' constants to the
/// .g.dart part file.
class TransitionTimingFunctionBuilder extends ConstantsGenerator {
  const TransitionTimingFunctionBuilder(
    super.options,
    super.config, {
    super.generatorType = GeneratorType.rawValues,
  });

  @override
  String get themeConfigKey => 'transitionTimingFunction';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'ease': 'TwTransitionTimingFunction',
      };

  static String parseTimingFunction(final String value) {
    if (value.startsWith(_linear)) {
      return 'Curves.linear';
    }
    if (value.startsWith(_cubicBezier)) {
      final match = _cubicBezierRegExp.firstMatch(value);
      if (match == null) {
        throw Exception('Invalid cubic-bezier value: $value');
      }
      final group = match.group(1);
      if (group == null) {
        throw Exception('Invalid cubic-bezier value: $value');
      }
      final values = group.split(',').map((final v) => v.trim());
      return 'Cubic(${values.join(', ')})';
    }
    throw Exception('Invalid CSS transition-timing-function: $value');
  }

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    final Map<String, String> themeValues = getThemeValues()
        .map((final key, final value) => MapEntry(key, value.toString()));
    final allDeclarations = variablePrefixToValueClassName.entries.map((
      final prefix,
    ) {
      final prefixDeclarations = themeValues.entries.map((final themeValue) {
        final String varName = CodeWriter.variableName(
          prefix.key,
          themeValue.key == 'DEFAULT' ? '' : themeValue.key.toSnakeCase(),
        );

        // Process transition timing function string value
        final timingFunction = parseTimingFunction(themeValue.value);

        final String lineDeclaration = CodeWriter.dartLineDeclaration(
          variableName: varName,
          valueConstructor: '${prefix.value}($timingFunction)',
        );
        return lineDeclaration;
      });
      return prefixDeclarations.join('\n');
    });
    return allDeclarations.join('\n');
  }
}
