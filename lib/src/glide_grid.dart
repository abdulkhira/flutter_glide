import 'package:flutter/material.dart';

import 'glide_image.dart';

/// A responsive image grid that renders a list of image URLs in a fixed-column
/// grid layout, with uniform spacing and optional tap callbacks.
///
/// ```dart
/// GlideGrid(
///   imageUrls: [
///     'https://example.com/a.jpg',
///     'https://example.com/b.jpg',
///     'https://example.com/c.jpg',
///   ],
///   crossAxisCount: 3,
///   spacing: 4,
/// )
///
/// // With tap handler
/// SwiftImageGrid(
///   imageUrls: urls,
///   crossAxisCount: 2,
///   borderRadius: BorderRadius.circular(8),
///   onTap: (index) => Navigator.push(...),
/// )
/// ```
class GlideGrid extends StatelessWidget {
  /// List of image URLs/paths. Supports the same sources as [SwiftImage].
  final List<String> imageUrls;

  /// Number of columns. Defaults to 3.
  final int crossAxisCount;

  /// Space between grid cells (both horizontal and vertical). Defaults to 2.
  final double spacing;

  /// Aspect ratio for each cell (width / height). Defaults to 1 (square).
  final double childAspectRatio;

  /// Rounds the corners of each cell.
  final BorderRadius? borderRadius;

  /// How the image fits its cell. Defaults to [BoxFit.cover].
  final BoxFit fit;

  /// Fired when a cell is tapped. The [int] parameter is the cell index.
  final void Function(int index)? onTap;

  /// Custom placeholder for each cell.
  final Widget? placeholder;

  /// Custom error widget for each cell.
  final Widget? errorWidget;

  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

  const GlideGrid({
    super.key,
    required this.imageUrls,
    this.crossAxisCount = 3,
    this.spacing = 2,
    this.childAspectRatio = 1,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.onTap,
    this.placeholder,
    this.errorWidget,
    this.shimmerBaseColor = const Color(0xFFE0E0E0),
    this.shimmerHighlightColor = const Color(0xFFF5F5F5),
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return GlideImage(
          imageUrls[index],
          fit: fit,
          borderRadius: borderRadius,
          placeholder: placeholder,
          errorWidget: errorWidget,
          shimmerBaseColor: shimmerBaseColor,
          shimmerHighlightColor: shimmerHighlightColor,
          onTap: onTap != null ? () => onTap!(index) : null,
        );
      },
    );
  }
}
