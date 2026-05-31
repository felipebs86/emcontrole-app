import 'package:go_router/go_router.dart';

import '../core/app_shell.dart';
import '../features/diary/diary_screen.dart';
import '../features/history/history_screen.dart';
import '../features/home/home_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/treatment/treatment_screen.dart';
import '../features/timeline/timeline_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell.navigation(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              builder: (context, state) => const HistoryScreen(),
              routes: [
                GoRoute(
                  path: ':recordId',
                  builder: (context, state) => HistoryRecordDetailsScreen(
                    recordId: state.pathParameters['recordId'] ?? '',
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/diary',
              builder: (context, state) => const DiaryScreen(),
              routes: [
                GoRoute(
                  path: 'new',
                  builder: (context, state) => const CreateDiaryEntryScreen(),
                ),
                GoRoute(
                  path: ':entryId',
                  builder: (context, state) => DiaryEntryDetailsScreen(
                    entryId: state.pathParameters['entryId'] ?? '',
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/timeline',
              builder: (context, state) => const TimelineScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/treatment',
      builder: (context, state) => const TreatmentScreen(),
    ),
  ],
);
