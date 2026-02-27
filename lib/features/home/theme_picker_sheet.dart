import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/brand_theme_provider.dart';
import '../../core/theme/app_brand_theme.dart';

/// Bottom sheet that lets the user pick between the three brand UI themes.
///
/// Open it with:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   builder: (_) => const ThemePickerSheet(),
/// );
/// ```
class ThemePickerSheet extends ConsumerWidget {
  const ThemePickerSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(brandThemeProvider);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────
            Row(
              children: [
                Text('THEME STORE', style: textTheme.titleSmall),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Switch brand UI at runtime. Fonts download once and are cached.',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 20),

            // ── Theme cards ───────────────────────────────────────────────
            ...AppBrandTheme.values.map((brand) {
              final isActive = brand == current;
              return _ThemeCard(
                brand: brand,
                isActive: isActive,
                onTap: () {
                  ref.read(brandThemeProvider.notifier).setTheme(brand);
                  Navigator.of(context).pop();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ── Individual brand card ─────────────────────────────────────────────────────

class _ThemeCard extends StatelessWidget {
  const _ThemeCard({
    required this.brand,
    required this.isActive,
    required this.onTap,
  });

  final AppBrandTheme brand;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: brand.previewBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive
                  ? brand.accentColor
                  : brand.accentColor.withAlpha(50),
              width: isActive ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // ── Colour swatch ──────────────────────────────────────────
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: brand.accentColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    bottomLeft: Radius.circular(11),
                  ),
                ),
                child: Icon(
                  _iconForBrand(brand),
                  color: brand.previewForeground.withAlpha(230),
                  size: 28,
                ),
              ),

              // ── Text ───────────────────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        brand.displayName,
                        style: TextStyle(
                          color: brand.previewForeground,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        brand.description,
                        style: TextStyle(
                          color: brand.previewForeground.withAlpha(160),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Active badge ───────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: isActive
                    ? Icon(
                        Icons.check_circle,
                        color: brand.accentColor,
                        size: 22,
                      )
                    : Icon(
                        Icons.radio_button_unchecked,
                        color: brand.accentColor.withAlpha(100),
                        size: 22,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _iconForBrand(AppBrandTheme brand) => switch (brand) {
    AppBrandTheme.nothing => Icons.circle_outlined,
    AppBrandTheme.onePlus => Icons.add_circle_outline,
    AppBrandTheme.iOS => Icons.phone_iphone,
  };
}
