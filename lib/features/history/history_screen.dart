import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../core/database/app_database.dart';
import '../treatment/data/application_record_repository.dart';
import '../treatment/data/medication_catalog_data_source.dart';
import '../treatment/data/treatment_repository.dart';
import '../treatment/domain/application_record.dart';
import '../treatment/domain/medication.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ApplicationRecord>>(
      stream: ApplicationRecordRepository(
        appDatabase,
      ).watchRecords(TreatmentRepository.activeTreatmentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Carregando histórico...'));
        }

        final records = snapshot.data ?? const [];
        if (records.isEmpty) {
          return const _HistoryEmptyState();
        }

        final groupedRecords = _groupRecordsByDate(records);
        return ListView(
          children: [
            for (final (index, group) in groupedRecords.indexed) ...[
              _HistoryDateGroup(group: group),
              if (index < groupedRecords.length - 1) const SizedBox(height: 16),
            ],
          ],
        );
      },
    );
  }
}

class HistoryRecordDetailsScreen extends StatelessWidget {
  const HistoryRecordDetailsScreen({required this.recordId, super.key});

  final String recordId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ApplicationRecord>>(
      future: ApplicationRecordRepository(
        appDatabase,
      ).loadRecords(TreatmentRepository.activeTreatmentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: Text('Carregando registro...'));
        }

        final record = (snapshot.data ?? const [])
            .where((record) => record.id == recordId)
            .firstOrNull;
        if (record == null) {
          return const _HistoryRecordNotFound();
        }

        return _HistoryRecordDetails(record: record);
      },
    );
  }
}

class _HistoryEmptyState extends StatelessWidget {
  const _HistoryEmptyState();

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
                SvgPicture.asset(
                  'assets/images/brand/emcontrole_mark.svg',
                  height: 56,
                  semanticsLabel: 'Marca EMControle',
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhuma aplicação registrada',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Suas aplicações aparecerão aqui conforme forem registradas.',
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

class _HistoryRecordNotFound extends StatelessWidget {
  const _HistoryRecordNotFound();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Registro não encontrado',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => context.go(AppRoutes.history),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Voltar ao histórico'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryDateGroup extends StatelessWidget {
  const _HistoryDateGroup({required this.group});

  final _RecordDateGroup group;

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
              for (final (index, record) in group.records.indexed) ...[
                _HistoryRecordTile(record: record),
                if (index < group.records.length - 1) const Divider(height: 1),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _HistoryRecordTile extends StatelessWidget {
  const _HistoryRecordTile({required this.record});

  final ApplicationRecord record;

  @override
  Widget build(BuildContext context) {
    final point = _applicationPointFor(record);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      title: Text(record.medicationName),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_recordUsageSummary(record, point)),
            const SizedBox(height: 2),
            Text(_formatRelativeDateTime(record.registeredAt)),
          ],
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.go('${AppRoutes.history}/${record.id}'),
    );
  }
}

class _HistoryRecordDetails extends StatelessWidget {
  const _HistoryRecordDetails({required this.record});

  final ApplicationRecord record;

  @override
  Widget build(BuildContext context) {
    final medication = _medicationFor(record);
    final point = _applicationPointFor(record);

    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.medicationName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (medication != null) ...[
                  const SizedBox(height: 12),
                  _DetailRow(
                    label: 'Princípio ativo',
                    value: medication.activeIngredient,
                  ),
                ],
                const SizedBox(height: 12),
                _DetailRow(
                  label: 'Registro',
                  value: _formatDateTime(record.registeredAt),
                ),
                const SizedBox(height: 12),
                _DetailRow(
                  label: 'Previsto',
                  value: _formatDateTime(record.scheduledAt),
                ),
                const SizedBox(height: 12),
                _DetailRow(
                  label: 'Status',
                  value: _registrationStatusLabel(record.registrationStatus),
                ),
                const SizedBox(height: 12),
                _DetailRow(
                  label: 'Ponto de aplicação',
                  value: record.applicationPointLabel ?? 'Não aplicável',
                ),
                const SizedBox(height: 12),
                _DetailRow(
                  label: 'Região',
                  value: point?.bodyRegion ?? 'Não aplicável',
                ),
              ],
            ),
          ),
        ),
        if (point != null) ...[
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Ilustração do local',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  _ApplicationPointIllustration(point: point),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

class _ApplicationPointIllustration extends StatelessWidget {
  const _ApplicationPointIllustration({required this.point});

  final ApplicationPoint point;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.load(point.imageAssetPath),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _MissingApplicationPointIllustration(point: point);
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Semantics(
          label: 'Ilustração do ponto de aplicação: ${point.label}',
          image: true,
          child: SvgPicture.asset(
            point.imageAssetPath,
            height: 180,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}

class _MissingApplicationPointIllustration extends StatelessWidget {
  const _MissingApplicationPointIllustration({required this.point});

  final ApplicationPoint point;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(point.label)),
    );
  }
}

class _RecordDateGroup {
  const _RecordDateGroup({required this.date, required this.records});

  final DateTime date;
  final List<ApplicationRecord> records;
}

List<_RecordDateGroup> _groupRecordsByDate(List<ApplicationRecord> records) {
  final sortedRecords = [
    ...records,
  ]..sort((first, second) => second.registeredAt.compareTo(first.registeredAt));
  final groups = <_RecordDateGroup>[];

  for (final record in sortedRecords) {
    final date = _dateOnly(record.registeredAt);
    if (groups.isNotEmpty && _sameLocalDate(groups.last.date, date)) {
      groups.last.records.add(record);
      continue;
    }

    groups.add(_RecordDateGroup(date: date, records: [record]));
  }

  return groups;
}

Medication? _medicationFor(ApplicationRecord record) {
  return const MedicationCatalogDataSource()
      .loadMedications()
      .where((medication) => medication.id == record.medicationId)
      .firstOrNull;
}

ApplicationPoint? _applicationPointFor(ApplicationRecord record) {
  final medication = _medicationFor(record);
  if (medication == null || record.applicationPointId == null) {
    return null;
  }

  return medication.applicationPoints
      .where((point) => point.id == record.applicationPointId)
      .firstOrNull;
}

String _recordUsageSummary(ApplicationRecord record, ApplicationPoint? point) {
  final pointLabel = record.applicationPointLabel;
  if (pointLabel == null) {
    return 'Uso registrado · ${_registrationStatusLabel(record.registrationStatus)}';
  }

  final region = point?.bodyRegion;
  if (region == null || region.isEmpty) {
    return '$pointLabel · ${_registrationStatusLabel(record.registrationStatus)}';
  }

  return '$pointLabel - $region · ${_registrationStatusLabel(record.registrationStatus)}';
}

String _registrationStatusLabel(ApplicationRegistrationStatus status) {
  return switch (status) {
    ApplicationRegistrationStatus.onTime => 'Em dia',
    ApplicationRegistrationStatus.early => 'Antecipado',
    ApplicationRegistrationStatus.late => 'Fora da janela prevista',
    ApplicationRegistrationStatus.scheduleAdjustment => 'Ajuste de agenda',
  };
}

String _formatDateHeading(DateTime value) {
  final now = DateTime.now();
  if (_sameLocalDate(value, now)) {
    return 'Hoje';
  }
  if (_sameLocalDate(value, now.subtract(const Duration(days: 1)))) {
    return 'Ontem';
  }

  return _formatDate(value);
}

String _formatRelativeDateTime(DateTime value) {
  final now = DateTime.now();
  if (_sameLocalDate(value, now)) {
    return 'Hoje às ${_formatTime(value)}';
  }
  if (_sameLocalDate(value, now.subtract(const Duration(days: 1)))) {
    return 'Ontem às ${_formatTime(value)}';
  }

  return _formatDateTime(value);
}

String _formatDateTime(DateTime value) {
  return '${_formatDate(value)} às ${_formatTime(value)}';
}

String _formatDate(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  return '$day/$month/${value.year}';
}

String _formatTime(DateTime value) {
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

DateTime _dateOnly(DateTime value) {
  return DateTime(value.year, value.month, value.day);
}

bool _sameLocalDate(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
