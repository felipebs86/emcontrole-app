import 'package:flutter/material.dart';

import '../../core/app_shell.dart';

class TreatmentScreen extends StatefulWidget {
  const TreatmentScreen({super.key});

  @override
  State<TreatmentScreen> createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _medicationController = TextEditingController();
  final _siteController = TextEditingController();

  DateTime? _startDate;
  TimeOfDay? _applicationTime;
  bool _enableReminders = false;
  bool _showValidationErrors = false;
  _TreatmentSetupData? _submittedSetup;

  @override
  void dispose() {
    _nameController.dispose();
    _medicationController.dispose();
    _siteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Tratamento',
      selectedIndex: 1,
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
                Form(
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
                      TextFormField(
                        key: const Key('treatment-medication-field'),
                        controller: _medicationController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Medicamento',
                          prefixIcon: Icon(Icons.medication_outlined),
                        ),
                        validator: _requiredValidator(
                          'Informe o nome do medicamento.',
                        ),
                      ),
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
                      TextFormField(
                        key: const Key('treatment-site-field'),
                        controller: _siteController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'Local inicial de aplicação',
                          prefixIcon: Icon(Icons.place_outlined),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        key: const Key('treatment-reminders-switch'),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        title: const Text('Ativar lembretes'),
                        subtitle: const Text(
                          'Nenhuma notificação será agendada nesta etapa.',
                        ),
                        value: _enableReminders,
                        onChanged: (value) {
                          setState(() {
                            _enableReminders = value;
                          });
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

  String? Function(String?) _requiredValidator(String message) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }

      return null;
    };
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
      _applicationTime = selected;
    });
  }

  void _submit() {
    setState(() {
      _showValidationErrors = true;
    });

    final formIsValid = _formKey.currentState?.validate() ?? false;
    if (!formIsValid || _startDate == null || _applicationTime == null) {
      return;
    }

    final setup = _TreatmentSetupData(
      name: _nameController.text.trim(),
      medication: _medicationController.text.trim(),
      startDate: _startDate!,
      applicationTime: _applicationTime!,
      initialSite: _siteController.text.trim(),
      enableReminders: _enableReminders,
    );

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
            _SummaryLine(label: 'Medicamento', value: setup.medication),
            _SummaryLine(
              label: 'Data da primeira aplicação',
              value: setup.formattedStartDate,
            ),
            _SummaryLine(
              label: 'Horário da aplicação',
              value: setup.formattedApplicationTime,
            ),
            if (setup.initialSite.isNotEmpty)
              _SummaryLine(
                label: 'Local inicial de aplicação',
                value: setup.initialSite,
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
    required this.initialSite,
    required this.enableReminders,
  });

  final String name;
  final String medication;
  final DateTime startDate;
  final TimeOfDay applicationTime;
  final String initialSite;
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
}
