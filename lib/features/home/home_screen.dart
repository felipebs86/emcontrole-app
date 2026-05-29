import 'package:flutter/material.dart';

import '../../core/app_shell.dart';
import '../../core/placeholder_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      title: 'EMControle',
      selectedIndex: 0,
      child: PlaceholderContent(
        icon: Icons.local_florist_outlined,
        title: 'Bem-vindo ao EMControle',
        description:
            'Um espaço simples para organizar sua rotina de cuidado conforme as orientações da sua equipe de saúde.',
      ),
    );
  }
}
