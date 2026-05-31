import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

class SettingsRepository {
  const SettingsRepository(this._database);

  static const themeModeKey = 'theme_mode';

  final AppDatabase _database;

  Future<String?> loadThemeModeName() async {
    final entry = await (_database.select(
      _database.appPreferenceEntries,
    )..where((table) => table.key.equals(themeModeKey))).getSingleOrNull();

    return entry?.value;
  }

  Future<void> saveThemeModeName(String value) async {
    await _database
        .into(_database.appPreferenceEntries)
        .insertOnConflictUpdate(
          AppPreferenceEntriesCompanion(
            key: const Value(themeModeKey),
            value: Value(value),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }
}
