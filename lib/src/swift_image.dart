import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'image_source.dart';
import 'shimmer_placeholder.dart';

/// A rectangular image widget that automatically handles:
///
/// - **Network** URLs — cached via `cached_network_image` + shimmer placeholder + error fallback
/// - **Asset** paths — `Image.asset` (PNG / JPG / GIF / WebP)
/// - **SVG assets** — `SvgPicture.asset`
/// - **File** paths — `Image.file` (local picked/captured images)
/// - **Fallback** — custom [errorWidget] or default broken-image icon
///
/// ```dart
/// // Network
/// SwiftImage('https://example.com/photo.jpg', width: 300, height: 200)
///
/// // Rounded corners
/// SwiftImage('https://example.com/photo.jpg',
///   width: 200, height: 150,
///   borderRadius: BorderRadius.circular(16))
///
/// // Tappable
/// SwiftImage('assets/images/banner.png',
///   width: double.infinity, height: 180,
///   onTap: () => print('tapped'))
/// ```
class SwiftImage extends StatelessWidget {
  /// The image source — HTTP URL, asset path, SVG asset path, or file path.
  final String imageUrl;

  final double? width;
  final double? height;
  final BoxFit fit;

  /// Rounds the corners of the image. Applies to all source types.
  final BorderRadius? borderRadius;

  /// Widget shown while a network image is loading.
  /// Defaults to [ShimmerPlaceholder].
  final Widget? placeholder;

  /// Widget shown when the image fails to load or the URL is empty.
  /// Defaults to a centred broken-image icon.
  final Widget? errorWidget;

  /// Shimmer base colour (used by the default placeholder).
  final Color shimmerBaseColor;

  /// Shimmer highlight colour (used by the default placeholder).
  final Color shimmerHighlightColor;

  /// Extra headers forwarded to [CachedNetworkImage].
  final Map<String, String>? httpHeaders;

  /// Colour tint applied over the image.
  final Color? color;

  /// Blend mode used when [color] is set. Defaults to [BlendMode.srcIn].
  final BlendMode colorBlendMode;

  /// Callback fired when the image is tapped.
  final VoidCallback? onTap;

  /// Hint to the cache for max pixel width (network images only).
  final int? maxCacheWidth;

  /// Hint to the cache for max pixel height (network images only).
  final int? maxCacheHeight;

  const SwiftImage(
    this.imageUrl, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.shimmerBaseColor = const Color(0xFFE0E0E0),
    this.shimmerHighlightColor = const Color(0xFFF5F5F5),
    this.httpHeaders,
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.onTap,
    this.maxCacheWidth,
    this.maxCacheHeight,
  });

  Widget _defaultError() => SizedBox(
        width: width,
        height: height,
        child: const Center(child: Icon(Icons.broken_image_outlined, color: Colors.grey)),
      );

  Widget _defaultPlaceholder() => ShimmerPlaceholder(
        width: width,
        height: height,
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
      );

  Widget _applyRadius(Widget child) {
    if (borderRadius == null) return child;
    return ClipRRect(borderRadius: borderRadius!, child: child);
  }

  Widget _applyTint(Widget child) {
    if (color == null) return child;
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color!, colorBlendMode),
      child: child,
    );
  }

  Widget _applyTap(Widget child) {
    if (onTap == null) return child;
    return GestureDetector(onTap: onTap, child: child);
  }

  Widget _buildImage() {
    final source = resolveImageSource(imageUrl);

    switch (source) {
      case ImageSource.network:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          httpHeaders: httpHeaders,
          memCacheWidth: maxCacheWidth,
          memCacheHeight: maxCacheHeight,
          placeholder: (_, __) => placeholder ?? _defaultPlaceholder(),
          errorWidget: (_, __, ___) => errorWidget ?? _defaultError(),
        );

      case ImageSource.assetSvg:
        return SvgPicture.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          colorFilter: color != null
              ? ColorFilter.mode(color!, colorBlendMode)
              : null,
        );

      case ImageSource.asset:
        return Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => errorWidget ?? _defaultError(),
        );

      case ImageSource.file:
        final filePath = imageUrl.startsWith('file://')
            ? Uri.parse(imageUrl).toFilePath()
            : imageUrl;
        return Image.file(
          File(filePath),
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => errorWidget ?? _defaultError(),
        );

      case ImageSource.unknown:
        return errorWidget ?? _defaultError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _applyTap(_applyRadius(_applyTint(_buildImage())));
  }
  // Layer order: image → tint (ColorFiltered) → clip (ClipRRect) → tap (GestureDetector)
  // Tint is inside the clip so it never bleeds outside rounded corners.
}
