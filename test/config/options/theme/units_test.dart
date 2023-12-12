// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:tailwind_elements/base.dart';

void main() {
  test('tailwind units use value equality', () {
    expect(const PxUnit(123), equals(PxUnit(123)));
    expect(const PxUnit(456), equals(PxUnit(450 + 6)));
  });

  test('zeroed tailwind units are all equal', () {
    final List<TwUnit> units = [
      const PxUnit(0),
      const EmUnit(0),
      const RemUnit(0),
      const PercentUnit(0),
      const ViewportUnit(0),
      const DynamicViewportUnit(0),
      const SmallViewportUnit(0),
      const LargeViewportUnit(0),
    ];

    expect(
      units[0] == units[1] &&
          units[1] == units[2] &&
          units[2] == units[3] &&
          units[3] == units[4] &&
          units[4] == units[5] &&
          units[5] == units[6] &&
          units[6] == units[7],
      isTrue,
    );
  });

  test('random non-zero tailwind units are not equal', () {
    final List<TwUnit> units = [
      const PxUnit(1),
      const EmUnit(1),
      const RemUnit(1),
      const PercentUnit(1),
      const ViewportUnit(1),
      const DynamicViewportUnit(1),
      const SmallViewportUnit(1),
      const LargeViewportUnit(1),
    ];

    expect(
      units[0] == units[1] &&
          units[1] == units[2] &&
          units[2] == units[3] &&
          units[3] == units[4] &&
          units[4] == units[5] &&
          units[5] == units[6] &&
          units[6] == units[7],
      isFalse,
    );
  });

  test('TwUnit.parse() parses successfully for "rem" units', () {
    expect(TwUnit.parse('-0.05rem'), equals(RemUnit(-0.05)));
    expect(TwUnit.parse('-0.025rem'), equals(RemUnit(-0.025)));
    expect(TwUnit.parse('0rem'), equals(RemUnit(0)));
    expect(TwUnit.parse('0.025rem'), equals(RemUnit(0.025)));
    expect(TwUnit.parse('0.05rem'), equals(RemUnit(0.05)));
    expect(TwUnit.parse('0.1rem'), equals(RemUnit(0.1)));
  });

  test('TwUnit.parse() parses successfully for "em" units', () {
    expect(TwUnit.parse('-0.05em'), equals(EmUnit(-0.05)));
    expect(TwUnit.parse('-0.025em'), equals(EmUnit(-0.025)));
    expect(TwUnit.parse('0em'), equals(EmUnit(0)));
    expect(TwUnit.parse('0.025em'), equals(EmUnit(0.025)));
    expect(TwUnit.parse('0.05em'), equals(EmUnit(0.05)));
    expect(TwUnit.parse('0.1em'), equals(EmUnit(0.1)));
  });
}
