// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/config/options/box_types.dart';

import '../tailwind_config_example.dart';

void main() {
  group('margin', () {
    test('can be created with all sides having the same values', () {
      final margin = TwMargin.all(m_2);
      expect(margin.top, equals(TwMarginTop(zero)));
      expect(margin.right, equals(TwMarginRight(zero)));
      expect(margin.bottom, equals(TwMarginBottom(zero)));
      expect(margin.left, equals(TwMarginLeft(zero)));
      expect(margin.all, equals(m_2));
      expect(margin.x, equals(TwMarginX(zero)));
      expect(margin.y, equals(TwMarginY(zero)));
      expect(margin.type, equals(BoxSideType.all));
    });

    test('can be created with left and right sides having the same values', () {
      final margin = TwMargin.x(mx_2);
      expect(margin.top, equals(TwMarginTop(zero)));
      expect(margin.right, equals(TwMarginRight(zero)));
      expect(margin.bottom, equals(TwMarginBottom(zero)));
      expect(margin.left, equals(TwMarginLeft(zero)));
      expect(margin.all, equals(TwMarginAll(zero)));
      expect(margin.x, equals(mx_2));
      expect(margin.y, equals(const TwMarginY(zero)));
      expect(margin.type, equals(BoxSideType.x));
    });

    test('can be created with top and bottom sides having the same values', () {
      final margin = TwMargin.y(my_2);
      expect(margin.top, equals(TwMarginTop(zero)));
      expect(margin.right, equals(TwMarginRight(zero)));
      expect(margin.bottom, equals(TwMarginBottom(zero)));
      expect(margin.left, equals(TwMarginLeft(zero)));
      expect(margin.all, equals(TwMarginAll(zero)));
      expect(margin.x, equals(TwMarginX(zero)));
      expect(margin.y, equals(my_2));
      expect(margin.type, equals(BoxSideType.y));
    });

    test(
        'can be created with left & right and top & bottom sides having respective values',
        () {
      final margin = TwMargin.xy(mx_2, my_4);
      expect(margin.top, equals(TwMarginTop(zero)));
      expect(margin.right, equals(TwMarginRight(zero)));
      expect(margin.bottom, equals(TwMarginBottom(zero)));
      expect(margin.left, equals(TwMarginLeft(zero)));
      expect(margin.all, equals(TwMarginAll(zero)));
      expect(margin.x, equals(mx_2));
      expect(margin.y, equals(my_4));
      expect(margin.type, equals(BoxSideType.xy));
    });

    test(
        'can be created with regular (trbl) constructor, setting each side individually',
        () {
      final margin = TwMargin(
        top: mt_2,
        right: mr_4,
        bottom: mb_8,
        left: ml_16,
      );
      expect(margin.top, equals(TwMarginTop(RemUnit(0.5))));
      expect(margin.right, equals(TwMarginRight(RemUnit(1))));
      expect(margin.bottom, equals(TwMarginBottom(RemUnit(2))));
      expect(margin.left, equals(TwMarginLeft(RemUnit(4))));
      expect(margin.all, equals(TwMarginAll(zero)));
      expect(margin.x, equals(TwMarginX(zero)));
      expect(margin.y, equals(TwMarginY(zero)));
      expect(margin.type, equals(BoxSideType.trbl));
    });
  });
}
