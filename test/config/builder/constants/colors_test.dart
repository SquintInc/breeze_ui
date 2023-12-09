// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_elements/base.dart';

import '../tailwind_config_example.dart';

void main() {
  group('colors', () {
    test('is generated with wrapper value class dependent on dart:ui', () {
      expect(transparent, equals(TwColor(Color(0x00000000))));
      expect(black.color, equals(Colors.black));
      expect(white.color, equals(Colors.white));
    });
  });
}
