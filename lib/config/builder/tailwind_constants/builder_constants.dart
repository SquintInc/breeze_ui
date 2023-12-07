import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/tailwind_config.dart';

/// A [LibraryBuilder] that generates constants using the configuration values
/// provided by a [TailwindConfig] instance.
class TailwindConstantsBuilder extends Generator {
  final BuilderOptions options;
  final TailwindConfig config;

  const TailwindConstantsBuilder(this.options, this.config);

  static String test() {
    return 'test';
  }

  @override
  Future<String> generate(
    final LibraryReader library,
    final BuildStep buildStep,
  ) async {
    print(config.getUsable('spacing'));
    return '';
  }
}

/// A [SharedPartBuilder] that generates a of a Dart class containing
///
Builder tailwindConstantsBuilder(
  final BuilderOptions options,
  final TailwindConfig config,
) {
  return LibraryBuilder(
    TailwindConstantsBuilder(options, config),
  );
}
