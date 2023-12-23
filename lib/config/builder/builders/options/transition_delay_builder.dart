import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/transitions/transition_delay.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'delay-*' constants to the
/// .g.dart part file.
class TransitionDelayBuilder extends ConstantsGenerator {
  const TransitionDelayBuilder(
    super.options,
    super.config, {
    super.generatorType = GeneratorType.timeUnits,
  });

  @override
  String get themeConfigKey => 'transitionDelay';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'delay': (TwTransitionDelay).toString(),
      };
}
