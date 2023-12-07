import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/builder_config_functions.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/builder_full_config.dart';
import 'package:tailwind_elements/config/builder/tailwind_config/builder_local_config.dart';

// Explicitly import template files to help invalidate asset graph for build_runner
// ignore: unused_import
import 'package:tailwind_elements/config/builder/tailwind_config/config_functions.template.dart';

Builder tailwindConfigBuilder(final BuilderOptions options) {
  return SharedPartBuilder(
    [
      TailwindFullConfigBuilder(options),
      TailwindLocalConfigBuilder(options),
      TailwindConfigFunctionsBuilder(options),
    ],
    'tailwind_config',
  );
}
