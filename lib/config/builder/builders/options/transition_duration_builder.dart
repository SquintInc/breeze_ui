import 'package:tailwind_elements/config/builder/builders/generators.dart';
import 'package:tailwind_elements/config/options/transitions/transition_duration.dart';

/// A [ConstantsGenerator] used to generate Tailwind 'duration-*' constants to
/// the .g.dart part file.
class TransitionDurationBuilder extends ConstantsGenerator {
  const TransitionDurationBuilder(
    super.options,
    super.config, {
    super.generatorType = GeneratorType.timeUnits,
  });

  @override
  String get themeConfigKey => 'transitionDuration';

  @override
  Map<String, String> get variablePrefixToValueClassName => {
        'duration': (TwTransitionDuration).toString(),
      };
}
