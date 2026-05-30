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
}
