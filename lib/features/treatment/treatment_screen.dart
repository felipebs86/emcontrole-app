import 'package:flutter/material.dart';

import '../../core/app_shell.dart';
import '../../core/placeholder_content.dart';

class TreatmentScreen extends StatelessWidget {
  const TreatmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShell(
      title: 'Tratamento',
      selectedIndex: 1,
      child: PlaceholderContent(
        icon: Icons.medication_outlined,
        title: 'Tratamento',
        description:
            'Esta área será usada para organizar informações do tratamento já definido com seu profissional de saúde.',
      ),
    );
  }
}
