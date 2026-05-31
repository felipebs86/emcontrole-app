import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/treatment_change_record.dart';

abstract class TreatmentChangeDataSource {
  Future<List<TreatmentChangeRecord>> loadRecords();

  Future<void> saveRecord(TreatmentChangeRecord record);
}

class TreatmentChangeRepository implements TreatmentChangeDataSource {
  const TreatmentChangeRepository(this._database);

  final AppDatabase _database;

  @override
  Future<List<TreatmentChangeRecord>> loadRecords() async {
    final entries = await (_database.select(
      _database.treatmentChangeEntries,
    )..orderBy([(table) => OrderingTerm.desc(table.changedAt)])).get();

    return entries.map(_fromEntry).toList();
  }

  @override
  Future<void> saveRecord(TreatmentChangeRecord record) async {
    await _database
        .into(_database.treatmentChangeEntries)
        .insert(
          TreatmentChangeEntriesCompanion.insert(
            id: record.id,
            previousMedicationId: record.previousMedicationId,
            previousMedicationName: record.previousMedicationName,
            newMedicationId: record.newMedicationId,
            newMedicationName: record.newMedicationName,
            changedAt: record.changedAt,
          ),
        );
  }

  TreatmentChangeRecord _fromEntry(TreatmentChangeEntry entry) {
    return TreatmentChangeRecord(
      id: entry.id,
      previousMedicationId: entry.previousMedicationId,
      previousMedicationName: entry.previousMedicationName,
      newMedicationId: entry.newMedicationId,
      newMedicationName: entry.newMedicationName,
      changedAt: entry.changedAt,
    );
  }
}
