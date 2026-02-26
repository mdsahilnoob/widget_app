import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/settings_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(
        title: Text(
          AppConstants.appName.toUpperCase(),
          style: textTheme.titleSmall,
        ),
        actions: [
          // Layout toggle
          IconButton(
            icon: Icon(
              settings.widgetLayout == WidgetLayout.grid
                  ? Icons.grid_view_rounded
                  : Icons.view_list_rounded,
            ),
            onPressed: () {
              final next = settings.widgetLayout == WidgetLayout.grid
                  ? WidgetLayout.list
                  : WidgetLayout.grid;
              ref.read(settingsProvider.notifier).setWidgetLayout(next);
            },
            tooltip: 'Toggle layout',
          ),
          const SizedBox(width: AppConstants.spaceSM),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spaceMD),
        children: [
          // ── Header ──────────────────────────────────────────────────────
          Text('GOOD MORNING.', style: textTheme.displayMedium),
          const SizedBox(height: AppConstants.spaceSM),
          Text('Here\'s your widget dashboard.', style: textTheme.bodyMedium),
          const SizedBox(height: AppConstants.spaceLG),

          // ── Status cards row ─────────────────────────────────────────────
          _StatusCard(
            label: 'WIDGETS',
            value: '12',
            icon: Icons.widgets_rounded,
          ),
          const SizedBox(height: AppConstants.spaceSM),
          _StatusCard(
            label: 'LAYOUT',
            value: settings.widgetLayout == WidgetLayout.grid ? 'GRID' : 'LIST',
            icon: settings.widgetLayout == WidgetLayout.grid
                ? Icons.grid_view_rounded
                : Icons.view_list_rounded,
          ),
          const SizedBox(height: AppConstants.spaceLG),

          // ── Settings section ──────────────────────────────────────────────
          Text('PREFERENCES', style: textTheme.titleSmall),
          const SizedBox(height: AppConstants.spaceSM),
          _SettingsTile(
            label: 'Dark Mode',
            subtitle: 'Nothing OS style pure black theme',
            value: settings.isDarkMode,
            onChanged: (v) =>
                ref.read(settingsProvider.notifier).setDarkMode(v),
          ),
          const Divider(),
          _SettingsTile(
            label: 'Onboarding',
            subtitle: settings.isOnboardingDone ? 'Completed' : 'Not completed',
            value: settings.isOnboardingDone,
            onChanged: (v) {
              if (v) {
                ref.read(settingsProvider.notifier).completeOnboarding();
              }
            },
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMD),
      decoration: BoxDecoration(
        color: AppConstants.surfaceDark,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(
          color: AppConstants.borderGrey,
          width: AppConstants.borderNormal,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppConstants.white, size: 20),
          const SizedBox(width: AppConstants.spaceMD),
          Expanded(child: Text(label, style: textTheme.labelLarge)),
          Text(value, style: textTheme.titleLarge),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }
}
