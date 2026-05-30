import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_shell.dart';
import '../../core/placeholder_content.dart';
import '../treatment/domain/application_eligibility_service.dart';
import '../treatment/domain/medication.dart';
import '../treatment/domain/treatment_session_store.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'EMControle',
      selectedIndex: 0,
      child: AnimatedBuilder(
        animation: treatmentSessionStore,
        builder: (context, _) {
          final medication = treatmentSessionStore.medication;
          if (medication == null) {
            return const PlaceholderContent(
              icon: Icons.local_florist_outlined,
              title: 'Bem-vindo ao EMControle',
              description:
                  'Um espaço simples para organizar sua rotina de cuidado conforme as orientações da sua equipe de saúde.',
            );
          }

          return _ActiveTreatmentPanel(medication: medication);
        },
      ),
    );
  }
}

class _ActiveTreatmentPanel extends StatelessWidget {
  const _ActiveTreatmentPanel({required this.medication});

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    final currentPoint = treatmentSessionStore.currentApplicationPoint;
    final eligibility = treatmentSessionStore.evaluateEligibility();
    final isInjectable = medication.requiresApplicationSite;

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                medication.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                medication.frequencyLabel,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              if (isInjectable && currentPoint != null)
                _CurrentApplicationPointCard(
                  medication: medication,
                  point: currentPoint,
                )
              else
                _TreatmentTrackingCard(medication: medication),
              const SizedBox(height: 12),
              _EligibilityMessage(result: eligibility),
              const SizedBox(height: 16),
              FilledButton.icon(
                key: const Key('register-application-button'),
                onPressed: eligibility.canRegister
                    ? () => _confirmRegistration(context, medication)
                    : null,
                icon: const Icon(Icons.check_circle_outline),
                label: Text(_registerButtonLabel(medication)),
              ),
              const SizedBox(height: 12),
              Text(
                'Registros nesta sessão: ${treatmentSessionStore.records.length}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmRegistration(
    BuildContext context,
    Medication medication,
  ) async {
    final currentPoint = treatmentSessionStore.currentApplicationPoint;
    final eligibility = treatmentSessionStore.evaluateEligibility();
    if (!eligibility.canRegister) {
      return;
    }

    if (_requiresWarning(eligibility.status)) {
      final acceptedWarning = await _showEligibilityWarning(
        context,
        eligibility.message,
      );
      if (!context.mounted || !acceptedWarning) {
        return;
      }
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar aplicação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_confirmationQuestion(medication)),
              const SizedBox(height: 16),
              Text('Medicamento: ${medication.name}'),
              if (currentPoint != null) ...[
                const SizedBox(height: 8),
                Text('Local: ${currentPoint.label}'),
                Text(_formatPointDescription(currentPoint)),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirmar aplicação'),
            ),
          ],
        );
      },
    );

    if (!context.mounted || confirmed != true) {
      return;
    }

    treatmentSessionStore.registerApplication();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Aplicação registrada com sucesso')),
      );
  }

  String _confirmationQuestion(Medication medication) {
    if (medication.requiresApplicationSite) {
      return 'Você aplicou o medicamento no local sugerido?';
    }

    return 'Você deseja registrar este tratamento?';
  }

  bool _requiresWarning(ApplicationEligibilityStatus status) {
    return status == ApplicationEligibilityStatus.early ||
        status == ApplicationEligibilityStatus.late ||
        status == ApplicationEligibilityStatus.scheduleAdjustment;
  }

  Future<bool> _showEligibilityWarning(
    BuildContext context,
    String message,
  ) async {
    final accepted = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: Text(
            '$message\n\nSiga sempre a orientação da sua equipe de saúde.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Continuar'),
            ),
          ],
        );
      },
    );

    return accepted ?? false;
  }

  String _registerButtonLabel(Medication medication) {
    if (medication.requiresApplicationSite) {
      return 'Registrar aplicação';
    }

    return switch (medication.administrationType) {
      AdministrationType.oral => 'Registrar uso do medicamento',
      AdministrationType.infusion => 'Registrar tratamento',
      AdministrationType.injectable => 'Registrar aplicação',
    };
  }
}

class _EligibilityMessage extends StatelessWidget {
  const _EligibilityMessage({required this.result});

  final ApplicationEligibilityResult result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDuplicate = result.status == ApplicationEligibilityStatus.duplicate;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDuplicate
            ? colorScheme.errorContainer
            : colorScheme.surfaceContainerLow,
        border: Border.all(
          color: isDuplicate ? colorScheme.error : colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          result.message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isDuplicate
                ? colorScheme.onErrorContainer
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _CurrentApplicationPointCard extends StatelessWidget {
  const _CurrentApplicationPointCard({
    required this.medication,
    required this.point,
  });

  final Medication medication;
  final ApplicationPoint point;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Próximo local de aplicação',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(point.label, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(_formatPointDescription(point)),
            const SizedBox(height: 16),
            _ApplicationPointIllustration(point: point),
            const SizedBox(height: 12),
            Text(point.helperText),
            const SizedBox(height: 8),
            Text(
              medication.safetyNote,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TreatmentTrackingCard extends StatelessWidget {
  const _TreatmentTrackingCard({required this.medication});

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Acompanhamento do tratamento',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text('Tipo: ${medication.administrationType.label}'),
            Text('Via: ${medication.route}'),
            Text('Frequência: ${medication.frequencyLabel}'),
          ],
        ),
      ),
    );
  }
}

class _ApplicationPointIllustration extends StatelessWidget {
  const _ApplicationPointIllustration({required this.point});

  final ApplicationPoint point;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.load(point.imageAssetPath),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _MissingApplicationPointIllustration(point: point);
        }

        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Semantics(
          label: 'Ilustração do ponto de aplicação: ${point.label}',
          image: true,
          child: SvgPicture.asset(
            point.imageAssetPath,
            height: 180,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}

class _MissingApplicationPointIllustration extends StatelessWidget {
  const _MissingApplicationPointIllustration({required this.point});

  final ApplicationPoint point;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(child: Text(point.label)),
    );
  }
}

String _formatPointDescription(ApplicationPoint point) {
  final parent = point.parentSiteLabel.toLowerCase();
  final side = point.side.toLowerCase();
  final sideWithoutRepeatedDirection = switch (side) {
    final value when parent.contains('direito') || parent.contains('direita') =>
      value.replaceFirst('direita ', '').replaceFirst('direito ', ''),
    final value
        when parent.contains('esquerdo') || parent.contains('esquerda') =>
      value.replaceFirst('esquerda ', '').replaceFirst('esquerdo ', ''),
    final value => value,
  };

  return '${point.parentSiteLabel} $sideWithoutRepeatedDirection';
}
