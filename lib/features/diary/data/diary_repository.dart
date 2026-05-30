import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/diary_entry.dart';

class DiaryRepository {
  const DiaryRepository(this._database);

  final AppDatabase _database;

  Future<List<SymptomDiaryEntry>> loadEntries() async {
    final entries = await (_database.select(
      _database.diaryEntries,
    )..orderBy([(table) => OrderingTerm.desc(table.createdAt)])).get();

    return entries.map(_fromEntry).toList();
  }

  Future<SymptomDiaryEntry?> loadEntry(String id) async {
    final entry = await (_database.select(
      _database.diaryEntries,
    )..where((table) => table.id.equals(id))).getSingleOrNull();

    if (entry == null) {
      return null;
    }

    return _fromEntry(entry);
  }

  Future<void> saveEntry(SymptomDiaryEntry entry) async {
    await _database
        .into(_database.diaryEntries)
        .insert(
          DiaryEntriesCompanion.insert(
            id: entry.id,
            createdAt: entry.createdAt,
            title: entry.title,
            notes: entry.notes,
            fatigueLevel: Value(entry.fatigueLevel),
            painLevel: Value(entry.painLevel),
            moodLevel: Value(entry.moodLevel),
            sleepQualityLevel: Value(entry.sleepQualityLevel),
          ),
        );
  }

  SymptomDiaryEntry _fromEntry(DiaryEntry entry) {
    return SymptomDiaryEntry(
      id: entry.id,
      createdAt: entry.createdAt,
      title: entry.title,
      notes: entry.notes,
      fatigueLevel: entry.fatigueLevel,
      painLevel: entry.painLevel,
      moodLevel: entry.moodLevel,
      sleepQualityLevel: entry.sleepQualityLevel,
    );
  }
}
