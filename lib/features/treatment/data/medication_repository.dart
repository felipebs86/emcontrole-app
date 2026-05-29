import '../domain/medication.dart';
import 'medication_catalog_data_source.dart';

class MedicationRepository {
  const MedicationRepository(this._dataSource);

  final MedicationCatalogDataSource _dataSource;

  List<Medication> getAll() => _dataSource.loadMedications();
}
