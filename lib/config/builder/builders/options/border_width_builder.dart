import 'package:breeze_ui/config/builder/builders/generators.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'border-*' border width
/// constants to the .g.dart part file.
class BorderWidthBuilder extends ConstantsGenerator {
  const BorderWidthBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'borderWidth';

  @override
  Map<String, String> get variablePrefixToValueClassName {
    return {
      'border': 'TwBorderAll',
      'border-x': 'TwBorderX',
      'border-y': 'TwBorderY',
      'border-t': 'TwBorderTop',
      'border-r': 'TwBorderRight',
      'border-b': 'TwBorderBottom',
      'border-l': 'TwBorderLeft',
    };
  }
}
