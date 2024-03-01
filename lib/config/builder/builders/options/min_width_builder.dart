import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/sizing/min_width.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'min-w-*' min width
/// constants to the .g.dart part file.
class MinWidthBuilder extends ConstantsGenerator {
  const MinWidthBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'minWidth';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'min-w': (TwMinWidth).toString(),
      };
}
