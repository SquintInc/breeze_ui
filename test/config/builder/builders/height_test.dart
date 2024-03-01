// ignore_for_file: prefer_const_constructors
import 'package:breeze_ui/base.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tailwind_config_example.dart';

void main() {
  group('height', () {
    test('is generated with varying unit types', () {
      expect(h_0.value, equals(zero));
      expect(h_4.value, equals(RemUnit(1)));
      expect(h_frac_1_2.value, equals(PercentUnit(50)));
      expect(h_frac_2_3.value, equals(PercentUnit(66.666667)));
      expect(
        h_frac_1_2 == h_frac_2_4 && h_frac_2_4 == h_frac_3_6,
        isTrue,
      );
      expect(h_full.value, equals(PercentUnit(100)));
      expect(h_screen.value, equals(ViewportUnit(100)));
      expect(h_svh.value, equals(SmallViewportUnit(100)));
      expect(h_lvh.value, equals(LargeViewportUnit(100)));
      expect(h_dvh.value, equals(DynamicViewportUnit(100)));
    });
  });
}
