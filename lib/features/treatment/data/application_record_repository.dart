import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/application_record.dart';

class ApplicationRecordRepository {
  const ApplicationRecordRepository(this._database);

  final AppDatabase _database;

  Future<List<ApplicationRecord>> loadRecords(String treatmentId) async {
    final entries =
        await (_database.select(_database.applicationRecordEntries)
              ..where((table) => table.treatmentId.equals(treatmentId))
              ..orderBy([(table) => OrderingTerm.asc(table.registeredAt)]))
            .get();

    return entries.map(_fromEntry).toList();
  }

  Future<void> saveRecord({
    required String treatmentId,
    required ApplicationRecord record,
  }) async {
    await _database
        .into(_database.applicationRecordEntries)
        .insert(
          ApplicationRecordEntriesCompanion.insert(
            id: record.id,
            treatmentId: treatmentId,
            medicationId: record.medicationId,
            medicationName: record.medicationName,
            scheduledAt: record.scheduledAt,
            registeredAt: record.registeredAt,
            registrationStatus: record.registrationStatus.name,
            adjustedSchedule: record.adjustedSchedule,
            applicationPointId: Value(record.applicationPointId),
            applicationPointLabel: Value(record.applicationPointLabel),
            notes: Value(record.notes),
          ),
        );
  }

  Future<void> clearRecords(String treatmentId) async {
    await (_database.delete(
      _database.applicationRecordEntries,
    )..where((table) => table.treatmentId.equals(treatmentId))).go();
  }

  ApplicationRecord _fromEntry(ApplicationRecordEntry entry) {
    return ApplicationRecord(
      id: entry.id,
      medicationId: entry.medicationId,
      medicationName: entry.medicationName,
      applicationPointId: entry.applicationPointId,
      applicationPointLabel: entry.applicationPointLabel,
      scheduledAt: entry.scheduledAt,
      registeredAt: entry.registeredAt,
      registrationStatus: ApplicationRegistrationStatus.values.byName(
        entry.registrationStatus,
      ),
      adjustedSchedule: entry.adjustedSchedule,
      appliedAt: entry.registeredAt,
      notes: entry.notes,
    );
  }
}
