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
  TextColumn get applicationRegionId => text().nullable()();
  TextColumn get applicationRegionLabel => text().nullable()();
  TextColumn get applicationSubRegionId => text().nullable()();
  TextColumn get applicationSubRegionLabel => text().nullable()();
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

class AppPreferenceEntries extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    TreatmentEntries,
    ApplicationRecordEntries,
    DiaryEntries,
    TreatmentChangeEntries,
    AppPreferenceEntries,
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
  int get schemaVersion => 5;

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
      if (from < 4) {
        await migrator.createTable(appPreferenceEntries);
      }
      if (from < 5) {
        await migrator.addColumn(
          applicationRecordEntries,
          applicationRecordEntries.applicationRegionId,
        );
        await migrator.addColumn(
          applicationRecordEntries,
          applicationRecordEntries.applicationRegionLabel,
        );
        await migrator.addColumn(
          applicationRecordEntries,
          applicationRecordEntries.applicationSubRegionId,
        );
        await migrator.addColumn(
          applicationRecordEntries,
          applicationRecordEntries.applicationSubRegionLabel,
        );
      }
    },
  );
}

final appDatabase = AppDatabase.defaults();
