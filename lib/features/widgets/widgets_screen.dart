import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/providers/settings_provider.dart';
import 'nothing_clock_card.dart';
import 'nothing_battery_card.dart';
import 'nothing_quick_note_card.dart';

class WidgetsScreen extends ConsumerWidget {
  const WidgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layout = ref.watch(settingsProvider.select((s) => s.widgetLayout));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('WIDGETS', style: textTheme.titleSmall),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppConstants.spaceMD),
            child: _LayoutBadge(layout: layout),
          ),
        ],
      ),
      body: layout == WidgetLayout.grid
          ? _GridView(textTheme: textTheme)
          : _ListView(textTheme: textTheme),
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({required this.textTheme});
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppConstants.spaceMD),
      children: [
        _SectionHeader(label: 'V1  •  NOTHING UI', textTheme: textTheme),
        const SizedBox(height: AppConstants.spaceMD),

        const NothingClockCard(),
        const SizedBox(height: AppConstants.spaceMD),

        const NothingBatteryCard(),
        const SizedBox(height: AppConstants.spaceMD),

        const NothingQuickNoteCard(),
        const SizedBox(height: AppConstants.spaceLG),

        _ComingSoonFooter(textTheme: textTheme),
        const SizedBox(height: AppConstants.spaceMD),
      ],
    );
  }
}

class _GridView extends StatelessWidget {
  const _GridView({required this.textTheme});
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(AppConstants.spaceMD),
          sliver: SliverToBoxAdapter(
            child: _SectionHeader(
              label: 'V1  •  NOTHING UI',
              textTheme: textTheme,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceMD),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate([
              const _GridTile(
                tag: 'CLOCK',
                icon: Icons.access_time_rounded,
                description: 'Dot-matrix digital clock with blinking colon.',
              ),
              const _GridTile(
                tag: 'BATTERY',
                icon: Icons.battery_charging_full_rounded,
                description: 'Segmented battery level indicator.',
              ),
              const _GridTile(
                tag: 'QUICK NOTE',
                icon: Icons.sticky_note_2_outlined,
                description: 'Editable note synced to home screen widget.',
              ),
              const _GridTile(
                tag: 'COMING SOON',
                icon: Icons.add_circle_outline_rounded,
                description: 'More widgets in V2.',
                dimmed: true,
              ),
            ]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppConstants.spaceSM,
              crossAxisSpacing: AppConstants.spaceSM,
              childAspectRatio: 1.0,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: AppConstants.spaceLG)),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.textTheme});
  final String label;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: textTheme.titleSmall),
        const SizedBox(width: AppConstants.spaceSM),
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
          child: Text('3 WIDGETS', style: textTheme.labelSmall),
        ),
      ],
    );
  }
}

class _GridTile extends StatelessWidget {
  const _GridTile({
    required this.tag,
    required this.icon,
    required this.description,
    this.dimmed = false,
  });

  final String tag;
  final IconData icon;
  final String description;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconColor = dimmed ? AppConstants.whiteSubtle : AppConstants.white;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMD),
      decoration: BoxDecoration(
        color: AppConstants.surfaceDark,
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
        border: Border.all(
          color: dimmed
              ? AppConstants.borderGrey
              : AppConstants.borderGreyLight,
          width: AppConstants.borderNormal,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const Spacer(),
          Text(
            tag,
            style: textTheme.titleSmall?.copyWith(
              color: dimmed ? AppConstants.whiteSubtle : null,
            ),
          ),
          const SizedBox(height: AppConstants.spaceXS),
          Text(
            description,
            style: textTheme.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ComingSoonFooter extends StatelessWidget {
  const _ComingSoonFooter({required this.textTheme});
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spaceMD),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppConstants.borderGrey,
          width: AppConstants.borderThin,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.more_horiz_rounded,
            color: AppConstants.whiteSubtle,
            size: 16,
          ),
          const SizedBox(width: AppConstants.spaceSM),
          Text('V2: One UI + iOS style widgets', style: textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _LayoutBadge extends StatelessWidget {
  const _LayoutBadge({required this.layout});
  final WidgetLayout layout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceSM,
        vertical: AppConstants.spaceXS,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppConstants.borderGrey,
          width: AppConstants.borderThin,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusSM),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            layout == WidgetLayout.grid
                ? Icons.grid_view_rounded
                : Icons.view_list_rounded,
            size: 12,
            color: AppConstants.whiteSubtle,
          ),
          const SizedBox(width: 4),
          Text(
            layout == WidgetLayout.grid ? 'GRID' : 'LIST',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppConstants.whiteSubtle),
          ),
        ],
      ),
    );
  }
}
