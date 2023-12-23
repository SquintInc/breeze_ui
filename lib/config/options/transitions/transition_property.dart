import 'package:meta/meta.dart';

enum TransitionProperty {
  none,
  all,

  /// This usually refers to text color
  color,
  backgroundColor,
  borderColor,
  textDecorationColor,
  fill,
  stroke,
  opacity,
  boxShadow,
  transform,
  filter,
  backdropFilter;

  static TransitionProperty fromCss(final String cssType) {
    return switch (cssType) {
      'all' => TransitionProperty.all,
      'color' => TransitionProperty.color,
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
      _ => TransitionProperty.none,
    };
  }
}

@immutable
class TwTransitionProperty {
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
}
