import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4EFEF), Color(0xFFE4F5F4), Color(0xFFF0FDF4)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.8),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF2DD4BF,
                            ).withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            LucideIcons.graduationCap,
                            size: 64,
                            color: Color(0xFF2DD4BF),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'University\nTimetable',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E212B),
                                height: 1.2,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E212B),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Version 1.0',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'A modern, local-first learning companion built exclusively with Glassmorphism & Bento grids. Enjoy a beautiful pastel aesthetic designed for your daily routine.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildBentoCard(
                      icon: LucideIcons.globe,
                      title: 'Our Website',
                      bgColor: const Color(0xFFCBECE8).withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildBentoCard(
                      icon: LucideIcons.github,
                      title: 'Repository',
                      bgColor: const Color(0xFFFBE4C7).withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBentoCard({
    required IconData icon,
    required String title,
    required Color bgColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.6),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 24, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1E212B),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  shape: BoxShape.circle,
                ),
                child: Transform.rotate(
                  angle: -0.785,
                  child: const Icon(
                    LucideIcons.arrowRight,
                    size: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
