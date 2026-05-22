import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Default shimmer placeholder used while a network image is loading.
class ShimmerPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerPlaceholder({
    super.key,
    this.width,
    this.height,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        color: baseColor,
      ),
    );
  }
}
