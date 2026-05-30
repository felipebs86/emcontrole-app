import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'core/notifications/local_notification_service.dart';
import 'features/treatment/domain/treatment_session_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localNotificationService.initialize();
  await treatmentSessionStore.load();
  runApp(const EMControleApp());
}
