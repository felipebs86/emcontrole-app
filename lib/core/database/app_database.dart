import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class TreatmentEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userName => text()();
  TextColumn get medicationId => text()();
  TextColumn get medicationName => text()();
  TextColumn get selectedApplicationPointId => text().nullable()();
  TextColumn get selectedApplicationPointLabel => text().nullable()();
  TextColumn get applicationTime => text()();
  DateTimeColumn get treatmentStartDate => dateTime()();
  BoolColumn get remindersEnabled => boolean()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class ApplicationRecordEntries extends Table {
  TextColumn get id => text()();
  TextColumn get treatmentId => text()();
  TextColumn get medicationId => text()();
  TextColumn get medicationName => text()();
  TextColumn get applicationPointId => text().nullable()();
  TextColumn get applicationPointLabel => text().nullable()();
  DateTimeColumn get scheduledAt => dateTime()();
  DateTimeColumn get registeredAt => dateTime()();
  TextColumn get registrationStatus => text()();
  BoolColumn get adjustedSchedule => boolean()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [TreatmentEntries, ApplicationRecordEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.defaults()
    : super(
        driftDatabase(
          name: 'emcontrole',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  @override
  int get schemaVersion => 1;
}

final appDatabase = AppDatabase.defaults();
