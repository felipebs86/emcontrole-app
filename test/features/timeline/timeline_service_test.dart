import 'package:flutter_test/flutter_test.dart';

import 'package:emcontrole/features/diary/domain/diary_entry.dart';
import 'package:emcontrole/features/timeline/domain/treatment_change_record.dart';
import 'package:emcontrole/features/timeline/domain/timeline_event.dart';
import 'package:emcontrole/features/treatment/domain/application_record.dart';

void main() {
  group('TimelineService', () {
    test('merges application records and diary entries newest first', () {
      const service = TimelineService();
      final applicationRecord = ApplicationRecord(
        id: 'application_1',
        medicationId: 'copaxone_40mg',
        medicationName: 'Copaxone 40 mg',
        applicationPointId: 'copaxone_thigh_left_07',
        applicationPointLabel: 'Local 7',
        scheduledAt: DateTime(2026, 5, 29, 20),
        registeredAt: DateTime(2026, 5, 29, 20),
        registrationStatus: ApplicationRegistrationStatus.onTime,
        adjustedSchedule: false,
        appliedAt: DateTime(2026, 5, 29, 20),
      );
      final olderDiaryEntry = SymptomDiaryEntry(
        id: 'diary_1',
        createdAt: DateTime(2026, 5, 28, 18, 30),
        title: 'Fadiga elevada',
        notes: 'Após trabalho',
        fatigueLevel: 4,
        painLevel: 2,
        moodLevel: 4,
        sleepQualityLevel: 3,
      );
      final newerDiaryEntry = SymptomDiaryEntry(
        id: 'diary_2',
        createdAt: DateTime(2026, 5, 30, 9),
        title: 'Manhã tranquila',
        notes: '',
        fatigueLevel: null,
        painLevel: null,
        moodLevel: null,
        sleepQualityLevel: null,
      );

      final events = service.buildEvents(
        applicationRecords: [applicationRecord],
        diaryEntries: [olderDiaryEntry, newerDiaryEntry],
        treatmentChangeRecords: [
          TreatmentChangeRecord(
            id: 'change_1',
            previousMedicationId: 'avonex',
            previousMedicationName: 'Avonex',
            newMedicationId: 'tecfidera',
            newMedicationName: 'Tecfidera',
            changedAt: DateTime(2026, 5, 29, 21),
          ),
        ],
      );

      expect(events.map((event) => event.id), [
        'diary_2',
        'change_1',
        'application_1',
        'diary_1',
      ]);
      expect(events[1].eventType, TimelineEventType.treatmentChange);
      expect(events[1].title, 'Tratamento alterado');
      expect(events[1].description, contains('De: Avonex'));
      expect(events[1].description, contains('Para: Tecfidera'));
      expect(events[2].eventType, TimelineEventType.application);
      expect(events[2].title, 'Aplicação registrada');
      expect(events[2].description, contains('Copaxone 40 mg'));
      expect(events[2].description, contains('Local 7'));
      expect(events[3].indicatorLabels, [
        'Fadiga 😣',
        'Dor 🙂',
        'Humor 😄',
        'Sono 🙂',
      ]);
    });

    test('groups events by local date preserving newest ordering', () {
      const service = TimelineService();
      final events = [
        TimelineEvent(
          id: 'first',
          eventType: TimelineEventType.diary,
          title: 'Primeiro',
          description: '',
          eventDateTime: DateTime(2026, 5, 30, 9),
          indicatorLabels: const [],
        ),
        TimelineEvent(
          id: 'second',
          eventType: TimelineEventType.application,
          title: 'Segundo',
          description: '',
          eventDateTime: DateTime(2026, 5, 30, 8),
          indicatorLabels: const [],
        ),
        TimelineEvent(
          id: 'third',
          eventType: TimelineEventType.diary,
          title: 'Terceiro',
          description: '',
          eventDateTime: DateTime(2026, 5, 29, 20),
          indicatorLabels: const [],
        ),
      ];

      final groups = service.groupByDate(events);

      expect(groups, hasLength(2));
      expect(groups.first.date, DateTime(2026, 5, 30));
      expect(groups.first.events.map((event) => event.id), ['first', 'second']);
      expect(groups.last.date, DateTime(2026, 5, 29));
      expect(groups.last.events.single.id, 'third');
    });
  });
}
