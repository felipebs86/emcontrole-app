import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/treatment_snapshot.dart';

class TreatmentRepository {
  const TreatmentRepository(this._database);

  static const activeTreatmentId = 'active_treatment';

  final AppDatabase _database;

  Future<TreatmentSnapshot?> loadActiveTreatment() async {
    final entry = await (_database.select(
      _database.treatmentEntries,
    )..where((table) => table.id.equals(activeTreatmentId))).getSingleOrNull();

    if (entry == null) {
      return null;
    }

    return _fromEntry(entry);
  }

  Future<void> saveActiveTreatment(TreatmentSnapshot treatment) async {
    await _database
        .into(_database.treatmentEntries)
        .insertOnConflictUpdate(
          TreatmentEntriesCompanion(
            id: Value(treatment.id),
            userName: Value(treatment.userName),
            medicationId: Value(treatment.medicationId),
            medicationName: Value(treatment.medicationName),
            selectedApplicationPointId: Value(
              treatment.selectedApplicationPointId,
            ),
            selectedApplicationPointLabel: Value(
              treatment.selectedApplicationPointLabel,
            ),
            applicationTime: Value(treatment.applicationTime),
            treatmentStartDate: Value(treatment.treatmentStartDate),
            remindersEnabled: Value(treatment.remindersEnabled),
            createdAt: Value(treatment.createdAt),
            updatedAt: Value(treatment.updatedAt),
          ),
        );
  }

  Future<void> updateCurrentApplicationPoint({
    required String? pointId,
    required String? pointLabel,
    required DateTime updatedAt,
  }) async {
    await (_database.update(
      _database.treatmentEntries,
    )..where((table) => table.id.equals(activeTreatmentId))).write(
      TreatmentEntriesCompanion(
        selectedApplicationPointId: Value(pointId),
        selectedApplicationPointLabel: Value(pointLabel),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  TreatmentSnapshot _fromEntry(TreatmentEntry entry) {
    return TreatmentSnapshot(
      id: entry.id,
      userName: entry.userName,
      medicationId: entry.medicationId,
      medicationName: entry.medicationName,
      selectedApplicationPointId: entry.selectedApplicationPointId,
      selectedApplicationPointLabel: entry.selectedApplicationPointLabel,
      applicationTime: entry.applicationTime,
      treatmentStartDate: entry.treatmentStartDate,
      remindersEnabled: entry.remindersEnabled,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    );
  }
}
