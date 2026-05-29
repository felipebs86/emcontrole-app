import 'package:flutter/material.dart';

import '../../core/app_shell.dart';
import '../../core/placeholder_content.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      title: 'Histórico',
      selectedIndex: 3,
      child: PlaceholderContent(
        icon: Icons.history_outlined,
        title: 'Histórico',
        description:
            'O histórico será apresentado aqui em uma etapa futura, mantendo os dados apenas no aparelho.',
      ),
    );
  }
}
