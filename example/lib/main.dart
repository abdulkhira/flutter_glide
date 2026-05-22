import 'package:flutter/material.dart';
import 'package:flutter_glide/flutter_glide.dart';

void main() => runApp(const FlutterGlideExampleApp());

class FlutterGlideExampleApp extends StatelessWidget {
  const FlutterGlideExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_glide Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  static const _portrait =
      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=400';
  static const _landscape =
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800';
  static const _broken = 'https://broken.url/image.jpg';

  static const _gridUrls = [
    'https://images.unsplash.com/photo-1682685797828-d3b2561291d5?w=300',
    'https://images.unsplash.com/photo-1682686581030-7fa4ea2b96c3?w=300',
    'https://images.unsplash.com/photo-1682695796954-bad0d0f59ff1?w=300',
    'https://images.unsplash.com/photo-1682695797221-8164ff1fafc9?w=300',
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=300',
    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('flutter_glide Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. Network image (cached + shimmer) ──────────────────────
            _section('1. GlideImage — Network (cached + shimmer)'),
            const GlideImage(
              _portrait,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // ── 2. Rounded corners ───────────────────────────────────────
            _section('2. GlideImage — Rounded corners'),
            GlideImage(
              _landscape,
              width: double.infinity,
              height: 180,
              borderRadius: BorderRadius.circular(16),
            ),
            const SizedBox(height: 20),

            // ── 3. Colour tint ───────────────────────────────────────────
            _section('3. GlideImage — Colour tint (multiply)'),
            GlideImage(
              _landscape,
              width: double.infinity,
              height: 160,
              borderRadius: BorderRadius.circular(12),
              color: Colors.teal.withValues(alpha: 0.45),
              colorBlendMode: BlendMode.multiply,
            ),
            const SizedBox(height: 20),

            // ── 4. Tappable image ────────────────────────────────────────
            _section('4. GlideImage — Tappable'),
            GlideImage(
              _portrait,
              width: double.infinity,
              height: 140,
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Image tapped!')));
              },
            ),
            const SizedBox(height: 20),

            // ── 5. Broken URL (error fallback) ───────────────────────────
            _section('5. GlideImage — Broken URL (error fallback)'),
            GlideImage(
              _broken,
              width: double.infinity,
              height: 100,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(height: 20),

            // ── 6. SwiftImageBanner (16:9) ───────────────────────────────
            _section('6. GlideBanner — 16:9 with gradient + caption'),
            GlideBanner(
              imageUrl: _landscape,
              aspectRatio: 16 / 9,
              borderRadius: BorderRadius.circular(14),
              overlayGradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54],
              ),
              caption: 'Mountain sunrise, Swiss Alps',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Banner tapped!')));
              },
            ),
            const SizedBox(height: 20),

            // ── 7. GlideBanner (21:9 cinematic) ────────────────────
            _section('7. GlideBanner — 21:9 cinematic, no caption'),
            GlideBanner(
              imageUrl: _landscape,
              aspectRatio: 21 / 9,
              borderRadius: BorderRadius.circular(14),
            ),
            const SizedBox(height: 20),

            // ── 8. GlideGrid ───────────────────────────────────────────
            _section('8. GlideGrid — 3-column square grid'),
            GlideGrid(
              imageUrls: _gridUrls,
              crossAxisCount: 3,
              spacing: 4,
              borderRadius: BorderRadius.circular(8),
              onTap: (i) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Grid item $i tapped')));
              },
            ),
            const SizedBox(height: 20),

            // ── 9. GlideGrid — 2-column landscape ──────────────────────
            _section('9. GlideGrid — 2-column landscape (4:3)'),
            GlideGrid(
              imageUrls: _gridUrls.take(4).toList(),
              crossAxisCount: 2,
              spacing: 6,
              childAspectRatio: 4 / 3,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 20),

            // ── 10. GlideCircle — Network avatars ───────────────────────
            _section('10. GlideCircle — Network avatars'),
            Row(
              spacing: 16,
              children: [
                const GlideCircle(
                  imageUrl: _portrait,
                  radius: 40,
                  name: 'Siddharth Rathod',
                ),
                const GlideCircle(
                  imageUrl: _portrait,
                  radius: 32,
                  name: 'Ali Murtaza',
                  borderWidth: 2,
                  borderColor: Colors.teal,
                ),
                GlideCircle(
                  imageUrl: _portrait,
                  radius: 36,
                  name: 'Sam Lee',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Avatar tapped!')));
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── 11. GlideCircle — Initials fallback ─────────────────────
            _section('11. GlideCircle — Initials fallback'),
            const Row(
              spacing: 12,
              children: [
                GlideCircle(
                  imageUrl: '',
                  radius: 36,
                  name: 'Siddharth Rathod',
                  initialsBackgroundColor: Color(0xFFD6E9F5),
                  initialsTextColor: Color(0xFF05678D),
                ),
                GlideCircle(
                  imageUrl: '',
                  radius: 36,
                  name: 'Ali Murtaza',
                  initialsBackgroundColor: Color(0xFFE8F5E9),
                  initialsTextColor: Colors.green,
                ),
                GlideCircle(
                  imageUrl: '',
                  radius: 36,
                  name: 'Zara',
                  initialsBackgroundColor: Color(0xFFFCE4EC),
                  initialsTextColor: Colors.pink,
                ),
                GlideCircle(
                  imageUrl: _broken,
                  radius: 36,
                  name: 'John Doe',
                  initialsBackgroundColor: Color(0xFFF3E5F5),
                  initialsTextColor: Colors.deepPurple,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── 12. Standalone widgets ───────────────────────────────────
            _section('12. InitialsAvatar + ShimmerPlaceholder (standalone)'),
            const Row(
              spacing: 12,
              children: [
                InitialsAvatar(
                  name: 'John Doe',
                  size: 64,
                  backgroundColor: Colors.blueGrey,
                  textColor: Colors.white,
                ),
                ShimmerPlaceholder(width: 120, height: 64),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
      );
}
