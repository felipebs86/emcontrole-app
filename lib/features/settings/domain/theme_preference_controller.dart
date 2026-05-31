import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../data/settings_repository.dart';

final themePreferenceController = ThemePreferenceController.persistent();

class ThemePreferenceController extends ChangeNotifier {
  ThemePreferenceController([this._repository]);

  ThemePreferenceController.persistent()
    : this(SettingsRepository(appDatabase));

  final SettingsRepository? _repository;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> load() async {
    final repository = _repository;
    if (repository == null) {
      return;
    }

    final value = await repository.loadThemeModeName();
    _themeMode = _themeModeFromName(value);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode value) async {
    if (_themeMode == value) {
      return;
    }

    _themeMode = value;
    notifyListeners();
    await _repository?.saveThemeModeName(value.name);
  }

  ThemeMode _themeModeFromName(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}
