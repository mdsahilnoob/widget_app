import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/providers/widget_data_provider.dart';
import 'theme_picker_sheet.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController _titleCtrl;
  late final TextEditingController _subtitleCtrl;

  bool _controllersSeeded = false;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController();
    _subtitleCtrl = TextEditingController();

    ref.listenManual<AsyncValue<WidgetData>>(widgetDataProvider, (_, next) {
      if (!_controllersSeeded) {
        final data = next.value;
        if (data != null) {
          _controllersSeeded = true;
          _titleCtrl.text = data.title;
          _subtitleCtrl.text = data.subtitle;
        }
      }
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _subtitleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final widgetAsync = ref.watch(widgetDataProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppConstants.appName.toUpperCase(),
          style: textTheme.titleSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Theme store',
            onPressed: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (_) => const ThemePickerSheet(),
            ),
          ),

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
          Text('GOOD MORNING.', style: textTheme.displayMedium),
          const SizedBox(height: AppConstants.spaceSM),
          Text('Here\'s your widget dashboard.', style: textTheme.bodyMedium),
          const SizedBox(height: AppConstants.spaceLG),

          Text('WIDGET BRIDGE', style: textTheme.titleSmall),
          const SizedBox(height: AppConstants.spaceMD),
          widgetAsync.when(
            loading: () => const _BridgeLoadingSkeleton(),
            error: (e, _) => _BridgeError(message: e.toString()),
            data: (data) => _BridgePanel(
              data: data,
              titleCtrl: _titleCtrl,
              subtitleCtrl: _subtitleCtrl,
              onTitleSubmit: () {
                final t = _titleCtrl.text.trim();
                if (t.isNotEmpty) {
                  ref.read(widgetDataProvider.notifier).updateTitle(t);
                  FocusScope.of(context).unfocus();
                }
              },
              onSubtitleSubmit: () {
                final s = _subtitleCtrl.text.trim();
                if (s.isNotEmpty) {
                  ref.read(widgetDataProvider.notifier).updateSubtitle(s);
                  FocusScope.of(context).unfocus();
                }
              },
              onIncrement: () =>
                  ref.read(widgetDataProvider.notifier).incrementCounter(),
              onDecrement: () =>
                  ref.read(widgetDataProvider.notifier).decrementCounter(),
              onReset: () =>
                  ref.read(widgetDataProvider.notifier).resetCounter(),
            ),
          ),
          const SizedBox(height: AppConstants.spaceLG),

          _StatusCard(
            label: 'LAYOUT',
            value: settings.widgetLayout == WidgetLayout.grid ? 'GRID' : 'LIST',
            icon: settings.widgetLayout == WidgetLayout.grid
                ? Icons.grid_view_rounded
                : Icons.view_list_rounded,
          ),
          const SizedBox(height: AppConstants.spaceLG),

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
              if (v) ref.read(settingsProvider.notifier).completeOnboarding();
            },
          ),
        ],
      ),
    );
  }
}

class _BridgePanel extends StatelessWidget {
  const _BridgePanel({
    required this.data,
    required this.titleCtrl,
    required this.subtitleCtrl,
    required this.onTitleSubmit,
    required this.onSubtitleSubmit,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
  });

  final WidgetData data;
  final TextEditingController titleCtrl;
  final TextEditingController subtitleCtrl;
  final VoidCallback onTitleSubmit;
  final VoidCallback onSubtitleSubmit;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(color: cs.outline, width: AppConstants.borderNormal),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SyncStatusBar(isSyncing: data.isSyncing, error: data.lastError),

          Padding(
            padding: const EdgeInsets.all(AppConstants.spaceMD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('WIDGET TITLE', style: textTheme.labelSmall),
                const SizedBox(height: AppConstants.spaceSM),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: titleCtrl,
                        style: textTheme.bodyLarge,
                        decoration: const InputDecoration(
                          hintText: 'e.g. WIDGET APP',
                        ),
                        textCapitalization: TextCapitalization.characters,
                        onSubmitted: (_) => onTitleSubmit(),
                      ),
                    ),
                    const SizedBox(width: AppConstants.spaceSM),
                    _PushButton(label: 'PUSH', onTap: onTitleSubmit),
                  ],
                ),

                const SizedBox(height: AppConstants.spaceMD),

                Text('WIDGET SUBTITLE', style: textTheme.labelSmall),
                const SizedBox(height: AppConstants.spaceSM),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: subtitleCtrl,
                        style: textTheme.bodyLarge,
                        decoration: const InputDecoration(
                          hintText: 'e.g. Nothing OS',
                        ),
                        onSubmitted: (_) => onSubtitleSubmit(),
                      ),
                    ),
                    const SizedBox(width: AppConstants.spaceSM),
                    _PushButton(label: 'PUSH', onTap: onSubtitleSubmit),
                  ],
                ),

                const SizedBox(height: AppConstants.spaceMD),
                const Divider(),
                const SizedBox(height: AppConstants.spaceMD),

                Text('COUNTER', style: textTheme.labelSmall),
                const SizedBox(height: AppConstants.spaceSM),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CounterButton(icon: Icons.remove, onTap: onDecrement),

                    Text(
                      data.counter.toString().padLeft(2, '0'),
                      style: textTheme.headlineLarge,
                    ),

                    _CounterButton(icon: Icons.add, onTap: onIncrement),
                  ],
                ),
                const SizedBox(height: AppConstants.spaceSM),
                Center(
                  child: TextButton(
                    onPressed: onReset,
                    child: Text(
                      'RESET',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppConstants.whiteSubtle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SyncStatusBar extends StatelessWidget {
  const _SyncStatusBar({required this.isSyncing, this.error});
  final bool isSyncing;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final hasError = error != null;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMD,
        vertical: AppConstants.spaceXS,
      ),
      decoration: BoxDecoration(
        color: hasError
            ? Theme.of(context).colorScheme.error.withValues(alpha: 0.12)
            : Theme.of(context).colorScheme.outline,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusMD),
        ),
      ),
      child: Row(
        children: [
          if (isSyncing)
            const SizedBox(
              width: 10,
              height: 10,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppConstants.white,
              ),
            )
          else
            Icon(
              hasError ? Icons.error_outline : Icons.check_circle_outline,
              size: 10,
              color: hasError
                  ? Theme.of(context).colorScheme.error
                  : AppConstants.whiteSubtle,
            ),
          const SizedBox(width: AppConstants.spaceSM),
          Expanded(
            child: Text(
              isSyncing
                  ? 'SYNCING…'
                  : hasError
                  ? 'ERROR: $error'
                  : 'SYNCED WITH HOME SCREEN',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: hasError
                    ? AppConstants.accentRed
                    : AppConstants.whiteSubtle,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _PushButton extends StatelessWidget {
  const _PushButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spaceMD,
          vertical: AppConstants.spaceMD - 2,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: AppConstants.borderNormal,
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
        child: Text(label, style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: AppConstants.borderNormal,
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusSM),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
          size: 20,
        ),
      ),
    );
  }
}

class _BridgeLoadingSkeleton extends StatelessWidget {
  const _BridgeLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      alignment: Alignment.center,
      child: const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}

class _BridgeError extends StatelessWidget {
  const _BridgeError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMD),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(color: Theme.of(context).colorScheme.error),
      ),
      child: Text(
        'Widget bridge error:\n$message',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}

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
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: AppConstants.borderNormal,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onSurface, size: 20),
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
