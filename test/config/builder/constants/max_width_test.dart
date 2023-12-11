// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_elements/base.dart';

import '../tailwind_config_example.dart';

void main() {
  group('max width', () {
    test('is generated with varying unit types', () {
      expect(max_w_0.value, equals(zero));
      expect(max_w_4.value, equals(RemUnit(1)));
      expect(max_w_96.value, equals(RemUnit(24)));
      expect(max_w_full.value, equals(PercentUnit(100)));
      expect(max_w_screen_sm.value, equals(PxUnit(640)));
      expect(max_w_screen_md.value, equals(PxUnit(768)));
      expect(max_w_screen_lg.value, equals(PxUnit(1024)));
      expect(max_w_screen_xl.value, equals(PxUnit(1280)));
      expect(max_w_screen_2xl.value, equals(PxUnit(1536)));
    });
  });
}
