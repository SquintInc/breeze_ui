// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_elements/base.dart';

import '../tailwind_config_example.dart';

void main() {
  group('max height', () {
    test('is generated with varying unit types', () {
      expect(max_h_0.value, equals(zero));
      expect(max_h_4.value, equals(RemUnit(1)));
      expect(max_h_96.value, equals(RemUnit(24)));
      expect(max_h_full.value, equals(PercentUnit(100)));
      expect(max_h_screen.value, equals(ViewportUnit(100)));
      expect(max_h_svh.value, equals(SmallViewportUnit(100)));
      expect(max_h_lvh.value, equals(LargeViewportUnit(100)));
      expect(max_h_dvh.value, equals(DynamicViewportUnit(100)));
    });
  });
}
