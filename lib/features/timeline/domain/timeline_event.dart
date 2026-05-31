import '../../diary/domain/diary_entry.dart';
import '../../treatment/domain/application_record.dart';
import 'treatment_change_record.dart';

enum TimelineEventType { application, diary, treatmentChange }

class TimelineEvent {
  const TimelineEvent({
    required this.id,
    required this.eventType,
    required this.title,
    required this.description,
    required this.eventDateTime,
    required this.indicatorLabels,
  });

  final String id;
  final TimelineEventType eventType;
  final String title;
  final String description;
  final DateTime eventDateTime;
  final List<String> indicatorLabels;
}

class TimelineDateGroup {
  const TimelineDateGroup({required this.date, required this.events});

  final DateTime date;
  final List<TimelineEvent> events;
}

class TimelineService {
  const TimelineService();

  List<TimelineEvent> buildEvents({
    required List<ApplicationRecord> applicationRecords,
    required List<SymptomDiaryEntry> diaryEntries,
    List<TreatmentChangeRecord> treatmentChangeRecords = const [],
  }) {
    final events =
        [
          ...applicationRecords.map(_applicationEvent),
          ...diaryEntries.map(_diaryEvent),
          ...treatmentChangeRecords.map(_treatmentChangeEvent),
        ]..sort(
          (first, second) =>
              second.eventDateTime.compareTo(first.eventDateTime),
        );

    return events;
  }

  List<TimelineDateGroup> groupByDate(List<TimelineEvent> events) {
    final groups = <TimelineDateGroup>[];

    for (final event in events) {
      final date = _dateOnly(event.eventDateTime);
      if (groups.isNotEmpty && _sameLocalDate(groups.last.date, date)) {
        groups.last.events.add(event);
        continue;
      }

      groups.add(TimelineDateGroup(date: date, events: [event]));
    }

    return groups;
  }

  TimelineEvent _applicationEvent(ApplicationRecord record) {
    final details = [
      record.medicationName,
      if (record.applicationPointLabel != null) record.applicationPointLabel!,
    ];

    return TimelineEvent(
      id: record.id,
      eventType: TimelineEventType.application,
      title: 'Aplicação registrada',
      description: details.join('\n'),
      eventDateTime: record.registeredAt,
      indicatorLabels: const [],
    );
  }

  TimelineEvent _diaryEvent(SymptomDiaryEntry entry) {
    final indicators = [
      if (entry.fatigueLevel != null) 'Fadiga ${entry.fatigueLevel}/10',
      if (entry.moodLevel != null) 'Humor ${entry.moodLevel}/10',
    ];

    return TimelineEvent(
      id: entry.id,
      eventType: TimelineEventType.diary,
      title: entry.title,
      description: entry.notes,
      eventDateTime: entry.createdAt,
      indicatorLabels: indicators,
    );
  }

  TimelineEvent _treatmentChangeEvent(TreatmentChangeRecord record) {
    return TimelineEvent(
      id: record.id,
      eventType: TimelineEventType.treatmentChange,
      title: 'Tratamento alterado',
      description:
          'De: ${record.previousMedicationName}\nPara: ${record.newMedicationName}',
      eventDateTime: record.changedAt,
      indicatorLabels: const [],
    );
  }

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  bool _sameLocalDate(DateTime first, DateTime second) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }
}
