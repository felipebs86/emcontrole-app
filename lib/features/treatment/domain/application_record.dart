enum ApplicationRegistrationStatus { onTime, early, late, scheduleAdjustment }

class ApplicationRecord {
  const ApplicationRecord({
    required this.id,
    required this.medicationId,
    required this.medicationName,
    required this.applicationPointId,
    required this.applicationPointLabel,
    required this.scheduledAt,
    required this.registeredAt,
    required this.registrationStatus,
    required this.adjustedSchedule,
    required this.appliedAt,
    this.notes,
  });

  final String id;
  final String medicationId;
  final String medicationName;
  final String? applicationPointId;
  final String? applicationPointLabel;
  final DateTime scheduledAt;
  final DateTime registeredAt;
  final ApplicationRegistrationStatus registrationStatus;
  final bool adjustedSchedule;
  final DateTime appliedAt;
  final String? notes;
}
