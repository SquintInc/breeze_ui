// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_elements/base.dart';

import '../tailwind_config_example.dart';

void main() {
  group('background colors', () {
    test('are generated with wrapper value class dependent on dart:ui', () {
      expect(bg_transparent, equals(TwBackgroundColor(Color(0x00000000))));
      expect(bg_black.color, equals(Colors.black));
      expect(bg_white.color, equals(Colors.white));
    });
  });

  group('box shadow colors', () {
    test('are generated with wrapper value class dependent on dart:ui', () {
      expect(shadow_transparent, equals(TwBoxShadowColor(Color(0x00000000))));
      expect(shadow_black.color, equals(Colors.black));
      expect(shadow_white.color, equals(Colors.white));
    });
  });

  group('text colors', () {
    test('are generated with wrapper value class dependent on dart:ui', () {
      expect(text_transparent, equals(TwTextColor(Color(0x00000000))));
      expect(text_black.color, equals(Colors.black));
      expect(text_white.color, equals(Colors.white));
    });
  });

  group('border colors', () {
    test('are generated with wrapper value class dependent on dart:ui', () {
      expect(border_transparent, equals(TwBorderColor(Color(0x00000000))));
      expect(border_black.color, equals(Colors.black));
      expect(border_white.color, equals(Colors.white));
    });
  });
}
