import 'package:flutter/material.dart';

import '../../core/app_shell.dart';
import '../../core/placeholder_content.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      title: 'Ajustes',
      selectedIndex: 4,
      child: PlaceholderContent(
        icon: Icons.settings_outlined,
        title: 'Ajustes',
        description:
            'Preferências básicas do aplicativo aparecerão aqui quando a especificação correspondente for implementada.',
      ),
    );
  }
}
