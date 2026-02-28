import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../core/models/academic_event.dart';
import '../../core/models/class_session.dart';
import '../../main.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ValueNotifier<String> _selectedFilter = ValueNotifier<String>(
    'Overview',
  );

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1E212B),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showClassDetails(ClassSession session) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final startTimeString =
            '${session.startTime.hour.toString().padLeft(2, '0')}:${session.startTime.minute.toString().padLeft(2, '0')}';
        final endTimeString =
            '${session.endTime.hour.toString().padLeft(2, '0')}:${session.endTime.minute.toString().padLeft(2, '0')}';

        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF0FDF4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color(0xFFCBECE8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LucideIcons.bookOpen,
                      size: 32,
                      color: Color(0xFF1E212B),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          session.title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1E212B),
                                height: 1.2,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _DetailRow(
                icon: LucideIcons.user,
                label: 'Lecturer',
                value: session.lecturer,
              ),
              const SizedBox(height: 16),
              _DetailRow(
                icon: LucideIcons.mapPin,
                label: 'Room',
                value: session.room,
              ),
              const SizedBox(height: 16),
              _DetailRow(
                icon: LucideIcons.clock,
                label: 'Time',
                value: '$startTimeString - $endTimeString',
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56.0,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1E212B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final todayWeekday = DateTime.now().weekday > 5
        ? 1
        : DateTime.now().weekday;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFE4F5F4),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4EFEF), Color(0xFFE4F5F4), Color(0xFFF0FDF4)],
        ),
      ),
      child: SafeArea(
        child: ValueListenableBuilder<String>(
          valueListenable: _selectedFilter,
          builder: (context, filter, _) {
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: _DashboardAppBar(
                      onMenuTap: () => _showSnackBar('Opening Apps Menu...'),
                      onBellTap: () => _showSnackBar('No new notifications'),
                      onProfileTap: () =>
                          _showSnackBar('Opening Profile Settings...'),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Daily\nDashboard',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E212B),
                            height: 1.2,
                            fontSize: 32,
                          ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        _FilterChip(
                          label: 'Overview',
                          selectedValue: filter,
                          onSelected: (val) => _selectedFilter.value = val,
                        ),
                        const SizedBox(width: 12),
                        _FilterChip(
                          label: 'Classes',
                          selectedValue: filter,
                          onSelected: (val) => _selectedFilter.value = val,
                        ),
                        const SizedBox(width: 12),
                        _FilterChip(
                          label: 'Assignments',
                          selectedValue: filter,
                          onSelected: (val) => _selectedFilter.value = val,
                        ),
                        const SizedBox(width: 12),
                        _FilterChip(
                          label: 'Exams',
                          selectedValue: filter,
                          onSelected: (val) => _selectedFilter.value = val,
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                if (filter == 'Overview' || filter == 'Classes') ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        filter == 'Classes' ? "All Classes" : "Today's Classes",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  StreamBuilder<List<ClassSession>>(
                    stream: isar.classSessions
                        .filter()
                        .dayOfWeekEqualTo(todayWeekday)
                        .sortByStartTime()
                        .watch(fireImmediately: true),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final classes = snapshot.data ?? [];

                      if (classes.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              'No classes scheduled for today.',
                              style: TextStyle(color: Colors.black38),
                            ),
                          ),
                        );
                      }

                      final displayClasses = filter == 'Classes'
                          ? classes
                          : classes.take(4).toList();

                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.0,
                                mainAxisSpacing: 16.0,
                                childAspectRatio: 0.95,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final session = displayClasses[index];
                            return _CourseCard(
                              session: session,
                              index: index,
                              onTap: () => _showClassDetails(session),
                            );
                          }, childCount: displayClasses.length),
                        ),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],

                if (filter == 'Overview' ||
                    filter == 'Assignments' ||
                    filter == 'Exams') ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            filter == 'Overview' ? 'Upcoming Events' : filter,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (filter == 'Overview')
                            GestureDetector(
                              onTap: () => _selectedFilter.value = 'Exams',
                              child: const Text(
                                'See all',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder<List<AcademicEvent>>(
                    stream: isar.academicEvents.where().sortByDate().watch(
                      fireImmediately: true,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverToBoxAdapter(child: SizedBox());
                      }

                      var events = snapshot.data ?? [];

                      if (filter == 'Exams') {
                        events = events
                            .where((e) => e.type == EventType.exam)
                            .toList();
                      } else if (filter == 'Assignments') {
                        events = events
                            .where((e) => e.type != EventType.exam)
                            .toList();
                      } else {
                        events = events.take(3).toList();
                      }

                      if (events.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              'No upcoming ${filter.toLowerCase()} scheduled.',
                              style: const TextStyle(color: Colors.black38),
                            ),
                          ),
                        );
                      }

                      return SliverPadding(
                        padding: const EdgeInsets.all(24.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final event = events[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: _EventCard(
                                event: event,
                                onTap: () => _showSnackBar(
                                  '${event.title} is scheduled on ${event.date.day}/${event.date.month}/${event.date.year}',
                                ),
                              ),
                            );
                          }, childCount: events.length),
                        ),
                      );
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _DashboardAppBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onBellTap;
  final VoidCallback onProfileTap;

  const _DashboardAppBar({
    required this.onMenuTap,
    required this.onBellTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onMenuTap,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: const Icon(LucideIcons.grid, size: 24),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: onBellTap,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Icon(LucideIcons.bell, size: 20),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onProfileTap,
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFF1E212B),
                child: Icon(LucideIcons.user, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  const _FilterChip({
    required this.label,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedValue == label;
    return GestureDetector(
      onTap: () => onSelected(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1E212B)
              : Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1E212B),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final ClassSession session;
  final int index;
  final VoidCallback onTap;

  const _CourseCard({
    required this.session,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pastels = [
      const Color(0xFFCBECE8),
      const Color(0xFFFBE4C7),
      const Color(0xFFFDE4EC),
      const Color(0xFFD4EFEF),
    ];
    final cardColor = pastels[index % pastels.length].withValues(alpha: 0.7);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Transform.rotate(
                    angle: -0.785,
                    child: const Icon(
                      LucideIcons.arrowRight,
                      size: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              session.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 1.2,
                color: Color(0xFF1E212B),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final AcademicEvent event;
  final VoidCallback onTap;

  const _EventCard({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF1E212B),
                shape: BoxShape.circle,
              ),
              child: Icon(
                event.type == EventType.exam
                    ? LucideIcons.fileWarning
                    : LucideIcons.partyPopper,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1E212B),
                    ),
                  ),
                  Text(
                    '${event.date.day.toString().padLeft(2, '0')}/${event.date.month.toString().padLeft(2, '0')}/${event.date.year}',
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: Colors.black54),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF1E212B),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
