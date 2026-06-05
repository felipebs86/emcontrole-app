import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../core/branding_assets.dart';
import '../../core/notifications/local_notification_service.dart';
import '../treatment/domain/treatment_session_store.dart';
import 'domain/theme_preference_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                _AppearanceCard(),
                SizedBox(height: 16),
                _ReminderStatusCard(),
                SizedBox(height: 16),
                _AboutCard(),
                SizedBox(height: 16),
                _MedicalDisclaimerCard(),
                SizedBox(height: 16),
                _DataPrivacyCard(),
                SizedBox(height: 16),
                _VersionCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AppearanceCard extends StatelessWidget {
  const _AppearanceCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(
              icon: Icons.contrast_outlined,
              title: 'Aparência',
              description: 'Escolha como o EMControle acompanha o tema visual.',
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: themePreferenceController,
              builder: (context, _) {
                return SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.system,
                      icon: Icon(Icons.brightness_auto_outlined),
                      label: Text('Sistema'),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      icon: Icon(Icons.light_mode_outlined),
                      label: Text('Claro'),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      icon: Icon(Icons.dark_mode_outlined),
                      label: Text('Escuro'),
                    ),
                  ],
                  selected: {themePreferenceController.themeMode},
                  onSelectionChanged: (selected) {
                    themePreferenceController.setThemeMode(selected.single);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderStatusCard extends StatelessWidget {
  const _ReminderStatusCard();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: treatmentSessionStore,
      builder: (context, _) {
        final remindersEnabled = treatmentSessionStore.remindersEnabled;
        final hasTreatment = treatmentSessionStore.medication != null;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(
                  icon: Icons.notifications_outlined,
                  title: 'Lembretes',
                  description: _descriptionFor(hasTreatment),
                ),
                const SizedBox(height: 16),
                _StatusPill(
                  icon: remindersEnabled
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_off_outlined,
                  label: remindersEnabled ? 'Ativados' : 'Desativados',
                ),
                if (kIsWeb) ...[
                  const SizedBox(height: 16),
                  Text(
                    LocalNotificationService.webPwaWarning,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (kDebugMode) ...[
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () {
                      unawaited(_scheduleDebugTestReminder(context));
                    },
                    icon: const Icon(Icons.timer_outlined),
                    label: const Text('Testar lembrete em 1 min'),
                  ),
                ],
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => context.go(AppRoutes.treatment),
                  icon: const Icon(Icons.medication_outlined),
                  label: Text(
                    hasTreatment
                        ? 'Alterar em Tratamento'
                        : 'Configurar tratamento',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _descriptionFor(bool hasTreatment) {
    if (kIsWeb) {
      return hasTreatment
          ? 'Status dos lembretes do tratamento ativo. Na Web/PWA, o suporte funciona em melhor esforço.'
          : 'Configure um tratamento para usar lembretes. Na Web/PWA, o suporte funciona em melhor esforço.';
    }

    return hasTreatment
        ? 'Status dos lembretes locais do tratamento ativo.'
        : 'Configure um tratamento para usar lembretes locais.';
  }

  Future<void> _scheduleDebugTestReminder(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final permission = await localNotificationService.requestPermission();
    final result = await localNotificationService.scheduleDebugTestReminder();
    if (!context.mounted) {
      return;
    }

    final message = result.scheduled
        ? 'Lembrete de teste agendado para 1 minuto.'
        : result.message ?? permission.message ?? 'Não foi possível agendar.';

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              BrandingAssets.logoFull(context),
              height: 86,
              fit: BoxFit.contain,
              semanticLabel: 'EMControle',
            ),
            const SizedBox(height: 16),
            Text(
              'EMControle',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'EMControle ajuda pessoas com Esclerose Múltipla a acompanhar tratamento, aplicações, lembretes e registros pessoais de sintomas.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicalDisclaimerCard extends StatelessWidget {
  const _MedicalDisclaimerCard();

  @override
  Widget build(BuildContext context) {
    return const _InfoCard(
      icon: Icons.health_and_safety_outlined,
      title: 'Aviso médico',
      description:
          'Este aplicativo não substitui orientação médica. Siga sempre a prescrição e as recomendações da sua equipe de saúde.',
    );
  }
}

class _DataPrivacyCard extends StatelessWidget {
  const _DataPrivacyCard();

  @override
  Widget build(BuildContext context) {
    return const _InfoCard(
      icon: Icons.phonelink_lock_outlined,
      title: 'Dados e privacidade',
      description:
          'Seus dados ficam armazenados apenas neste dispositivo. O EMControle não envia dados para servidores, não usa conta online e não possui sincronização em nuvem nesta versão.',
    );
  }
}

class _VersionCard extends StatelessWidget {
  const _VersionCard();

  @override
  Widget build(BuildContext context) {
    return const _InfoCard(
      icon: Icons.info_outline,
      title: 'Versão',
      description: 'Versão 1.0.0',
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: _SectionHeader(
          icon: icon,
          title: title,
          description: description,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          child: Icon(icon),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(label, style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
