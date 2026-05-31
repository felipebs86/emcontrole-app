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

class DiaryEntries extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get title => text()();
  TextColumn get notes => text()();
  IntColumn get fatigueLevel => integer().nullable()();
  IntColumn get painLevel => integer().nullable()();
  IntColumn get moodLevel => integer().nullable()();
  IntColumn get sleepQualityLevel => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class TreatmentChangeEntries extends Table {
  TextColumn get id => text()();
  TextColumn get previousMedicationId => text()();
  TextColumn get previousMedicationName => text()();
  TextColumn get newMedicationId => text()();
  TextColumn get newMedicationName => text()();
  DateTimeColumn get changedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    TreatmentEntries,
    ApplicationRecordEntries,
    DiaryEntries,
    TreatmentChangeEntries,
  ],
)
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
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(diaryEntries);
      }
      if (from < 3) {
        await migrator.createTable(treatmentChangeEntries);
      }
    },
  );
}

final appDatabase = AppDatabase.defaults();
