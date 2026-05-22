import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'image_source.dart';
import 'initials_avatar.dart';
import 'shimmer_placeholder.dart';

/// A circular avatar widget that automatically handles network, asset, SVG,
/// and file images — with shimmer loading and an **initials fallback**.
///
/// Inspired by Glide/Picasso circular transformations.
///
/// ```dart
/// SwiftImageCircle(
///   imageUrl: 'https://example.com/avatar.jpg',
///   radius: 32,
///   name: 'Siddharth Rathod',
/// )
/// ```
class SwiftImageCircle extends StatelessWidget {
  /// The image source — HTTP URL, asset path, SVG asset path, or file path.
  /// Pass an empty string to show the initials fallback immediately.
  final String imageUrl;

  /// Radius of the circle (diameter = `radius * 2`).
  final double radius;

  /// Name used to generate initials when the image is unavailable.
  final String name;

  /// Border width around the circle.
  final double borderWidth;

  /// Border colour around the circle.
  final Color borderColor;

  /// Background colour shown behind the initials.
  final Color initialsBackgroundColor;

  /// Text colour for the initials.
  final Color initialsTextColor;

  /// Shimmer base colour (default placeholder).
  final Color shimmerBaseColor;

  /// Shimmer highlight colour (default placeholder).
  final Color shimmerHighlightColor;

  /// Extra HTTP headers forwarded to [CachedNetworkImage].
  final Map<String, String>? httpHeaders;

  /// Custom widget shown on load error (overrides initials fallback).
  final Widget? errorWidget;

  /// Callback fired when the avatar is tapped.
  final VoidCallback? onTap;

  const SwiftImageCircle({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.name = '',
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.initialsBackgroundColor = const Color(0xFFD9D9D9),
    this.initialsTextColor = const Color(0xFF555555),
    this.shimmerBaseColor = const Color(0xFFE0E0E0),
    this.shimmerHighlightColor = const Color(0xFFF5F5F5),
    this.httpHeaders,
    this.errorWidget,
    this.onTap,
  });

  double get _diameter => radius * 2;

  Widget _initialsWidget() => InitialsAvatar(
        name: name,
        size: _diameter,
        backgroundColor: initialsBackgroundColor,
        textColor: initialsTextColor,
      );

  Widget _shimmer() => ShimmerPlaceholder(
        width: _diameter,
        height: _diameter,
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
      );

  Widget _buildImageChild() {
    final source = resolveImageSource(imageUrl);

    switch (source) {
      case ImageSource.network:
        return CachedNetworkImage(
          imageUrl: imageUrl,
          width: _diameter,
          height: _diameter,
          fit: BoxFit.cover,
          httpHeaders: httpHeaders,
          placeholder: (_, __) => _shimmer(),
          errorWidget: (_, __, ___) => errorWidget ?? _initialsWidget(),
        );

      case ImageSource.assetSvg:
        return SvgPicture.asset(
          imageUrl,
          width: _diameter,
          height: _diameter,
          fit: BoxFit.cover,
        );

      case ImageSource.asset:
        return Image.asset(
          imageUrl,
          width: _diameter,
          height: _diameter,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => errorWidget ?? _initialsWidget(),
        );

      case ImageSource.file:
        final filePath = imageUrl.startsWith('file://')
            ? Uri.parse(imageUrl).toFilePath()
            : imageUrl;
        return Image.file(
          File(filePath),
          width: _diameter,
          height: _diameter,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => errorWidget ?? _initialsWidget(),
        );

      case ImageSource.unknown:
        return errorWidget ?? _initialsWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showInitials = imageUrl.trim().isEmpty;

    final Widget imageClip = ClipOval(
      child: SizedBox(
        width: _diameter,
        height: _diameter,
        child: showInitials ? _initialsWidget() : _buildImageChild(),
      ),
    );

    Widget circle = borderWidth > 0
        ? Container(
            width: _diameter + borderWidth * 2,
            height: _diameter + borderWidth * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: borderWidth),
            ),
            child: Center(child: imageClip),
          )
        : imageClip;

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: circle);
    }
    return circle;
  }
}
