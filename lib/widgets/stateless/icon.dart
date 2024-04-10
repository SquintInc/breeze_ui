import 'package:breeze_ui/base.dart';
import 'package:breeze_ui/widgets/inherited/parent_constraints_data.dart';
import 'package:breeze_ui/widgets/stateless/constraints.dart';
import 'package:breeze_ui/widgets/stateless/div.dart';
import 'package:breeze_ui/widgets/stateless/stateless_widget.dart';
import 'package:breeze_ui/widgets/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Sealed class representing the icon data using either an [IconData] or svg [BytesLoader].
@immutable
sealed class TwIconData {}

/// Icon data using an [IconData] font glyph.
@immutable
class IconDataFont implements TwIconData {
  final IconData iconData;

  const IconDataFont(this.iconData);
}

/// Icon data using an svg [BytesLoader].
/// Prefer using [AssetBytesLoader] with svg assets that have been pre-compiled to a *.vec
/// file via [flutter_svg](https://pub.dev/packages/flutter_svg#precompiling-and-optimizing-svgs).
@immutable
class IconDataSvg implements TwIconData {
  final BytesLoader svg;

  const IconDataSvg(this.svg);
}

/// A widget representing an [Icon] or [SvgPicture] with support for Tailwind styled properties.
/// The icon is rendered as a child of a [TwDiv] widget for full styling support (meaning relative
/// percent based sizing constraints will work).
///
/// If a [style] is not provided, the [defaultIconStyle] will be used: a black icon with width and
/// height of 24.0 pixels. Set [preserveIconColors] to true to preserve the original colors of the
/// icon / SVG.
@immutable
class TwIcon extends TwStatelessWidget {
  static const double defaultWidthPx = 24.0;
  static const double defaultHeightPx = 24.0;
  static const Color defaultIconColor = Colors.black;
  static const TwStyle defaultIconStyle = TwStyle(
    width: TwWidth(PxUnit(defaultWidthPx)),
    height: TwHeight(PxUnit(defaultHeightPx)),
  );
  static const BoxConstraints defaultConstraints =
      BoxConstraints.tightForFinite(
    width: defaultWidthPx,
    height: defaultHeightPx,
  );

  /// The icon data to use for display. Can be either an [IconData] or svg [BytesLoader].
  final TwIconData icon;

  /// The alignment of the icon within the [TwDiv] widget. Defaults to [Alignment.center].
  final Alignment? alignment;

  /// Whether the icon should expand to fill the available space. This is accomplished by wrapping
  /// the icon in a [ConstrainedBox].
  /// Defaults to true.
  final bool expand;

  /// Whether the icon should preserve its original colors. For example, this is useful for SVGs
  /// of logos with multiple colors.
  ///
  /// Defaults to false and will use [defaultIconColor] if not enabled.
  final bool preserveIconColors;

  const TwIcon({
    required this.icon,
    this.alignment,
    this.expand = true,
    this.preserveIconColors = false,
    super.style = defaultIconStyle,
    super.staticConstraints,
    super.alwaysIncludeFilters,
    super.key,
  });

  Widget buildIcon(
    final BuildContext context,
    final BoxConstraints? constraints,
    final BoxConstraints? staticBoxConstraints,
  ) {
    final Widget iconWidget = switch (icon) {
      IconDataSvg(svg: final svg) => FittedBox(
          fit: BoxFit.contain,
          child: SvgPicture(
            svg,
            colorFilter: preserveIconColors
                ? null
                : ColorFilter.mode(
                    style.textColor?.color ?? defaultIconColor,
                    BlendMode.srcIn,
                  ),
          ),
        ),
      IconDataFont(iconData: final iconData) => FittedBox(
          fit: BoxFit.contain,
          child: Icon(
            iconData,
            color: preserveIconColors
                ? null
                : (style.textColor?.color ?? defaultIconColor),
          ),
        ),
    };

    return TwDiv(
      style: style,
      staticConstraints: staticConstraints,
      parentControlsOpacity: true,
      alignment: alignment ?? Alignment.center,
      alwaysIncludeFilters: alwaysIncludeFilters,
      child: expand
          ? ConstrainedBox(
              constraints: constraints ?? defaultConstraints,
              child: iconWidget,
            )
          : iconWidget,
    );
  }

  @override
  Widget build(final BuildContext context) {
    final ParentConstraintsData? parentConstraintsData =
        ParentConstraintsData.of(context);

    final styleConstraints = staticConstraints ?? style.toConstraints();
    if (parentConstraintsData != null) {
      final constraints = computeRelativeConstraints(
        context,
        parentConstraintsData.constraints,
        styleConstraints,
      );
      final staticBoxConstraints = staticConstraints != null
          ? computeRelativeConstraints(
              context,
              parentConstraintsData.constraints,
              staticConstraints!,
            )
          : null;
      return buildIcon(context, constraints, staticBoxConstraints);
    }

    final simpleConstraints =
        tightenAbsoluteConstraints(style.toConstraints(), style.fontSizePx);
    final staticBoxConstraints = staticConstraints != null
        ? tightenAbsoluteConstraints(staticConstraints!, style.fontSizePx)
        : null;
    return buildIcon(
      context,
      simpleConstraints,
      staticBoxConstraints,
    );
  }
}
