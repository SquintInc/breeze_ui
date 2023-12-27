import 'package:meta/meta.dart';

enum TransitionProperty {
  none,
  all,
  textColor,
  backgroundColor,
  borderColor,
  textDecorationColor,
  fill,
  stroke,
  opacity,
  boxShadow,
  transform,
  filter,
  backdropFilter,

  // typography settings
  fontWeight,
  fontSize,
  lineHeight,
  textDecorationThickness,
  letterSpacing,
  wordSpacing,

  // other common CSS properties not set by Tailwind defaults
  borderWidth,
  width,
  height,
  borderRadius,
  border;

  static TransitionProperty fromCss(final String cssType) {
    return switch (cssType) {
      'all' => TransitionProperty.all,
      'color' => TransitionProperty.textColor,
      'background-color' => TransitionProperty.backgroundColor,
      'border-color' => TransitionProperty.borderColor,
      'text-decoration-color' => TransitionProperty.textDecorationColor,
      'fill' => TransitionProperty.fill,
      'stroke' => TransitionProperty.stroke,
      'opacity' => TransitionProperty.opacity,
      'box-shadow' => TransitionProperty.boxShadow,
      'transform' => TransitionProperty.transform,
      'filter' => TransitionProperty.filter,
      'backdrop-filter' => TransitionProperty.backdropFilter,
      'width' => TransitionProperty.width,
      'height' => TransitionProperty.height,
      'border-radius' => TransitionProperty.borderRadius,
      'border-width' => TransitionProperty.borderWidth,
      'border' => TransitionProperty.border,
      'font-weight' => TransitionProperty.fontWeight,
      'font-size' => TransitionProperty.fontSize,
      'line-height' => TransitionProperty.lineHeight,
      'text-decoration-thickness' => TransitionProperty.textDecorationThickness,
      'letter-spacing' => TransitionProperty.letterSpacing,
      'word-spacing' => TransitionProperty.wordSpacing,
      _ => TransitionProperty.none,
    };
  }

  bool get isBorderProperty =>
      this == TransitionProperty.border ||
      this == TransitionProperty.borderWidth ||
      this == TransitionProperty.borderColor ||
      this == TransitionProperty.borderRadius;
}

@immutable
class TwTransitionProperty {
  const TwTransitionProperty.none() : properties = const {};

  final Set<TransitionProperty> properties;

  const TwTransitionProperty(this.properties);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      other is TwTransitionProperty &&
          runtimeType == other.runtimeType &&
          properties == other.properties;

  @override
  int get hashCode => properties.hashCode;

  bool get isNone => properties.contains(TransitionProperty.none);

  @override
  String toString() {
    if (isNone) {
      return 'TwTransitionProperty{none}';
    }
    if (properties.contains(TransitionProperty.all)) {
      return 'TwTransitionProperty{all}';
    }
    return 'TwTransitionProperty{properties: $properties}';
  }
}
