import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/sizing/max_width.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'max-w-*' max width
/// constants to the .g.dart part file.
class MaxWidthBuilder extends ConstantsGenerator {
  const MaxWidthBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'maxWidth';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'max-w': (TwMaxWidth).toString(),
      };
}
