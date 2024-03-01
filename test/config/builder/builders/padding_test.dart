// ignore_for_file: prefer_const_constructors
import 'package:breeze_ui/base.dart';
import 'package:breeze_ui/config/options/box_types.dart';
import 'package:flutter_test/flutter_test.dart';

import '../tailwind_config_example.dart';

void main() {
  group('padding', () {
    test('can be created with all sides having the same values', () {
      final padding = TwPadding.all(p_2);
      expect(padding.top, equals(TwPaddingTop(zero)));
      expect(padding.right, equals(TwPaddingRight(zero)));
      expect(padding.bottom, equals(TwPaddingBottom(zero)));
      expect(padding.left, equals(TwPaddingLeft(zero)));
      expect(padding.all, equals(p_2));
      expect(padding.x, equals(TwPaddingX(zero)));
      expect(padding.y, equals(TwPaddingY(zero)));
      expect(padding.type, equals(BoxSideType.all));
    });

    test('can be created with left and right sides having the same values', () {
      final padding = TwPadding.x(px_2);
      expect(padding.top, equals(TwPaddingTop(zero)));
      expect(padding.right, equals(TwPaddingRight(zero)));
      expect(padding.bottom, equals(TwPaddingBottom(zero)));
      expect(padding.left, equals(TwPaddingLeft(zero)));
      expect(padding.all, equals(TwPaddingAll(zero)));
      expect(padding.x, equals(px_2));
      expect(padding.y, equals(const TwPaddingY(zero)));
      expect(padding.type, equals(BoxSideType.x));
    });

    test('can be created with top and bottom sides having the same values', () {
      final padding = TwPadding.y(py_2);
      expect(padding.top, equals(TwPaddingTop(zero)));
      expect(padding.right, equals(TwPaddingRight(zero)));
      expect(padding.bottom, equals(TwPaddingBottom(zero)));
      expect(padding.left, equals(TwPaddingLeft(zero)));
      expect(padding.all, equals(TwPaddingAll(zero)));
      expect(padding.x, equals(TwPaddingX(zero)));
      expect(padding.y, equals(py_2));
      expect(padding.type, equals(BoxSideType.y));
    });

    test(
        'can be created with left & right and top & bottom sides having respective values',
        () {
      final padding = TwPadding.xy(px_2, py_4);
      expect(padding.top, equals(TwPaddingTop(zero)));
      expect(padding.right, equals(TwPaddingRight(zero)));
      expect(padding.bottom, equals(TwPaddingBottom(zero)));
      expect(padding.left, equals(TwPaddingLeft(zero)));
      expect(padding.all, equals(TwPaddingAll(zero)));
      expect(padding.x, equals(px_2));
      expect(padding.y, equals(py_4));
      expect(padding.type, equals(BoxSideType.xy));
    });

    test(
        'can be created with regular (trbl) constructor, setting each side individually',
        () {
      final padding = TwPadding(
        top: pt_2,
        right: pr_4,
        bottom: pb_8,
        left: pl_16,
      );
      expect(padding.top, equals(TwPaddingTop(RemUnit(0.5))));
      expect(padding.right, equals(TwPaddingRight(RemUnit(1))));
      expect(padding.bottom, equals(TwPaddingBottom(RemUnit(2))));
      expect(padding.left, equals(TwPaddingLeft(RemUnit(4))));
      expect(padding.all, equals(TwPaddingAll(zero)));
      expect(padding.x, equals(TwPaddingX(zero)));
      expect(padding.y, equals(TwPaddingY(zero)));
      expect(padding.type, equals(BoxSideType.trbl));
    });
  });
}
