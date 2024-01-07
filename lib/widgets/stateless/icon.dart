import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tailwind_elements/base.dart';
import 'package:tailwind_elements/widgets/stateless/div.dart';
import 'package:tailwind_elements/widgets/stateless/stateless_widget.dart';
import 'package:tailwind_elements/widgets/style/style.dart';

/// Sealed class representing the icon data using either an [IconData] or svg [BytesLoader].
@immutable
sealed class TwIconData {
  static IconSvgData svg(final BytesLoader svg) => IconSvgData(svg);

  static IconFontData icon(final IconData iconData) => IconFontData(iconData);
}

/// Icon data using an [IconData].
@immutable
class IconFontData implements TwIconData {
  final IconData iconData;

  const IconFontData(this.iconData);
}

/// Icon data using an svg [BytesLoader].
@immutable
class IconSvgData implements TwIconData {
  final BytesLoader svg;

  const IconSvgData(this.svg);
}

/// A widget representing an [Icon] or [SvgPicture] with support for Tailwind styled properties.
/// The icon is rendered as a child of a [Div] widget for full styling support (meaning relative
/// percent based sizing constraints will work).
///
/// If a [style] is not provided, the [defaultIconStyle] will be used: a black icon with width and
/// height of 24.0 pixels.
@immutable
class TwIcon extends TwStatelessWidget {
  static const Color defaultIconColor = Colors.black;
  static const TwStyle defaultIconStyle = TwStyle(
    width: TwWidth(PxUnit(24.0)),
    height: TwHeight(PxUnit(24.0)),
    textColor: TwTextColor(defaultIconColor),
  );

  /// The icon data to use for display. Can be either an [IconData] or svg [BytesLoader].
  final TwIconData icon;

  const TwIcon({
    required this.icon,
    super.style = defaultIconStyle,
    super.staticConstraints,
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    final Widget iconWidget = switch (icon) {
      IconSvgData(svg: final svg) => SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SvgPicture(
              svg,
              colorFilter: ColorFilter.mode(
                style.textColor?.color ?? defaultIconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      IconFontData(iconData: final iconData) => SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Icon(
              iconData,
              color: style.textColor?.color ?? defaultIconColor,
            ),
          ),
        ),
    };

    return Div(
      style: style,
      staticConstraints: staticConstraints,
      child: iconWidget,
    );
  }
}
