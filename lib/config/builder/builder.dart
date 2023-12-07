import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

// Explicitly import template files to help invalidate asset graph for build_runner
// ignore: unused_import
import 'package:tailwind_elements/config/builder/tailwind_config/config_functions.template.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/tailwind_config_builder.dart';

Builder tailwindConfigBuilder(final BuilderOptions options) {
  return SharedPartBuilder(
    [
      TailwindConfigBuilder(options),
    ],
    'tailwind_config',
  );
}
