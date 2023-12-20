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
    switch (cssType) {
      case 'all':
        return TransitionProperty.all;
      case 'color':
        return TransitionProperty.color;
      case 'background-color':
        return TransitionProperty.backgroundColor;
      case 'border-color':
        return TransitionProperty.borderColor;
      case 'text-decoration-color':
        return TransitionProperty.textDecorationColor;
      case 'fill':
        return TransitionProperty.fill;
      case 'stroke':
        return TransitionProperty.stroke;
      case 'opacity':
        return TransitionProperty.opacity;
      case 'box-shadow':
        return TransitionProperty.boxShadow;
      case 'transform':
        return TransitionProperty.transform;
      case 'filter':
        return TransitionProperty.filter;
      case 'backdrop-filter':
        return TransitionProperty.backdropFilter;
      default:
        return TransitionProperty.none;
    }
  }
}

@immutable
class TwTransitionProperty {
  final Set<TransitionProperty> properties;

  const TwTransitionProperty({
    this.properties = const {TransitionProperty.none},
  });
}
