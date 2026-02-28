import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE2E8F0), Color(0xFFF1F5F9), Color(0xFFF8FAFC)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const _AboutHeader(),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const _AppHeaderCard(),
                      const SizedBox(height: 20),
                      _DeveloperProfile(launchUrl: _launchUrl),
                      const SizedBox(height: 20),
                      const _FeaturesSection(),
                      const SizedBox(height: 20),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.95,
                        children: [
                          _BentoCard(
                            icon: LucideIcons.globe,
                            title: 'Website',
                            subtitle: 'mdsahil.me',
                            bgColor: const Color(
                              0xFFCBECE8,
                            ).withValues(alpha: 0.7),
                            onTap: () => _launchUrl('https://mdsahil.me'),
                          ),
                          _BentoCard(
                            icon: LucideIcons.github,
                            title: 'GitHub',
                            subtitle: '@mdsahilnoob',
                            bgColor: const Color(
                              0xFFFBE4C7,
                            ).withValues(alpha: 0.7),
                            onTap: () =>
                                _launchUrl('https://github.com/mdsahilnoob'),
                          ),
                          _BentoCard(
                            icon: LucideIcons.heart,
                            title: 'Donate',
                            subtitle: 'Support us',
                            bgColor: const Color(
                              0xFFFDE4EC,
                            ).withValues(alpha: 0.7),
                            onTap: () {},
                          ),
                          _BentoCard(
                            icon: LucideIcons.mail,
                            title: 'Contact',
                            subtitle: 'Get in touch',
                            bgColor: const Color(
                              0xFFD4EFEF,
                            ).withValues(alpha: 0.7),
                            onTap: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const _TechStackCard(),
                      const SizedBox(height: 48),
                      const Text(
                        'Made with ❤️ for students',
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 140,
                      ), // Extra padding for floating navbar
                    ],
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

class _AboutHeader extends StatelessWidget {
  const _AboutHeader();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 48, 28, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About App',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: const Color(0xFF1E212B),
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Learn more about your companion',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black45,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppHeaderCard extends StatelessWidget {
  const _AppHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2DD4BF).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.graduationCap,
              size: 48,
              color: Color(0xFF2DD4BF),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'University Timetable',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E212B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF1E212B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'v1.0.0',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeveloperProfile extends StatelessWidget {
  final Future<void> Function(String) launchUrl;

  const _DeveloperProfile({required this.launchUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/logo2.png'),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mohammad Sahil',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E212B),
                  ),
                ),
                Text(
                  'Designer & Developer',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E212B).withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _SocialIcon(
                      icon: LucideIcons.globe,
                      onTap: () => launchUrl('https://mdsahil.me'),
                    ),
                    const SizedBox(width: 12),
                    _SocialIcon(
                      icon: LucideIcons.github,
                      onTap: () => launchUrl('https://github.com/mdsahilnoob'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color(0xFF1E212B).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF1E212B)),
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'App Features',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Color(0xFF1E212B),
            ),
          ),
          SizedBox(height: 16),
          _FeatureItem(
            icon: LucideIcons.calendar,
            title: 'Smart Timetable',
            desc: 'Organize your classes with ease.',
          ),
          SizedBox(height: 12),
          _FeatureItem(
            icon: LucideIcons.stickyNote,
            title: 'Quick Notes',
            desc: 'Capture thoughts with our new editor.',
          ),
          SizedBox(height: 12),
          _FeatureItem(
            icon: LucideIcons.layout,
            title: 'Bento UI',
            desc: 'Modern design inspired by Nothing OS.',
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF2DD4BF)),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            Text(
              desc,
              style: const TextStyle(fontSize: 11, color: Colors.black45),
            ),
          ],
        ),
      ],
    );
  }
}

class _BentoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color bgColor;
  final VoidCallback onTap;

  const _BentoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: const Color(0xFF1E212B)),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: Color(0xFF1E212B),
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E212B).withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechStackCard extends StatelessWidget {
  const _TechStackCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Built With',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Color(0xFF1E212B),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _TechChip(label: 'Flutter'),
              _TechChip(label: 'Dart'),
              _TechChip(label: 'Isar DB'),
              _TechChip(label: 'Glassmorphism'),
              _TechChip(label: 'Bento Design'),
              _TechChip(label: 'Lucide Icons'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }
}
