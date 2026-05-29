import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class EMControleApp extends StatelessWidget {
  const EMControleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EMControle',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
