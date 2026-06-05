class BrowserNotificationService {
  Future<bool> requestPermission() async => false;

  bool scheduleMedicationReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
  }) {
    return false;
  }

  void cancelMedicationReminder() {}
}
