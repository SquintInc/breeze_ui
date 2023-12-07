import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_elements/config/base.dart';

part 'tailwind_config_builder_test.g.dart';

void main() {
  test('tailwind config loads successfully', () {
    expect(tailwindConfig, isNotNull);
    expect(tailwindConfig._theme, isNotEmpty);
  });
}
