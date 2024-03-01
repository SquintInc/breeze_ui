import 'package:breeze_ui/config/builder/builders/generators.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'm-*' margin constants
/// to the .g.dart part file.
class MarginBuilder extends ConstantsGenerator {
  const MarginBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'margin';

  @override
  Map<String, String> get variablePrefixToValueClassName {
    return {
      'm': 'TwMarginAll',
      'mx': 'TwMarginX',
      'my': 'TwMarginY',
      'mt': 'TwMarginTop',
      'mr': 'TwMarginRight',
      'mb': 'TwMarginBottom',
      'ml': 'TwMarginLeft',
    };
  }
}
