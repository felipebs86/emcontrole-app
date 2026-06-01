import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_shell.dart';
import '../../core/database/app_database.dart';
import '../../core/notifications/local_notification_service.dart';
import 'data/medication_catalog_data_source.dart';
import 'data/medication_repository.dart';
import 'data/treatment_repository.dart';
import 'domain/application_rotation_service.dart';
import 'domain/medication.dart';
import 'domain/treatment_session_store.dart';

class TreatmentScreen extends StatefulWidget {
  const TreatmentScreen({super.key});

  @override
  State<TreatmentScreen> createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  final _medicationRepository = const MedicationRepository(
    MedicationCatalogDataSource(),
  );
  final _rotationService = const ApplicationRotationService();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  late final List<Medication> _medications;
  Medication? _selectedMedication;
  DateTime? _startDate;
  TimeOfDay? _applicationTime;
  String? _initialPointId;
  bool _enableReminders = false;
  bool _showValidationErrors = false;
  bool _hasUserEdited = false;
  bool _isApplyingHydration = false;
  int _formSeed = 0;
  _TreatmentSetupData? _submittedSetup;

  @override
  void initState() {
    super.initState();
    _medications = _medicationRepository.getAll();
    _nameController.addListener(_handleNameChanged);
    _hydrateFromSessionStore();
    unawaited(_hydrateFromPersistedTreatment());
  }

  @override
  void dispose() {
    _nameController.removeListener(_handleNameChanged);
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Tratamento',
      selectedIndex: 0,
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Configure seu tratamento',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Preencha as informações que você já recebeu da sua equipe de saúde.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                KeyedSubtree(
                  key: ValueKey(_formSeed),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          key: const Key('treatment-name-field'),
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: _requiredValidator('Informe seu nome.'),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<Medication>(
                          key: const Key('treatment-medication-field'),
                          initialValue: _selectedMedication,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Medicamento',
                            prefixIcon: Icon(Icons.medication_outlined),
                          ),
                          items: _medications.map((medication) {
                            return DropdownMenuItem(
                              value: medication,
                              child: _MedicationOption(medication: medication),
                            );
                          }).toList(),
                          onChanged: (medication) {
                            setState(() {
                              _hasUserEdited = true;
                              _selectedMedication = medication;
                              _initialPointId = null;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Selecione um medicamento.';
                            }

                            return null;
                          },
                        ),
                        if (_selectedMedication != null) ...[
                          const SizedBox(height: 12),
                          _MedicationDetails(medication: _selectedMedication!),
                        ],
                        const SizedBox(height: 16),
                        _PickerField(
                          key: const Key('treatment-start-date-field'),
                          label: 'Data da primeira aplicação',
                          value: _startDate == null
                              ? null
                              : _formatDate(_startDate!),
                          icon: Icons.calendar_today_outlined,
                          errorText: _showValidationErrors && _startDate == null
                              ? 'Informe a data da primeira aplicação.'
                              : null,
                          onTap: _selectStartDate,
                        ),
                        const SizedBox(height: 16),
                        _PickerField(
                          key: const Key('treatment-application-time-field'),
                          label: 'Horário da aplicação',
                          value: _applicationTime == null
                              ? null
                              : _formatTime(_applicationTime!),
                          icon: Icons.schedule_outlined,
                          errorText:
                              _showValidationErrors && _applicationTime == null
                              ? 'Informe o horário da aplicação.'
                              : null,
                          onTap: _selectApplicationTime,
                        ),
                        const SizedBox(height: 16),
                        if (_selectedMedication?.requiresApplicationSite ??
                            false) ...[
                          DropdownButtonFormField<String>(
                            key: const Key('treatment-site-field'),
                            initialValue: _initialPointId,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Ponto inicial de aplicação',
                              prefixIcon: Icon(
                                Icons.accessibility_new_outlined,
                              ),
                            ),
                            items: _applicationPointOptions.map((point) {
                              return DropdownMenuItem(
                                value: point.id,
                                child: Text(_formatPointOption(point)),
                              );
                            }).toList(),
                            onChanged: (pointId) {
                              setState(() {
                                _hasUserEdited = true;
                                _initialPointId = pointId;
                              });
                            },
                            validator: (pointId) {
                              if (pointId == null) {
                                return 'Selecione o ponto inicial de aplicação.';
                              }

                              return null;
                            },
                            hint: const Text('Selecionar'),
                          ),
                          if (_selectedInitialPoint != null) ...[
                            const SizedBox(height: 12),
                            _ApplicationPointCard(
                              medication: _selectedMedication!,
                              point: _selectedInitialPoint!,
                            ),
                          ],
                          if (_nextApplicationPoint != null) ...[
                            const SizedBox(height: 12),
                            _NextApplicationPointPreview(
                              point: _nextApplicationPoint!,
                            ),
                          ],
                          const SizedBox(height: 16),
                        ],
                        SwitchListTile(
                          key: const Key('treatment-reminders-switch'),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          title: const Text('Ativar lembretes'),
                          subtitle: const Text(
                            'Receba uma notificação local no horário previsto.',
                          ),
                          value: _enableReminders,
                          onChanged: (value) {
                            unawaited(_setRemindersEnabled(value));
                          },
                        ),
                        const SizedBox(height: 24),
                        FilledButton.icon(
                          key: const Key('treatment-submit-button'),
                          onPressed: _submit,
                          icon: const Icon(Icons.check),
                          label: const Text('Salvar configuração'),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_submittedSetup != null) ...[
                  const SizedBox(height: 24),
                  _SubmittedSetupCard(setup: _submittedSetup!),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNameChanged() {
    if (!_isApplyingHydration) {
      _hasUserEdited = true;
    }
  }

  void _hydrateFromSessionStore() {
    final storedMedication = treatmentSessionStore.medication;
    final scheduledAt = treatmentSessionStore.configuredScheduledAt;
    final userName = treatmentSessionStore.userName;
    if (storedMedication == null || scheduledAt == null || userName == null) {
      return;
    }
    final medication = _medications
        .where((medication) => medication.id == storedMedication.id)
        .firstOrNull;

    _applyHydratedTreatment(
      userName: userName,
      medication: medication,
      applicationPointId: treatmentSessionStore.currentApplicationPointId,
      scheduledAt: scheduledAt,
      remindersEnabled: treatmentSessionStore.remindersEnabled,
    );
  }

  Future<void> _hydrateFromPersistedTreatment() async {
    try {
      final snapshot = await TreatmentRepository(
        appDatabase,
      ).loadActiveTreatment();
      if (!mounted || snapshot == null || _hasUserEdited) {
        return;
      }

      final medication = _medications
          .where((medication) => medication.id == snapshot.medicationId)
          .firstOrNull;
      setState(() {
        _applyHydratedTreatment(
          userName: snapshot.userName,
          medication: medication,
          applicationPointId: snapshot.selectedApplicationPointId,
          scheduledAt: snapshot.scheduledAt,
          remindersEnabled: snapshot.remindersEnabled,
          rebuildFormFields: true,
        );
      });
    } catch (_) {
      return;
    }
  }

  void _applyHydratedTreatment({
    required String userName,
    required Medication? medication,
    required String? applicationPointId,
    required DateTime scheduledAt,
    required bool remindersEnabled,
    bool rebuildFormFields = false,
  }) {
    final restoredPointId = medication == null
        ? null
        : _rotationService.getPointById(medication, applicationPointId)?.id;

    _isApplyingHydration = true;
    _nameController.text = userName;
    _isApplyingHydration = false;
    _selectedMedication = medication;
    _initialPointId = restoredPointId;
    _startDate = DateTime(scheduledAt.year, scheduledAt.month, scheduledAt.day);
    _applicationTime = TimeOfDay(
      hour: scheduledAt.hour,
      minute: scheduledAt.minute,
    );
    _enableReminders = remindersEnabled;

    if (rebuildFormFields) {
      _formSeed += 1;
    }
  }

  String? Function(String?) _requiredValidator(String message) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }

      return null;
    };
  }

  List<ApplicationPoint> get _applicationPointOptions {
    final medication = _selectedMedication;
    if (medication == null) {
      return const [];
    }

    return _rotationService.getApplicationPoints(medication);
  }

  ApplicationPoint? get _selectedInitialPoint {
    final medication = _selectedMedication;
    if (medication == null) {
      return null;
    }

    return _rotationService.getPointById(medication, _initialPointId);
  }

  ApplicationPoint? get _nextApplicationPoint {
    final medication = _selectedMedication;
    if (medication == null || _initialPointId == null) {
      return null;
    }

    return _rotationService.getNextPoint(medication, _initialPointId);
  }

  String _formatPointOption(ApplicationPoint point) {
    return '${point.label} - ${_formatPointDescription(point)}';
  }

  static String _formatPointDescription(ApplicationPoint point) {
    final parent = point.parentSiteLabel.toLowerCase();
    final side = point.side.toLowerCase();
    final sideWithoutRepeatedDirection = switch (side) {
      final value
          when parent.contains('direito') || parent.contains('direita') =>
        value.replaceFirst('direita ', '').replaceFirst('direito ', ''),
      final value
          when parent.contains('esquerdo') || parent.contains('esquerda') =>
        value.replaceFirst('esquerda ', '').replaceFirst('esquerdo ', ''),
      final value => value,
    };

    return '${point.parentSiteLabel} $sideWithoutRepeatedDirection';
  }

  Future<void> _selectStartDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _startDate ?? now,
      firstDate: DateTime(now.year - 20),
      lastDate: DateTime(now.year + 20),
    );

    if (!mounted || selected == null) {
      return;
    }

    setState(() {
      _hasUserEdited = true;
      _startDate = selected;
    });
  }

  Future<void> _selectApplicationTime() async {
    final selected = await showTimePicker(
      context: context,
      initialTime: _applicationTime ?? TimeOfDay.now(),
    );

    if (!mounted || selected == null) {
      return;
    }

    setState(() {
      _hasUserEdited = true;
      _applicationTime = selected;
    });
  }

  Future<void> _setRemindersEnabled(bool value) async {
    if (!value) {
      setState(() {
        _hasUserEdited = true;
        _enableReminders = false;
      });
      return;
    }

    final permission = await localNotificationService.requestPermission();
    if (!mounted) {
      return;
    }

    if (!permission.granted) {
      setState(() {
        _hasUserEdited = true;
        _enableReminders = false;
      });
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              permission.message ??
                  'Não foi possível ativar os lembretes locais.',
            ),
          ),
        );
      return;
    }

    setState(() {
      _hasUserEdited = true;
      _enableReminders = true;
    });
  }

  Future<void> _submit() async {
    setState(() {
      _hasUserEdited = true;
      _showValidationErrors = true;
    });

    final formIsValid = _formKey.currentState?.validate() ?? false;
    if (!formIsValid || _startDate == null || _applicationTime == null) {
      return;
    }

    final setup = _TreatmentSetupData(
      name: _nameController.text.trim(),
      medication: _selectedMedication!,
      startDate: _startDate!,
      applicationTime: _applicationTime!,
      initialPoint: _selectedInitialPoint,
      nextPoint: _nextApplicationPoint,
      enableReminders: _enableReminders,
    );

    unawaited(
      treatmentSessionStore.configureTreatment(
        userName: setup.name,
        medication: setup.medication,
        initialApplicationPointId: setup.initialPoint?.id,
        scheduledAt: setup.scheduledAt,
        remindersEnabled: setup.enableReminders,
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _submittedSetup = setup;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Tratamento configurado com sucesso.')),
      );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.icon,
    required this.errorText,
    required this.onTap,
    super.key,
  });

  final String label;
  final String? value;
  final IconData icon;
  final String? errorText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          errorText: errorText,
          suffixIcon: const Icon(Icons.arrow_drop_down),
        ),
        child: Text(value ?? 'Selecionar'),
      ),
    );
  }
}

class _MedicationOption extends StatelessWidget {
  const _MedicationOption({required this.medication});

  final Medication medication;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${medication.name} - ${medication.administrationType.label}',
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _MedicationDetails extends StatelessWidget {
  const _MedicationDetails({required this.medication});

  final Medication medication;

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryLine(
              label: 'Princípio ativo',
              value: medication.activeIngredient,
            ),
            _SummaryLine(
              label: 'Tipo de administração',
              value: medication.administrationType.label,
            ),
            _SummaryLine(label: 'Frequência', value: medication.frequencyLabel),
            _SummaryLine(label: 'Via', value: medication.route),
            _SummaryLine(
              label: 'Orientação',
              value: medication.scheduleDescription,
            ),
            if (medication.helperText != null)
              _SummaryLine(label: 'Observação', value: medication.helperText!),
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

class _ApplicationPointCard extends StatelessWidget {
  const _ApplicationPointCard({required this.medication, required this.point});

  final Medication medication;
  final ApplicationPoint point;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final location = _TreatmentScreenState._formatPointDescription(point);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.accessibility_new_outlined,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Próximo local de aplicação',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                _PointLabelChip(label: point.label),
              ],
            ),
            const SizedBox(height: 16),
            _ApplicationPointIllustration(point: point),
            const SizedBox(height: 12),
            Text(
              medication.name,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            _ApplicationPointGuidance(
              helperText: point.helperText,
              safetyNote: medication.safetyNote,
            ),
          ],
        ),
      ),
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

class _NextApplicationPointPreview extends StatelessWidget {
  const _NextApplicationPointPreview({required this.point});

  final ApplicationPoint point;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.next_plan_outlined, color: colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prévia do próximo ponto',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${point.label} - ${_TreatmentScreenState._formatPointDescription(point)}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.accessibility_new_outlined,
                color: colorScheme.primary,
                size: 40,
              ),
              const SizedBox(height: 12),
              Text(
                point.label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                'Ilustração indisponível',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmittedSetupCard extends StatelessWidget {
  const _SubmittedSetupCard({required this.setup});

  final _TreatmentSetupData setup;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle_outline, color: colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Configuração salva em memória nesta sessão',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _SummaryLine(label: 'Nome', value: setup.name),
            _SummaryLine(label: 'Medicamento', value: setup.medication.name),
            _SummaryLine(
              label: 'Tipo de administração',
              value: setup.medication.administrationType.label,
            ),
            _SummaryLine(
              label: 'Frequência',
              value: setup.medication.frequencyLabel,
            ),
            _SummaryLine(label: 'Via', value: setup.medication.route),
            _SummaryLine(
              label: 'Orientação',
              value: setup.medication.scheduleDescription,
            ),
            _SummaryLine(
              label: 'Data da primeira aplicação',
              value: setup.formattedStartDate,
            ),
            _SummaryLine(
              label: 'Horário da aplicação',
              value: setup.formattedApplicationTime,
            ),
            if (setup.initialPoint != null)
              _SummaryLine(
                label: 'Ponto inicial de aplicação',
                value:
                    '${setup.initialPoint!.label} - ${setup.initialPoint!.parentSiteLabel}',
              ),
            if (setup.nextPoint != null)
              _SummaryLine(
                label: 'Próximo ponto previsto',
                value:
                    '${setup.nextPoint!.label} - ${setup.nextPoint!.parentSiteLabel}',
              ),
            _SummaryLine(
              label: 'Ativar lembretes',
              value: setup.enableReminders ? 'Sim' : 'Não',
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

class _TreatmentSetupData {
  const _TreatmentSetupData({
    required this.name,
    required this.medication,
    required this.startDate,
    required this.applicationTime,
    required this.initialPoint,
    required this.nextPoint,
    required this.enableReminders,
  });

  final String name;
  final Medication medication;
  final DateTime startDate;
  final TimeOfDay applicationTime;
  final ApplicationPoint? initialPoint;
  final ApplicationPoint? nextPoint;
  final bool enableReminders;

  String get formattedStartDate {
    final day = startDate.day.toString().padLeft(2, '0');
    final month = startDate.month.toString().padLeft(2, '0');
    return '$day/$month/${startDate.year}';
  }

  String get formattedApplicationTime {
    final hour = applicationTime.hour.toString().padLeft(2, '0');
    final minute = applicationTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  DateTime get scheduledAt {
    return DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      applicationTime.hour,
      applicationTime.minute,
    );
  }
}
