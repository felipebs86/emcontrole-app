import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_routes.dart';
import '../../core/database/app_database.dart';
import 'data/diary_repository.dart';
import 'domain/diary_entry.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<SymptomDiaryEntry>>(
      stream: DiaryRepository(appDatabase).watchEntries(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Carregando diário...'));
        }

        final entries = snapshot.data ?? const [];
        if (entries.isEmpty) {
          return const _DiaryEmptyState();
        }

        return ListView(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                key: const Key('diary-add-entry-button'),
                onPressed: () => context.go(AppRoutes.diaryNew),
                icon: const Icon(Icons.add),
                label: const Text('Nova anotação'),
              ),
            ),
            const SizedBox(height: 12),
            for (final (index, entry) in entries.indexed) ...[
              _DiaryEntryCard(entry: entry),
              if (index < entries.length - 1) const SizedBox(height: 12),
            ],
          ],
        );
      },
    );
  }
}

class CreateDiaryEntryScreen extends StatefulWidget {
  const CreateDiaryEntryScreen({super.key});

  @override
  State<CreateDiaryEntryScreen> createState() => _DiaryEntryFormScreenState();
}

class EditDiaryEntryScreen extends StatelessWidget {
  const EditDiaryEntryScreen({required this.entryId, super.key});

  final String entryId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SymptomDiaryEntry?>(
      future: DiaryRepository(appDatabase).loadEntry(entryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: Text('Carregando anotação...'));
        }

        final entry = snapshot.data;
        if (entry == null) {
          return const _DiaryEntryNotFound();
        }

        return _DiaryEntryForm(initialEntry: entry);
      },
    );
  }
}

class _DiaryEntryFormScreenState extends State<CreateDiaryEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return const _DiaryEntryForm();
  }
}

class _DiaryEntryForm extends StatefulWidget {
  const _DiaryEntryForm({this.initialEntry});

  final SymptomDiaryEntry? initialEntry;

  @override
  State<_DiaryEntryForm> createState() => _DiaryEntryFormState();
}

class _DiaryEntryFormState extends State<_DiaryEntryForm> {
  final DiaryRepository _repository = DiaryRepository(appDatabase);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  int _fatigueLevel = 1;
  int _painLevel = 1;
  int _moodLevel = 3;
  int _sleepQualityLevel = 3;
  bool _isSaving = false;

  bool get _isEditing => widget.initialEntry != null;

  @override
  void initState() {
    super.initState();
    final entry = widget.initialEntry;
    if (entry == null) {
      return;
    }

    _titleController.text = entry.title;
    _notesController.text = entry.notes;
    _fatigueLevel = entry.fatigueLevel ?? _fatigueLevel;
    _painLevel = entry.painLevel ?? _painLevel;
    _moodLevel = entry.moodLevel ?? _moodLevel;
    _sleepQualityLevel = entry.sleepQualityLevel ?? _sleepQualityLevel;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            key: const Key('diary-title-field'),
            controller: _titleController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Título',
              prefixIcon: Icon(Icons.title),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Informe um título.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            key: const Key('diary-notes-field'),
            controller: _notesController,
            minLines: 5,
            maxLines: 8,
            decoration: const InputDecoration(
              labelText: 'Observações',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.notes_outlined),
            ),
          ),
          const SizedBox(height: 24),
          _EmojiRatingField(
            label: 'Fadiga',
            icon: Icons.battery_2_bar_outlined,
            value: _fatigueLevel,
            options: _fatigueOptions,
            onChanged: (value) => setState(() => _fatigueLevel = value),
          ),
          const SizedBox(height: 12),
          _EmojiRatingField(
            label: 'Dor',
            icon: Icons.healing_outlined,
            value: _painLevel,
            options: _painOptions,
            onChanged: (value) => setState(() => _painLevel = value),
          ),
          const SizedBox(height: 12),
          _EmojiRatingField(
            label: 'Humor',
            icon: Icons.mood_outlined,
            value: _moodLevel,
            options: _moodOptions,
            onChanged: (value) => setState(() => _moodLevel = value),
          ),
          const SizedBox(height: 12),
          _EmojiRatingField(
            label: 'Sono',
            icon: Icons.bedtime_outlined,
            value: _sleepQualityLevel,
            options: _sleepOptions,
            onChanged: (value) => setState(() => _sleepQualityLevel = value),
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            key: const Key('diary-save-entry-button'),
            onPressed: _isSaving ? null : _save,
            icon: _isSaving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check),
            label: Text(_isEditing ? 'Atualizar anotação' : 'Salvar anotação'),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    final formIsValid = _formKey.currentState?.validate() ?? false;
    if (!formIsValid) {
      return;
    }

    setState(() => _isSaving = true);
    final now = DateTime.now();
    final initialEntry = widget.initialEntry;
    final entry =
        (initialEntry ??
                SymptomDiaryEntry(
                  id: 'diary_${now.microsecondsSinceEpoch}',
                  createdAt: now,
                  title: '',
                  notes: '',
                  fatigueLevel: _fatigueLevel,
                  painLevel: _painLevel,
                  moodLevel: _moodLevel,
                  sleepQualityLevel: _sleepQualityLevel,
                ))
            .copyWith(
              title: _titleController.text.trim(),
              notes: _notesController.text.trim(),
              fatigueLevel: _fatigueLevel,
              painLevel: _painLevel,
              moodLevel: _moodLevel,
              sleepQualityLevel: _sleepQualityLevel,
            );

    if (_isEditing) {
      await _repository.updateEntry(entry);
    } else {
      await _repository.saveEntry(entry);
    }

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'Anotação atualizada com sucesso.'
                : 'Anotação salva com sucesso.',
          ),
        ),
      );
    context.go(_isEditing ? '${AppRoutes.diary}/${entry.id}' : AppRoutes.diary);
  }
}

class DiaryEntryDetailsScreen extends StatelessWidget {
  const DiaryEntryDetailsScreen({required this.entryId, super.key});

  final String entryId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SymptomDiaryEntry?>(
      stream: DiaryRepository(appDatabase).watchEntry(entryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Carregando anotação...'));
        }

        final entry = snapshot.data;
        if (entry == null) {
          return const _DiaryEntryNotFound();
        }

        return _DiaryEntryDetails(entry: entry);
      },
    );
  }
}

class _DiaryEmptyState extends StatelessWidget {
  const _DiaryEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/branding/app_icon.png',
                  height: 56,
                  fit: BoxFit.contain,
                  semanticLabel: 'Marca EMControle',
                ),
                const SizedBox(height: 16),
                Text(
                  'Nenhuma anotação ainda',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Registre sintomas, sensações ou observações para conversar com sua equipe de saúde.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => context.go(AppRoutes.diaryNew),
                  icon: const Icon(Icons.add),
                  label: const Text('Nova anotação'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DiaryEntryCard extends StatelessWidget {
  const _DiaryEntryCard({required this.entry});

  final SymptomDiaryEntry entry;

  @override
  Widget build(BuildContext context) {
    final chips = [
      if (entry.fatigueLevel != null)
        _LevelChip(
          label: 'Fadiga',
          option: _optionFor(_fatigueOptions, entry.fatigueLevel!),
        ),
      if (entry.painLevel != null)
        _LevelChip(
          label: 'Dor',
          option: _optionFor(_painOptions, entry.painLevel!),
        ),
      if (entry.moodLevel != null)
        _LevelChip(
          label: 'Humor',
          option: _optionFor(_moodOptions, entry.moodLevel!),
        ),
      if (entry.sleepQualityLevel != null)
        _LevelChip(
          label: 'Sono',
          option: _optionFor(_sleepOptions, entry.sleepQualityLevel!),
        ),
    ];

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => context.go('${AppRoutes.diary}/${entry.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      entry.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                _formatDateTime(entry.createdAt),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              if (chips.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: chips),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DiaryEntryDetails extends StatelessWidget {
  const _DiaryEntryDetails({required this.entry});

  final SymptomDiaryEntry entry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TextButton.icon(
                      onPressed: () =>
                          context.go(AppRoutes.diaryEdit(entry.id)),
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text('Editar'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () => _confirmDelete(context),
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Excluir'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Criada em',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _DetailRow(
                  label: 'Data',
                  value: _formatDateTime(entry.createdAt),
                ),
                const SizedBox(height: 16),
                Text(
                  'Observações',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(entry.notes.isEmpty ? 'Sem observações.' : entry.notes),
                const SizedBox(height: 20),
                _DetailRow(
                  label: 'Fadiga',
                  value: _formatRating(_fatigueOptions, entry.fatigueLevel),
                ),
                const SizedBox(height: 8),
                _DetailRow(
                  label: 'Dor',
                  value: _formatRating(_painOptions, entry.painLevel),
                ),
                const SizedBox(height: 8),
                _DetailRow(
                  label: 'Humor',
                  value: _formatRating(_moodOptions, entry.moodLevel),
                ),
                const SizedBox(height: 8),
                _DetailRow(
                  label: 'Sono',
                  value: _formatRating(_sleepOptions, entry.sleepQualityLevel),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir anotação'),
        content: const Text('Deseja excluir esta anotação?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    await DiaryRepository(appDatabase).deleteEntry(entry.id);
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Anotação excluída com sucesso.')),
      );
    context.go(AppRoutes.diary);
  }
}

class _DiaryEntryNotFound extends StatelessWidget {
  const _DiaryEntryNotFound();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Anotação não encontrada',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => context.go(AppRoutes.diary),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Voltar ao diário'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmojiRatingField extends StatelessWidget {
  const _EmojiRatingField({
    required this.label,
    required this.icon,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final int value;
  final List<_RatingOption> options;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final selected = _optionFor(options, value);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _RatingHeader(
              icon: icon,
              label: label,
              value: '${selected.emoji} ${selected.label}',
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 460;
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final option in options)
                      ChoiceChip(
                        selected: option.value == value,
                        showCheckmark: false,
                        label: SizedBox(
                          width: compact ? 88 : 104,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                option.emoji,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                option.label,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        onSelected: (_) => onChanged(option.value),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

const _fatigueOptions = [
  _RatingOption(value: 1, label: 'Nenhuma', emoji: '😄'),
  _RatingOption(value: 2, label: 'Leve', emoji: '🙂'),
  _RatingOption(value: 3, label: 'Moderada', emoji: '😐'),
  _RatingOption(value: 4, label: 'Alta', emoji: '😣'),
  _RatingOption(value: 5, label: 'Extrema', emoji: '😫'),
];

const _painOptions = [
  _RatingOption(value: 1, label: 'Nenhuma', emoji: '😄'),
  _RatingOption(value: 2, label: 'Leve', emoji: '🙂'),
  _RatingOption(value: 3, label: 'Moderada', emoji: '😐'),
  _RatingOption(value: 4, label: 'Forte', emoji: '😣'),
  _RatingOption(value: 5, label: 'Muito forte', emoji: '😫'),
];

const _moodOptions = [
  _RatingOption(value: 1, label: 'Ruim', emoji: '😞'),
  _RatingOption(value: 2, label: 'Regular', emoji: '😐'),
  _RatingOption(value: 3, label: 'Bom', emoji: '🙂'),
  _RatingOption(value: 4, label: 'Ótimo', emoji: '😄'),
];

const _sleepOptions = [
  _RatingOption(value: 1, label: 'Ruim', emoji: '😴'),
  _RatingOption(value: 2, label: 'Regular', emoji: '😐'),
  _RatingOption(value: 3, label: 'Bom', emoji: '🙂'),
  _RatingOption(value: 4, label: 'Ótimo', emoji: '😄'),
];

_RatingOption _optionFor(List<_RatingOption> options, int value) {
  return options.where((option) => option.value == value).firstOrNull ??
      options.first;
}

class _RatingOption {
  const _RatingOption({
    required this.value,
    required this.label,
    required this.emoji,
  });

  final int value;
  final String label;
  final String emoji;
}

class _RatingHeader extends StatelessWidget {
  const _RatingHeader({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.titleMedium),
        ),
        Text(value, style: Theme.of(context).textTheme.labelLarge),
      ],
    );
  }
}

class _LevelChip extends StatelessWidget {
  const _LevelChip({required this.label, required this.option});

  final String label;
  final _RatingOption option;

  @override
  Widget build(BuildContext context) {
    return Chip(
      visualDensity: VisualDensity.compact,
      label: Text('$label ${option.emoji}'),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 96,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(value)),
      ],
    );
  }
}

String _formatRating(List<_RatingOption> options, int? value) {
  if (value == null) {
    return 'Não informado';
  }

  final option = _optionFor(options, value);
  return '${option.emoji} ${option.label}';
}

String _formatDateTime(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  final year = value.year.toString().padLeft(4, '0');
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  return '$day/$month/$year às $hour:$minute';
}
