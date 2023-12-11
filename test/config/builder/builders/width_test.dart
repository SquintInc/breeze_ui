// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_elements/base.dart';

import '../tailwind_config_example.dart';

void main() {
  group('width', () {
    test('is generated with varying unit types', () {
      expect(w_0.value, equals(zero));
      expect(w_4.value, equals(RemUnit(1)));
      expect(w_frac_1_2.value, equals(PercentUnit(50)));
      expect(w_frac_2_3.value, equals(PercentUnit(66.666667)));
      expect(
        w_frac_1_2 == w_frac_2_4 &&
            w_frac_2_4 == w_frac_3_6 &&
            w_frac_3_6 == w_frac_6_12,
        isTrue,
      );
      expect(w_full.value, equals(PercentUnit(100)));
      expect(w_screen.value, equals(ViewportUnit(100)));
      expect(w_svw.value, equals(SmallViewportUnit(100)));
      expect(w_lvw.value, equals(LargeViewportUnit(100)));
      expect(w_dvw.value, equals(DynamicViewportUnit(100)));
    });
  });
}
