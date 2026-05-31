class TreatmentChangeRecord {
  const TreatmentChangeRecord({
    required this.id,
    required this.previousMedicationId,
    required this.previousMedicationName,
    required this.newMedicationId,
    required this.newMedicationName,
    required this.changedAt,
  });

  final String id;
  final String previousMedicationId;
  final String previousMedicationName;
  final String newMedicationId;
  final String newMedicationName;
  final DateTime changedAt;
}
