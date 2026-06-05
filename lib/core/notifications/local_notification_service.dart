import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../../features/treatment/domain/medication.dart';
import 'browser_notification_service_stub.dart'
    if (dart.library.js_interop) 'browser_notification_service_web.dart';

const localNotificationService = LocalNotificationService();

class LocalNotificationService {
  const LocalNotificationService();

  static const medicationReminderId = 1001;
  static const testReminderId = 1002;
  static const channelId = 'medication_reminders';
  static const channelName = 'Lembretes de medicamento';
  static const webPwaWarning =
      'Lembretes na versão Web/PWA dependem do navegador e podem não funcionar em todas as situações. Para uma experiência mais confiável, utilize a versão móvel do EMControle.';

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;
  static final BrowserNotificationService _browserNotifications =
      BrowserNotificationService();

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
      final permissionRequested = await _browserNotifications
          .requestPermission();
      return NotificationPermissionResult(
        granted: true,
        isBestEffort: true,
        message: permissionRequested
            ? webPwaWarning
            : 'Suporte Web/PWA em melhor esforço. $webPwaWarning',
      );
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
    if (kIsWeb) {
      _browserNotifications.cancelMedicationReminder();
      return;
    }

    if (_shouldSkipPlugin) {
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
      final scheduled = _browserNotifications.scheduleMedicationReminder(
        id: medicationReminderId,
        title: _titleFor(medication),
        body: _bodyFor(medication, applicationPoint),
        scheduledAt: scheduledAt,
      );

      return scheduled
          ? const NotificationScheduleResult.scheduled(isBestEffort: true)
          : const NotificationScheduleResult.bestEffortNotScheduled();
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

  Future<NotificationScheduleResult> scheduleDebugTestReminder() async {
    final scheduledAt = DateTime.now().add(const Duration(minutes: 1));

    if (kIsWeb) {
      final permissionRequested = await _browserNotifications
          .requestPermission();
      final scheduled = _browserNotifications.scheduleMedicationReminder(
        id: testReminderId,
        title: 'Lembrete de teste',
        body: 'Este é um lembrete de teste do EMControle.',
        scheduledAt: scheduledAt,
      );

      if (scheduled) {
        return NotificationScheduleResult.scheduled(
          isBestEffort: true,
          message: permissionRequested ? webPwaWarning : null,
        );
      }

      return const NotificationScheduleResult.bestEffortNotScheduled();
    }

    if (_shouldSkipPlugin) {
      return const NotificationScheduleResult.scheduled();
    }

    await initialize();
    if (!_initialized) {
      return const NotificationScheduleResult.failed();
    }

    try {
      await _plugin.cancel(testReminderId);
      await _plugin.zonedSchedule(
        testReminderId,
        'Lembrete de teste',
        'Este é um lembrete de teste do EMControle.',
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
        payload: 'debug_test_reminder',
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
  const NotificationPermissionResult({
    required this.granted,
    this.message,
    this.isBestEffort = false,
  });

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
  final bool isBestEffort;
}

class NotificationScheduleResult {
  const NotificationScheduleResult({
    required this.scheduled,
    this.message,
    this.isBestEffort = false,
  });

  const NotificationScheduleResult.scheduled({
    String? message,
    bool isBestEffort = false,
  }) : this(scheduled: true, message: message, isBestEffort: isBestEffort);

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

  const NotificationScheduleResult.bestEffortNotScheduled()
    : this(
        scheduled: false,
        isBestEffort: true,
        message:
            'Não foi possível agendar o lembrete no navegador. Os lembretes Web/PWA continuam em melhor esforço.',
      );

  final bool scheduled;
  final String? message;
  final bool isBestEffort;
}
