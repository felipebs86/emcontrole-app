import 'package:go_router/go_router.dart';

import '../features/diary/diary_screen.dart';
import '../features/history/history_screen.dart';
import '../features/home/home_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/treatment/treatment_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/treatment',
      builder: (context, state) => const TreatmentScreen(),
    ),
    GoRoute(path: '/diary', builder: (context, state) => const DiaryScreen()),
    GoRoute(
      path: '/diary/new',
      builder: (context, state) => const CreateDiaryEntryScreen(),
    ),
    GoRoute(
      path: '/diary/:entryId',
      builder: (context, state) => DiaryEntryDetailsScreen(
        entryId: state.pathParameters['entryId'] ?? '',
      ),
    ),
    GoRoute(
      path: '/history',
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      path: '/history/:recordId',
      builder: (context, state) => HistoryRecordDetailsScreen(
        recordId: state.pathParameters['recordId'] ?? '',
      ),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
