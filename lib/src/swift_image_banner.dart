import 'package:flutter/material.dart';

import 'swift_image.dart';

/// A full-width hero/banner image with an optional overlay and caption.
///
/// Useful for article headers, product hero shots, or carousel items.
///
/// ```dart
/// SwiftImageBanner(
///   imageUrl: 'https://example.com/hero.jpg',
///   aspectRatio: 16 / 9,
///   caption: 'Mountain sunrise',
/// )
///
/// // With gradient overlay
/// SwiftImageBanner(
///   imageUrl: 'https://example.com/hero.jpg',
///   aspectRatio: 21 / 9,
///   overlayGradient: LinearGradient(
///     begin: Alignment.topCenter,
///     end: Alignment.bottomCenter,
///     colors: [Colors.transparent, Colors.black54],
///   ),
///   caption: 'Grand Canyon at dusk',
///   captionStyle: TextStyle(color: Colors.white, fontSize: 18),
/// )
/// ```
class SwiftImageBanner extends StatelessWidget {
  /// The image source — same resolution rules as [SwiftImage].
  final String imageUrl;

  /// Aspect ratio of the banner (width / height). Defaults to 16/9.
  final double aspectRatio;

  /// Optional gradient painted on top of the image.
  final Gradient? overlayGradient;

  /// Optional solid overlay colour (use if you don't need a gradient).
  final Color? overlayColor;

  /// Caption text shown at the bottom of the banner.
  final String? caption;

  /// Style for [caption]. Defaults to white bold text.
  final TextStyle? captionStyle;

  /// Padding around [caption].
  final EdgeInsets captionPadding;

  /// Rounds the corners of the banner.
  final BorderRadius? borderRadius;

  /// Callback fired when the banner is tapped.
  final VoidCallback? onTap;

  /// Custom placeholder shown while the image loads.
  final Widget? placeholder;

  /// Custom error widget shown when the image fails.
  final Widget? errorWidget;

  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

  const SwiftImageBanner({
    super.key,
    required this.imageUrl,
    this.aspectRatio = 16 / 9,
    this.overlayGradient,
    this.overlayColor,
    this.caption,
    this.captionStyle,
    this.captionPadding = const EdgeInsets.all(12),
    this.borderRadius,
    this.onTap,
    this.placeholder,
    this.errorWidget,
    this.shimmerBaseColor = const Color(0xFFE0E0E0),
    this.shimmerHighlightColor = const Color(0xFFF5F5F5),
  });

  @override
  Widget build(BuildContext context) {
    Widget banner = AspectRatio(
      aspectRatio: aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SwiftImage(
            imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: placeholder,
            errorWidget: errorWidget,
            shimmerBaseColor: shimmerBaseColor,
            shimmerHighlightColor: shimmerHighlightColor,
          ),
          if (overlayColor != null)
            ColoredBox(color: overlayColor!),
          if (overlayGradient != null)
            DecoratedBox(
              decoration: BoxDecoration(gradient: overlayGradient),
            ),
          if (caption != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: captionPadding,
                child: Text(
                  caption!,
                  style: captionStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        shadows: [Shadow(blurRadius: 4)],
                      ),
                ),
              ),
            ),
        ],
      ),
    );

    if (borderRadius != null) {
      banner = ClipRRect(borderRadius: borderRadius!, child: banner);
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: banner);
    }
    return banner;
  }
}
