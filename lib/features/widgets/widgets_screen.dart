import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/settings_provider.dart';

class WidgetsScreen extends ConsumerWidget {
  const WidgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(settingsProvider.select((s) => s.widgetLayout));
    final textTheme = Theme.of(context).textTheme;

    // Placeholder widget data — replace with real models later.
    final widgets = List.generate(
      12,
      (i) => _WidgetItem(
        id: i,
        name: 'WIDGET ${(i + 1).toString().padLeft(2, '0')}',
        category: i.isEven ? 'SYSTEM' : 'MEDIA',
      ),
    );

    return Scaffold(
      backgroundColor: AppConstants.black,
      appBar: AppBar(title: Text('WIDGETS', style: textTheme.titleSmall)),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.spaceMD),
        child: layout == WidgetLayout.grid
            ? _GridLayout(widgets: widgets)
            : _ListLayout(widgets: widgets),
      ),
    );
  }
}

// ── Layout variants ───────────────────────────────────────────────────────────

class _GridLayout extends StatelessWidget {
  const _GridLayout({required this.widgets});
  final List<_WidgetItem> widgets;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppConstants.spaceSM,
        crossAxisSpacing: AppConstants.spaceSM,
        childAspectRatio: 1.0,
      ),
      itemCount: widgets.length,
      itemBuilder: (_, i) => _WidgetCard(item: widgets[i]),
    );
  }
}

class _ListLayout extends StatelessWidget {
  const _ListLayout({required this.widgets});
  final List<_WidgetItem> widgets;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widgets.length,
      separatorBuilder: (context, _) =>
          const SizedBox(height: AppConstants.spaceSM),
      itemBuilder: (_, i) => _WidgetListTile(item: widgets[i]),
    );
  }
}

// ── Widget card (grid) ────────────────────────────────────────────────────────

class _WidgetCard extends StatelessWidget {
  const _WidgetCard({required this.item});
  final _WidgetItem item;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spaceSM,
              vertical: AppConstants.spaceXS,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppConstants.borderGreyLight,
                width: AppConstants.borderThin,
              ),
              borderRadius: BorderRadius.circular(AppConstants.radiusSM),
            ),
            child: Text(item.category, style: textTheme.labelSmall),
          ),
          const Spacer(),
          Text(item.name, style: textTheme.titleSmall),
          const SizedBox(height: AppConstants.spaceXS),
          Text('Tap to configure', style: textTheme.bodySmall),
        ],
      ),
    );
  }
}

// ── Widget list tile ──────────────────────────────────────────────────────────

class _WidgetListTile extends StatelessWidget {
  const _WidgetListTile({required this.item});
  final _WidgetItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceMD,
        vertical: AppConstants.spaceMD,
      ),
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
          // Leading dot — Nothing OS signature detail
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppConstants.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppConstants.spaceMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: textTheme.bodyLarge),
                const SizedBox(height: 2),
                Text(item.category, style: textTheme.labelSmall),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: AppConstants.whiteSubtle,
          ),
        ],
      ),
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────

class _WidgetItem {
  const _WidgetItem({
    required this.id,
    required this.name,
    required this.category,
  });
  final int id;
  final String name;
  final String category;
}
