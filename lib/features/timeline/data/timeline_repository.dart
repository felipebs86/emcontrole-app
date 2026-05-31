import '../../../core/database/app_database.dart';
import '../../diary/data/diary_repository.dart';
import '../../treatment/data/application_record_repository.dart';
import '../../treatment/data/treatment_repository.dart';
import 'treatment_change_repository.dart';
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
}
