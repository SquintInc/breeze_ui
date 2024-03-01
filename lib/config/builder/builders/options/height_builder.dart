import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/sizing/height.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'h-*' height constants
/// to the .g.dart part file.
class HeightBuilder extends ConstantsGenerator {
  const HeightBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'height';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'h': (TwHeight).toString(),
      };
}
