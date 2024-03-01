// ignore_for_file: prefer_const_constructors
import 'package:breeze_ui/base.dart';
import 'package:breeze_ui/config/options/box_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tailwind_config_example.dart';

void main() {
  group('border width', () {
    test('can be created with all sides having the same values', () {
      final border = TwBorder.all(border_2);
      expect(border.top, equals(TwBorderTop(zero)));
      expect(border.right, equals(TwBorderRight(zero)));
      expect(border.bottom, equals(TwBorderBottom(zero)));
      expect(border.left, equals(TwBorderLeft(zero)));
      expect(border.all, equals(border_2));
      expect(border.x, equals(TwBorderX(zero)));
      expect(border.y, equals(TwBorderY(zero)));
      expect(border.type, equals(BoxSideType.all));
    });

    test('can be created with left and right sides having the same values', () {
      final border = TwBorder.x(border_x_2);
      expect(border.top, equals(TwBorderTop(zero)));
      expect(border.right, equals(TwBorderRight(zero)));
      expect(border.bottom, equals(TwBorderBottom(zero)));
      expect(border.left, equals(TwBorderLeft(zero)));
      expect(border.all, equals(TwBorderAll(zero)));
      expect(border.x, equals(border_x_2));
      expect(border.y, equals(const TwBorderY(zero)));
      expect(border.type, equals(BoxSideType.x));
    });

    test('can be created with top and bottom sides having the same values', () {
      final border = TwBorder.y(border_y_2);
      expect(border.top, equals(TwBorderTop(zero)));
      expect(border.right, equals(TwBorderRight(zero)));
      expect(border.bottom, equals(TwBorderBottom(zero)));
      expect(border.left, equals(TwBorderLeft(zero)));
      expect(border.all, equals(TwBorderAll(zero)));
      expect(border.x, equals(TwBorderX(zero)));
      expect(border.y, equals(border_y_2));
      expect(border.type, equals(BoxSideType.y));
    });

    test(
        'can be created with left & right and top & bottom sides having respective values',
        () {
      final border = TwBorder.xy(border_x_2, border_y_4);
      expect(border.top, equals(TwBorderTop(zero)));
      expect(border.right, equals(TwBorderRight(zero)));
      expect(border.bottom, equals(TwBorderBottom(zero)));
      expect(border.left, equals(TwBorderLeft(zero)));
      expect(border.all, equals(TwBorderAll(zero)));
      expect(border.x, equals(border_x_2));
      expect(border.y, equals(border_y_4));
      expect(border.type, equals(BoxSideType.xy));
    });

    test(
        'can be created with regular (trbl) constructor, setting each side individually',
        () {
      final border = TwBorder(
        top: border_t_2,
        right: border_r_4,
        bottom: border_b_8,
        left: border_l,
      );
      expect(border.top, equals(TwBorderTop(PxUnit(2))));
      expect(border.right, equals(TwBorderRight(PxUnit(4))));
      expect(border.bottom, equals(TwBorderBottom(PxUnit(8))));
      expect(border.left, equals(TwBorderLeft(PxUnit(1))));
      expect(border.all, equals(TwBorderAll(zero)));
      expect(border.x, equals(TwBorderX(zero)));
      expect(border.y, equals(TwBorderY(zero)));
      expect(border.type, equals(BoxSideType.trbl));
    });
  });
}
