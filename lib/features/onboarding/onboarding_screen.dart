import 'package:flutter/material.dart';
import '../navigation/app_navigation.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD4EFEF), // Soft cyan/teal top
              Color(0xFFF0FDF4), // Almost white
            ],
            stops: [0.0, 0.6],
          ),
        ),
        child: SafeArea(
          bottom: false, // Allow bottom to bleed
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40.0,
                                vertical: 40.0,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // A stylized stack of books representation
                                  Container(
                                    width: constraints.maxWidth * 0.5,
                                    height: constraints.maxWidth * 0.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF63B3B8),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(
                                            0xFF63B3B8,
                                          ).withValues(alpha: 0.4),
                                          blurRadius: 20,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Icon(
                                        LucideIcons.bookOpen,
                                        size: constraints.maxWidth * 0.2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              top: 40.0,
                              left: 32.0,
                              right: 32.0,
                              bottom:
                                  MediaQuery.of(context).padding.bottom + 32.0,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Welcome to a New\nWay of Learning',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF1E212B),
                                            height: 1.2,
                                          ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Learn what you love, at your own pace. Explore courses, spark your curiosity, and unlock knowledge anytime, anywhere.',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.grey.shade600,
                                            height: 1.5,
                                          ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(
                                        0xFF2DD4BF,
                                      ).withValues(alpha: 0.3),
                                      width: 2,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AppNavigation(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2DD4BF),
                                      foregroundColor: Colors.white,
                                      shape: const CircleBorder(),
                                      padding: EdgeInsets.zero,
                                      elevation: 0,
                                    ),
                                    child: const Icon(
                                      LucideIcons.arrowUpRight,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
