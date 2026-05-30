enum AdministrationType {
  injectable,
  oral,
  infusion;

  String get label {
    return switch (this) {
      AdministrationType.injectable => 'Injetável',
      AdministrationType.oral => 'Oral',
      AdministrationType.infusion => 'Infusão',
    };
  }
}

enum InjectionType {
  subcutaneous,
  intramuscular,
  none;

  String get label {
    return switch (this) {
      InjectionType.subcutaneous => 'Subcutânea',
      InjectionType.intramuscular => 'Intramuscular',
      InjectionType.none => 'Não aplicável',
    };
  }
}

enum MedicationScheduleType {
  onceDaily,
  twiceDaily,
  threeTimesPerWeek,
  everyOtherDay,
  weekly,
  every14Days,
  monthly,
  cycleBased,
  manual,
}

class ApplicationSite {
  const ApplicationSite({
    required this.id,
    required this.label,
    required this.bodyRegion,
    required this.side,
    required this.imageAssetPath,
  });

  final String id;
  final String label;
  final String bodyRegion;
  final String side;
  final String imageAssetPath;
}

class ApplicationPoint {
  const ApplicationPoint({
    required this.id,
    required this.order,
    required this.label,
    required this.bodyRegion,
    required this.side,
    required this.parentSiteLabel,
    required this.imageAssetPath,
    required this.highlightAreaId,
    required this.helperText,
  });

  final String id;
  final int order;
  final String label;
  final String bodyRegion;
  final String side;
  final String parentSiteLabel;
  final String imageAssetPath;
  final String highlightAreaId;
  final String helperText;
}

class Medication {
  const Medication({
    required this.id,
    required this.name,
    required this.activeIngredient,
    required this.administrationType,
    required this.injectionType,
    required this.route,
    required this.frequencyLabel,
    required this.requiresApplicationSite,
    required this.requiresApplicationRotation,
    required this.scheduleType,
    required this.scheduleDescription,
    required this.applicationSites,
    required this.applicationPoints,
    required this.safetyNote,
    this.dailyDoseCount,
    this.intervalHours,
    this.intervalDays,
    this.weeklyDoseCount,
    this.minimumIntervalHours,
    this.preferredWeekdays,
    this.helperText,
  });

  final String id;
  final String name;
  final String activeIngredient;
  final AdministrationType administrationType;
  final InjectionType injectionType;
  final String route;
  final String frequencyLabel;
  final MedicationScheduleType scheduleType;
  final String scheduleDescription;
  final int? dailyDoseCount;
  final int? intervalHours;
  final int? intervalDays;
  final int? weeklyDoseCount;
  final int? minimumIntervalHours;
  final List<int>? preferredWeekdays;
  final bool requiresApplicationSite;
  final bool requiresApplicationRotation;
  final List<ApplicationSite> applicationSites;
  final List<ApplicationPoint> applicationPoints;
  final String safetyNote;
  final String? helperText;
}
