import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../core/database/app_database.dart';
import 'data/timeline_repository.dart';
import 'domain/timeline_event.dart';

class TimelineScreen extends StatelessWidget {
  const TimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TimelineEvent>>(
      stream: TimelineRepository(appDatabase).watchEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Carregando linha do tempo...'));
        }

        final events = snapshot.data ?? const [];
        if (events.isEmpty) {
          return const _TimelineEmptyState();
        }

        final groups = const TimelineService().groupByDate(events);
        return ListView.separated(
          itemCount: groups.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return _TimelineDateGroup(group: groups[index]);
          },
        );
      },
    );
  }
}

class _TimelineEmptyState extends StatelessWidget {
  const _TimelineEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/branding/app_icon.png',
                  height: 56,
                  fit: BoxFit.contain,
                  semanticLabel: 'Marca EMControle',
                ),
                const SizedBox(height: 16),
                Text(
                  'Nada registrado ainda',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Seus registros de tratamento e sintomas aparecerão aqui.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimelineDateGroup extends StatelessWidget {
  const _TimelineDateGroup({required this.group});

  final TimelineDateGroup group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            _formatDateHeading(group.date),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              for (final (index, event) in group.events.indexed) ...[
                _TimelineEventTile(event: event),
                if (index < group.events.length - 1) const Divider(height: 1),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineEventTile extends StatelessWidget {
  const _TimelineEventTile({required this.event});

  final TimelineEvent event;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        child: Icon(_eventIcon(event.eventType)),
      ),
      title: Text(event.title),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_formatTime(event.eventDateTime)),
            if (event.description.trim().isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(event.description),
            ],
            if (event.indicatorLabels.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final label in event.indicatorLabels)
                    Chip(
                      visualDensity: VisualDensity.compact,
                      label: Text(label),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
      trailing: _canOpenDetails(event.eventType)
          ? const Icon(Icons.chevron_right)
          : null,
      onTap: _canOpenDetails(event.eventType)
          ? () => _openDetails(context, event)
          : null,
    );
  }

  IconData _eventIcon(TimelineEventType eventType) {
    return switch (eventType) {
      TimelineEventType.application => Icons.medication_outlined,
      TimelineEventType.diary => Icons.edit_note_outlined,
      TimelineEventType.treatmentChange => Icons.swap_horiz_outlined,
    };
  }

  bool _canOpenDetails(TimelineEventType eventType) {
    return eventType == TimelineEventType.application ||
        eventType == TimelineEventType.diary;
  }

  void _openDetails(BuildContext context, TimelineEvent event) {
    final route = switch (event.eventType) {
      TimelineEventType.application => '${AppRoutes.history}/${event.id}',
      TimelineEventType.diary => '${AppRoutes.diary}/${event.id}',
      TimelineEventType.treatmentChange => AppRoutes.timeline,
    };

    context.go(route);
  }
}

String _formatDateHeading(DateTime value) {
  final now = DateTime.now();
  if (_sameLocalDate(value, now)) {
    return 'Hoje';
  }
  if (_sameLocalDate(value, now.subtract(const Duration(days: 1)))) {
    return 'Ontem';
  }

  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  return '$day/$month/${value.year}';
}

String _formatTime(DateTime value) {
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

bool _sameLocalDate(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
