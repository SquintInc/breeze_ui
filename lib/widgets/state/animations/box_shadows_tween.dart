import 'package:flutter/material.dart';

class BoxShadowsTween extends Tween<List<BoxShadow>> {
  BoxShadowsTween({super.begin, super.end});

  @override
  List<BoxShadow> lerp(final double t) => BoxShadow.lerpList(begin, end, t)!;
}
