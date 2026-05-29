import 'package:flutter/material.dart';

import '../../core/app_shell.dart';
import '../../core/placeholder_content.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      title: 'Diário',
      selectedIndex: 2,
      child: PlaceholderContent(
        icon: Icons.edit_note_outlined,
        title: 'Diário',
        description:
            'Aqui ficarão anotações pessoais para acompanhar seu dia a dia de forma privada no dispositivo.',
      ),
    );
  }
}
