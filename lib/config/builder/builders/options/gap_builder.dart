import 'package:breeze_ui/config/builder/builders/generators.dart';
import 'package:breeze_ui/config/options/sizing/gap.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'gap-*' constants to the
/// .g.dart part file.
class GapBuilder extends ConstantsGenerator {
  const GapBuilder(super.options, super.config);

  @override
  String get themeConfigKey => 'gap';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'gap-x': (TwGapX).toString(),
        'gap-y': (TwGapY).toString(),
      };
}
