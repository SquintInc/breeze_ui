// ignore_for_file: prefer_const_constructors
import 'package:breeze_ui/base.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tailwind_config_example.dart';

void main() {
  group('min width', () {
    test('is generated with varying unit types', () {
      expect(min_w_0.value, equals(zero));
      expect(min_w_4.value, equals(RemUnit(1)));
      expect(min_w_96.value, equals(RemUnit(24)));
      expect(min_w_full.value, equals(PercentUnit(100)));
    });
  });
}
