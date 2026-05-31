import 'dart:async';

import '../../../core/database/app_database.dart';
import '../../diary/data/diary_repository.dart';
import '../../diary/domain/diary_entry.dart';
import '../../treatment/data/application_record_repository.dart';
import '../../treatment/data/treatment_repository.dart';
import '../../treatment/domain/application_record.dart';
import 'treatment_change_repository.dart';
import '../domain/treatment_change_record.dart';
import '../domain/timeline_event.dart';

class TimelineRepository {
  const TimelineRepository(
    this._database, {
    this._timelineService = const TimelineService(),
  });

  final AppDatabase _database;
  final TimelineService _timelineService;

  Future<List<TimelineEvent>> loadEvents() async {
    final applicationRecords = await ApplicationRecordRepository(
      _database,
    ).loadRecords(TreatmentRepository.activeTreatmentId);
    final diaryEntries = await DiaryRepository(_database).loadEntries();
    final treatmentChangeRecords = await TreatmentChangeRepository(
      _database,
    ).loadRecords();

    return _timelineService.buildEvents(
      applicationRecords: applicationRecords,
      diaryEntries: diaryEntries,
      treatmentChangeRecords: treatmentChangeRecords,
    );
  }

  Stream<List<TimelineEvent>> watchEvents() {
    final applicationRecordsStream = ApplicationRecordRepository(
      _database,
    ).watchRecords(TreatmentRepository.activeTreatmentId);
    final diaryEntriesStream = DiaryRepository(_database).watchEntries();
    final treatmentChangeRecordsStream = TreatmentChangeRepository(
      _database,
    ).watchRecords();

    return Stream.multi((controller) {
      List<ApplicationRecord>? latestApplicationRecords;
      List<SymptomDiaryEntry>? latestDiaryEntries;
      List<TreatmentChangeRecord>? latestTreatmentChangeRecords;

      void emitIfReady() {
        final applicationRecords = latestApplicationRecords;
        final diaryEntries = latestDiaryEntries;
        final treatmentChangeRecords = latestTreatmentChangeRecords;
        if (applicationRecords == null ||
            diaryEntries == null ||
            treatmentChangeRecords == null) {
          return;
        }

        controller.add(
          _timelineService.buildEvents(
            applicationRecords: applicationRecords,
            diaryEntries: diaryEntries,
            treatmentChangeRecords: treatmentChangeRecords,
          ),
        );
      }

      final subscriptions = <StreamSubscription<dynamic>>[
        applicationRecordsStream.listen((records) {
          latestApplicationRecords = records;
          emitIfReady();
        }, onError: controller.addError),
        diaryEntriesStream.listen((entries) {
          latestDiaryEntries = entries;
          emitIfReady();
        }, onError: controller.addError),
        treatmentChangeRecordsStream.listen((records) {
          latestTreatmentChangeRecords = records;
          emitIfReady();
        }, onError: controller.addError),
      ];

      controller.onCancel = () async {
        for (final subscription in subscriptions) {
          await subscription.cancel();
        }
      };
    });
  }
}
