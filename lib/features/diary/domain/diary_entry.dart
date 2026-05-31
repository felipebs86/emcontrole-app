class SymptomDiaryEntry {
  const SymptomDiaryEntry({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.notes,
    required this.fatigueLevel,
    required this.painLevel,
    required this.moodLevel,
    required this.sleepQualityLevel,
  });

  final String id;
  final DateTime createdAt;
  final String title;
  final String notes;
  final int? fatigueLevel;
  final int? painLevel;
  final int? moodLevel;
  final int? sleepQualityLevel;

  SymptomDiaryEntry copyWith({
    String? title,
    String? notes,
    int? fatigueLevel,
    int? painLevel,
    int? moodLevel,
    int? sleepQualityLevel,
  }) {
    return SymptomDiaryEntry(
      id: id,
      createdAt: createdAt,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      fatigueLevel: fatigueLevel ?? this.fatigueLevel,
      painLevel: painLevel ?? this.painLevel,
      moodLevel: moodLevel ?? this.moodLevel,
      sleepQualityLevel: sleepQualityLevel ?? this.sleepQualityLevel,
    );
  }
}
