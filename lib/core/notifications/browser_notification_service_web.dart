import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as web;

class BrowserNotificationService {
  static final Map<int, Timer> _timers = {};

  Future<bool> requestPermission() async {
    if (!_isSupported) {
      return false;
    }

    try {
      final currentPermission = web.Notification.permission;
      if (currentPermission == 'granted') {
        return true;
      }

      if (currentPermission == 'denied') {
        return false;
      }

      final permission = await web.Notification.requestPermission().toDart;
      return permission.toDart == 'granted';
    } catch (_) {
      return false;
    }
  }

  bool scheduleMedicationReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,
  }) {
    cancelMedicationReminder(id: id);

    if (!_isSupported ||
        web.Notification.permission != 'granted' ||
        !scheduledAt.isAfter(DateTime.now())) {
      return false;
    }

    final delay = scheduledAt.difference(DateTime.now());
    _timers[id] = Timer(delay, () {
      try {
        web.Notification(
          title,
          web.NotificationOptions(
            body: body,
            tag: 'emcontrole_reminder_$id',
            icon: 'icons/Icon-192.png',
          ),
        );
      } catch (_) {
        return;
      } finally {
        _timers.remove(id);
      }
    });

    return true;
  }

  void cancelMedicationReminder({int? id}) {
    if (id == null) {
      for (final timer in _timers.values) {
        timer.cancel();
      }
      _timers.clear();
      return;
    }

    _timers.remove(id)?.cancel();
  }

  bool get _isSupported => globalContext.has('Notification');
}
