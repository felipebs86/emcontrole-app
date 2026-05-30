import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../features/treatment/domain/medication.dart';

const localNotificationService = LocalNotificationService();

class LocalNotificationService {
  const LocalNotificationService();

  static const medicationReminderId = 1001;
  static const channelId = 'medication_reminders';
  static const channelName = 'Lembretes de medicamento';

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  Future<void> initialize() async {
    if (kIsWeb || _shouldSkipPlugin || _initialized) {
      return;
    }

    tz_data.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const linux = LinuxInitializationSettings(defaultActionName: 'Abrir');
    const windows = WindowsInitializationSettings(
      appName: 'EMControle',
      appUserModelId: 'br.com.emcontrole.app',
      guid: '2b8d0fb1-7f3d-49c8-bb7e-08b176ec3b91',
    );

    try {
      await _plugin.initialize(
        const InitializationSettings(
          android: android,
          iOS: darwin,
          macOS: darwin,
          linux: linux,
          windows: windows,
        ),
      );
      _initialized = true;
    } catch (_) {
      _initialized = false;
    }
  }

  Future<NotificationPermissionResult> requestPermission() async {
    if (kIsWeb) {
      return const NotificationPermissionResult.unsupported();
    }

    if (_shouldSkipPlugin) {
      return const NotificationPermissionResult(granted: true);
    }

    if (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.windows) {
      return const NotificationPermissionResult(granted: true);
    }

    await initialize();
    if (!_initialized) {
      return const NotificationPermissionResult.denied();
    }

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final granted = await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
        return NotificationPermissionResult(granted: granted ?? true);
      }

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final granted = await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        return NotificationPermissionResult(granted: granted ?? false);
      }

      if (defaultTargetPlatform == TargetPlatform.macOS) {
        final granted = await _plugin
            .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        return NotificationPermissionResult(granted: granted ?? false);
      }

      return const NotificationPermissionResult(granted: true);
    } catch (_) {
      return const NotificationPermissionResult.denied();
    }
  }

  Future<void> cancelMedicationReminder() async {
    if (kIsWeb || _shouldSkipPlugin) {
      return;
    }

    await initialize();
    if (!_initialized) {
      return;
    }

    try {
      await _plugin.cancel(medicationReminderId);
    } catch (_) {
      return;
    }
  }

  Future<NotificationScheduleResult> scheduleMedicationReminder({
    required Medication medication,
    required ApplicationPoint? applicationPoint,
    required DateTime scheduledAt,
  }) async {
    if (kIsWeb) {
      return const NotificationScheduleResult.unsupported();
    }

    if (_shouldSkipPlugin) {
      return const NotificationScheduleResult.scheduled();
    }

    await initialize();
    if (!_initialized) {
      return const NotificationScheduleResult.failed();
    }

    if (!scheduledAt.isAfter(DateTime.now())) {
      await cancelMedicationReminder();
      return const NotificationScheduleResult.notScheduled();
    }

    try {
      await _plugin.cancel(medicationReminderId);
      await _plugin.zonedSchedule(
        medicationReminderId,
        _titleFor(medication),
        _bodyFor(medication, applicationPoint),
        tz.TZDateTime.from(scheduledAt, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            channelName,
            channelDescription: 'Lembretes locais da rotina de medicamento',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
          macOS: DarwinNotificationDetails(),
          linux: LinuxNotificationDetails(),
          windows: WindowsNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        payload: 'medication_reminder',
      );

      return const NotificationScheduleResult.scheduled();
    } catch (_) {
      return const NotificationScheduleResult.failed();
    }
  }

  String _titleFor(Medication medication) {
    return switch (medication.administrationType) {
      AdministrationType.injectable => 'Hora da aplicação',
      AdministrationType.oral => 'Hora do medicamento',
      AdministrationType.infusion => 'Lembrete de tratamento',
    };
  }

  String _bodyFor(Medication medication, ApplicationPoint? applicationPoint) {
    if (medication.administrationType != AdministrationType.injectable ||
        applicationPoint == null) {
      return medication.name;
    }

    return '${medication.name}\nLocal sugerido: ${applicationPoint.label} - ${applicationPoint.bodyRegion}';
  }

  bool get _shouldSkipPlugin {
    final bindingType = BindingBase.debugBindingType();
    return bindingType == null ||
        bindingType.toString().contains('TestWidgetsFlutterBinding');
  }
}

class NotificationPermissionResult {
  const NotificationPermissionResult({required this.granted, this.message});

  const NotificationPermissionResult.denied()
    : this(
        granted: false,
        message: 'Não foi possível ativar os lembretes locais.',
      );

  const NotificationPermissionResult.unsupported()
    : this(
        granted: false,
        message: 'Lembretes locais estão disponíveis no aplicativo instalado.',
      );

  final bool granted;
  final String? message;
}

class NotificationScheduleResult {
  const NotificationScheduleResult({required this.scheduled, this.message});

  const NotificationScheduleResult.scheduled() : this(scheduled: true);

  const NotificationScheduleResult.notScheduled() : this(scheduled: false);

  const NotificationScheduleResult.failed()
    : this(
        scheduled: false,
        message: 'Não foi possível agendar o lembrete local.',
      );

  const NotificationScheduleResult.unsupported()
    : this(
        scheduled: false,
        message: 'Lembretes locais estão disponíveis no aplicativo instalado.',
      );

  final bool scheduled;
  final String? message;
}
