// ignore_for_file: prefer_const_constructors
import 'package:breeze_ui/base.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tailwind_config_example.dart';

void main() {
  group('min height', () {
    test('is generated with varying unit types', () {
      expect(min_h_0.value, equals(zero));
      expect(min_h_4.value, equals(RemUnit(1)));
      expect(min_h_96.value, equals(RemUnit(24)));
      expect(min_h_full.value, equals(PercentUnit(100)));
      expect(min_h_screen.value, equals(ViewportUnit(100)));
      expect(min_h_svh.value, equals(SmallViewportUnit(100)));
      expect(min_h_lvh.value, equals(LargeViewportUnit(100)));
      expect(min_h_dvh.value, equals(DynamicViewportUnit(100)));
    });
  });
}
