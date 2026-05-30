class TreatmentSnapshot {
  const TreatmentSnapshot({
    required this.id,
    required this.userName,
    required this.medicationId,
    required this.medicationName,
    required this.selectedApplicationPointId,
    required this.selectedApplicationPointLabel,
    required this.applicationTime,
    required this.treatmentStartDate,
    required this.remindersEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String userName;
  final String medicationId;
  final String medicationName;
  final String? selectedApplicationPointId;
  final String? selectedApplicationPointLabel;
  final String applicationTime;
  final DateTime treatmentStartDate;
  final bool remindersEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  DateTime get scheduledAt {
    final parts = applicationTime.split(':');
    final hour = int.tryParse(parts.first) ?? 0;
    final minute = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;

    return DateTime(
      treatmentStartDate.year,
      treatmentStartDate.month,
      treatmentStartDate.day,
      hour,
      minute,
    );
  }
}
