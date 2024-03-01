import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/sizing/width.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'w-*' width constants
/// to the .g.dart part file.
class WidthBuilder extends ConstantsGenerator {
  const WidthBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'width';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'w': (TwWidth).toString(),
      };
}
