import 'package:flutter/material.dart';

/// Renders a coloured box/circle with up to two initials extracted from [name].
///
/// Used as the fallback when no image is available or loading fails.
class InitialsAvatar extends StatelessWidget {
  final String name;
  final double size;
  final Color backgroundColor;
  final Color textColor;
  final double? fontSize;

  const InitialsAvatar({
    super.key,
    required this.name,
    required this.size,
    this.backgroundColor = const Color(0xFFD9D9D9),
    this.textColor = const Color(0xFF555555),
    this.fontSize,
  });

  static String _initials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: backgroundColor,
      alignment: Alignment.center,
      child: Text(
        _initials(name),
        style: TextStyle(
          fontSize: fontSize ?? size * 0.38,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }
}
