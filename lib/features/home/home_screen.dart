import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../treatment/domain/application_eligibility_service.dart';
import '../treatment/domain/application_record.dart';
import '../treatment/domain/medication.dart';
import '../treatment/domain/treatment_session_store.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: treatmentSessionStore,
      builder: (context, _) {
        final medication = treatmentSessionStore.medication;
        if (medication == null) {
          return const _NoTreatmentDashboard();
        }

        return _ActiveTreatmentPanel(medication: medication);
      },
    );
  }
}

class _NoTreatmentDashboard extends StatelessWidget {
  const _NoTreatmentDashboard();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  'assets/images/brand/emcontrole_mark.svg',
                  height: 64,
                  semanticsLabel: 'Marca EMControle',
                ),
                const SizedBox(height: 16),
                Text(
                  'Comece seu acompanhamento',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Cadastre seu medicamento principal para organizar sua rotina com mais tranquilidade.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => context.go(AppRoutes.treatment),
                  icon: const Icon(Icons.medication_outlined),
                  label: const Text('Começar acompanhamento'),
                ),
              ],
            ),
          ),
        ),
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
    final scheduledAt = treatmentSessionStore.currentScheduledAt;
    final latestRecord = treatmentSessionStore.records.lastOrNull;

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TreatmentSummaryCard(
                medication: medication,
                userName: treatmentSessionStore.userName,
              ),
              const SizedBox(height: 12),
              _NextApplicationCard(
                medication: medication,
                scheduledAt: scheduledAt,
                eligibility: eligibility,
                onRegister: eligibility.canRegister
                    ? () => _confirmRegistration(context, medication)
                    : null,
                child: isInjectable && currentPoint != null
                    ? _CurrentApplicationPointContent(
                        medication: medication,
                        point: currentPoint,
                      )
                    : _TreatmentTrackingContent(medication: medication),
              ),
              const SizedBox(height: 12),
              _LastApplicationCard(
                record: latestRecord,
                medication: medication,
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
          title: Text(_registrationDialogTitle(medication)),
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
              const SizedBox(height: 16),
              const Text(
                'Siga sempre a prescrição e orientação da sua equipe de saúde.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(_confirmationTitle(medication)),
            ),
          ],
        );
      },
    );

    if (!context.mounted || confirmed != true) {
      return;
    }

    unawaited(
      treatmentSessionStore.registerApplication().then<void>(
        (_) {
          if (!context.mounted) {
            return;
          }

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(_successMessage(medication))),
            );
        },
        onError: (Object error, StackTrace stackTrace) {
          if (!context.mounted) {
            return;
          }

          final message = error is StateError
              ? error.message
              : error.toString();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message)));
        },
      ),
    );
  }

  String _confirmationTitle(Medication medication) {
    return switch (medication.administrationType) {
      AdministrationType.oral => 'Confirmar uso',
      AdministrationType.infusion => 'Confirmar tratamento',
      AdministrationType.injectable => 'Confirmar aplicação',
    };
  }

  String _registrationDialogTitle(Medication medication) {
    return switch (medication.administrationType) {
      AdministrationType.oral => 'Registrar uso',
      AdministrationType.infusion => 'Registrar tratamento',
      AdministrationType.injectable => 'Registrar aplicação',
    };
  }

  String _confirmationQuestion(Medication medication) {
    return switch (medication.administrationType) {
      AdministrationType.injectable =>
        'Você aplicou o medicamento no local sugerido?',
      AdministrationType.oral => 'Você tomou este medicamento?',
      AdministrationType.infusion => 'Você realizou este tratamento?',
    };
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
            '$message\n\nSiga sempre a prescrição e orientação da sua equipe de saúde.',
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

  String _successMessage(Medication medication) {
    return switch (medication.administrationType) {
      AdministrationType.oral => 'Uso registrado com sucesso',
      AdministrationType.infusion => 'Tratamento registrado com sucesso',
      AdministrationType.injectable => 'Aplicação registrada com sucesso',
    };
  }
}

class _TreatmentSummaryCard extends StatelessWidget {
  const _TreatmentSummaryCard({
    required this.medication,
    required this.userName,
  });

  final Medication medication;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final greetingName = userName?.trim();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greetingName == null || greetingName.isEmpty
                  ? 'Meu tratamento'
                  : 'Olá, $greetingName',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              medication.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            _InfoRow(
              icon: Icons.science_outlined,
              label: 'Princípio ativo',
              value: medication.activeIngredient,
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.repeat_outlined,
              label: 'Frequência',
              value: medication.frequencyLabel,
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.route_outlined,
              label: 'Via',
              value:
                  '${medication.administrationType.label} · ${medication.route}',
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => context.go(AppRoutes.treatment),
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Editar tratamento'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextApplicationCard extends StatelessWidget {
  const _NextApplicationCard({
    required this.medication,
    required this.scheduledAt,
    required this.eligibility,
    required this.onRegister,
    required this.child,
  });

  final Medication medication;
  final DateTime? scheduledAt;
  final ApplicationEligibilityResult eligibility;
  final VoidCallback? onRegister;
  final Widget child;

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
              _nextTitle(medication),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              scheduledAt == null
                  ? 'Próxima data deve ser acompanhada conforme orientação médica.'
                  : _formatExpectedDateTime(scheduledAt!),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            child,
            const SizedBox(height: 16),
            _EligibilityMessage(result: eligibility),
            const SizedBox(height: 16),
            FilledButton.icon(
              key: const Key('register-application-button'),
              onPressed: onRegister,
              icon: const Icon(Icons.check_circle_outline),
              label: Text(_registerButtonLabel(medication)),
            ),
          ],
        ),
      ),
    );
  }

  String _nextTitle(Medication medication) {
    return switch (medication.administrationType) {
      AdministrationType.oral => 'Próximo uso',
      AdministrationType.infusion => 'Próximo tratamento',
      AdministrationType.injectable => 'Próxima aplicação',
    };
  }
}

class _CurrentApplicationPointContent extends StatelessWidget {
  const _CurrentApplicationPointContent({
    required this.medication,
    required this.point,
  });

  final Medication medication;
  final ApplicationPoint point;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final location = _formatPointDescription(point);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Próximo local de aplicação',
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              location,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            _PointLabelChip(label: point.label),
          ],
        ),
        const SizedBox(height: 16),
        _ApplicationPointIllustration(point: point),
        const SizedBox(height: 12),
        _ApplicationPointGuidance(
          helperText: point.helperText,
          safetyNote: medication.safetyNote,
        ),
      ],
    );
  }
}

class _PointLabelChip extends StatelessWidget {
  const _PointLabelChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ApplicationPointGuidance extends StatelessWidget {
  const _ApplicationPointGuidance({
    required this.helperText,
    required this.safetyNote,
  });

  final String helperText;
  final String safetyNote;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(helperText),
            const SizedBox(height: 8),
            Text(
              safetyNote,
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

class _TreatmentTrackingContent extends StatelessWidget {
  const _TreatmentTrackingContent({required this.medication});

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(
          icon: Icons.category_outlined,
          label: 'Tipo',
          value: medication.administrationType.label,
        ),
        const SizedBox(height: 8),
        _InfoRow(
          icon: Icons.medication_liquid_outlined,
          label: 'Rotina',
          value: medication.scheduleDescription,
        ),
        const SizedBox(height: 12),
        const Text(
          'Siga sempre a prescrição e orientação da sua equipe de saúde.',
        ),
      ],
    );
  }
}

class _LastApplicationCard extends StatelessWidget {
  const _LastApplicationCard({required this.record, required this.medication});

  final ApplicationRecord? record;
  final Medication medication;

  @override
  Widget build(BuildContext context) {
    final latestRecord = record;
    final lastLabel = switch (medication.administrationType) {
      AdministrationType.oral => 'Último uso',
      AdministrationType.infusion => 'Último tratamento',
      AdministrationType.injectable => 'Última aplicação',
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lastLabel, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            if (latestRecord == null)
              Text(
                'Nenhum registro ainda.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              )
            else
              Text(_formatLastApplication(latestRecord, medication)),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: colorScheme.primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(value),
            ],
          ),
        ),
      ],
    );
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
          '${_eligibilityLabel(result.status)} · ${result.message}',
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

class _ApplicationPointIllustration extends StatelessWidget {
  const _ApplicationPointIllustration({required this.point});

  final ApplicationPoint point;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final height = _responsiveIllustrationHeight(constraints.maxWidth);

        return FutureBuilder(
          future: rootBundle.load(point.imageAssetPath),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return _MissingApplicationPointIllustration(
                point: point,
                height: height,
              );
            }

            if (snapshot.connectionState != ConnectionState.done) {
              return SizedBox(
                height: height,
                child: const Center(child: CircularProgressIndicator()),
              );
            }

            return Material(
              color: colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: colorScheme.outlineVariant),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _showApplicationPointPreview(context),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Semantics(
                    label: 'Ilustração do ponto de aplicação: ${point.label}',
                    image: true,
                    button: true,
                    child: _applicationPointAsset(point, height: height),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  double _responsiveIllustrationHeight(double maxWidth) {
    if (maxWidth >= 600) {
      return (maxWidth * 0.7).clamp(420.0, 480.0);
    }

    return (maxWidth * 0.9).clamp(280.0, 340.0);
  }

  void _showApplicationPointPreview(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return Dialog.fullscreen(
          child: Scaffold(
            backgroundColor: colorScheme.surface,
            appBar: AppBar(
              title: Text(point.label),
              leading: IconButton(
                tooltip: 'Fechar',
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: InteractiveViewer(
                    minScale: 1,
                    maxScale: 4,
                    child: _applicationPointAsset(point),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _applicationPointAsset(ApplicationPoint point, {double? height}) {
    final path = point.imageAssetPath.toLowerCase();

    if (path.endsWith('.png')) {
      return Image.asset(
        point.imageAssetPath,
        height: height,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      );
    }

    return SvgPicture.asset(
      point.imageAssetPath,
      height: height,
      fit: BoxFit.contain,
    );
  }
}

class _MissingApplicationPointIllustration extends StatelessWidget {
  const _MissingApplicationPointIllustration({
    required this.point,
    required this.height,
  });

  final ApplicationPoint point;
  final double height;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: height,
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

String _registerButtonLabel(Medication medication) {
  return switch (medication.administrationType) {
    AdministrationType.oral => 'Registrar uso do medicamento',
    AdministrationType.infusion => 'Registrar tratamento',
    AdministrationType.injectable => 'Registrar aplicação',
  };
}

String _eligibilityLabel(ApplicationEligibilityStatus status) {
  return switch (status) {
    ApplicationEligibilityStatus.eligible => 'Em dia',
    ApplicationEligibilityStatus.early => 'Antes do horário previsto',
    ApplicationEligibilityStatus.late => 'Fora da janela prevista',
    ApplicationEligibilityStatus.duplicate => 'Já registrado',
    ApplicationEligibilityStatus.tooSoon => 'Intervalo mínimo',
    ApplicationEligibilityStatus.scheduleAdjustment =>
      'Fora da janela prevista',
    ApplicationEligibilityStatus.notApplicable => 'Em dia',
  };
}

String _formatLastApplication(ApplicationRecord record, Medication medication) {
  final prefix = switch (medication.administrationType) {
    AdministrationType.oral => 'Último uso',
    AdministrationType.infusion => 'Último tratamento',
    AdministrationType.injectable => 'Última aplicação',
  };
  final details = [
    '$prefix: ${_formatRelativeDateTime(record.registeredAt)}',
    record.medicationName,
    if (record.applicationPointLabel != null) record.applicationPointLabel!,
    _registrationStatusLabel(record.registrationStatus),
  ];

  return details.where((detail) => detail.trim().isNotEmpty).join(' · ');
}

String _registrationStatusLabel(ApplicationRegistrationStatus status) {
  return switch (status) {
    ApplicationRegistrationStatus.onTime => 'Em dia',
    ApplicationRegistrationStatus.early => 'Antes do horário previsto',
    ApplicationRegistrationStatus.late => 'Fora da janela prevista',
    ApplicationRegistrationStatus.scheduleAdjustment =>
      'Fora da janela prevista',
  };
}

String _formatRelativeDateTime(DateTime value) {
  final now = DateTime.now();
  final date = _sameLocalDate(value, now)
      ? 'hoje'
      : _sameLocalDate(value, now.subtract(const Duration(days: 1)))
      ? 'ontem'
      : _formatDate(value);

  return '$date às ${_formatTime(value)}';
}

String _formatDateTime(DateTime value) {
  return '${_formatDate(value)} às ${_formatTime(value)}';
}

String _formatExpectedDateTime(DateTime value) {
  final now = DateTime.now();
  if (_sameLocalDate(value, now)) {
    return 'hoje às ${_formatTime(value)}';
  }
  if (_sameLocalDate(value, now.add(const Duration(days: 1)))) {
    return 'amanhã às ${_formatTime(value)}';
  }

  return _formatDateTime(value);
}

String _formatDate(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  return '$day/$month/${value.year}';
}

String _formatTime(DateTime value) {
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

bool _sameLocalDate(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
