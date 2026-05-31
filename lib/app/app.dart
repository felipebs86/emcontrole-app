import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';
import '../features/settings/domain/theme_preference_controller.dart';

class EMControleApp extends StatelessWidget {
  const EMControleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themePreferenceController,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'EMControle',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themePreferenceController.themeMode,
          routerConfig: appRouter,
        );
      },
    );
  }
}
