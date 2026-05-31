import 'package:flutter_test/flutter_test.dart';

import 'package:emcontrole/features/diary/domain/diary_entry.dart';
import 'package:emcontrole/features/timeline/domain/timeline_event.dart';

void main() {
  group('SymptomDiaryEntry', () {
    test(
      'copyWith preserves identity and creation date when editing content',
      () {
        final entry = SymptomDiaryEntry(
          id: 'diary_1',
          createdAt: DateTime(2026, 5, 31, 9),
          title: 'Antes',
          notes: 'Observação inicial',
          fatigueLevel: 2,
          painLevel: 1,
          moodLevel: 3,
          sleepQualityLevel: 4,
        );

        final updatedEntry = entry.copyWith(
          title: 'Depois',
          notes: 'Observação atualizada',
          fatigueLevel: 4,
          painLevel: 3,
          moodLevel: 2,
          sleepQualityLevel: 1,
        );

        expect(updatedEntry.id, entry.id);
        expect(updatedEntry.createdAt, entry.createdAt);
        expect(updatedEntry.title, 'Depois');
        expect(updatedEntry.notes, 'Observação atualizada');
        expect(updatedEntry.fatigueLevel, 4);
        expect(updatedEntry.painLevel, 3);
        expect(updatedEntry.moodLevel, 2);
        expect(updatedEntry.sleepQualityLevel, 1);
      },
    );

    test('timeline events reflect edited and deleted diary entries', () {
      const service = TimelineService();
      final entry = SymptomDiaryEntry(
        id: 'diary_1',
        createdAt: DateTime(2026, 5, 31, 9),
        title: 'Título inicial',
        notes: 'Nota inicial',
        fatigueLevel: 2,
        painLevel: 1,
        moodLevel: 3,
        sleepQualityLevel: 4,
      );

      final updatedEvents = service.buildEvents(
        applicationRecords: const [],
        diaryEntries: [
          entry.copyWith(title: 'Título atualizado', notes: 'Nota atualizada'),
        ],
      );
      final deletedEvents = service.buildEvents(
        applicationRecords: const [],
        diaryEntries: const [],
      );

      expect(updatedEvents.single.id, entry.id);
      expect(updatedEvents.single.title, 'Título atualizado');
      expect(updatedEvents.single.description, 'Nota atualizada');
      expect(deletedEvents, isEmpty);
    });
  });
}
