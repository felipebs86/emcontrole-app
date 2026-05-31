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

enum AnatomicalRegionType { abdomen, thigh, arm, hip, gluteHip }

enum BodySide {
  right,
  left,
  bilateral,
  unspecified;

  String get label {
    return switch (this) {
      BodySide.right => 'Direita',
      BodySide.left => 'Esquerda',
      BodySide.bilateral => 'Bilateral',
      BodySide.unspecified => 'Não especificado',
    };
  }
}

enum ApplicationRotationStrategy { none, sequential, alternateSides }

class Region {
  const Region({
    required this.id,
    required this.label,
    required this.type,
    required this.side,
    required this.svgAssetPath,
    required this.svgElementId,
  });

  final String id;
  final String label;
  final AnatomicalRegionType type;
  final BodySide side;
  final String svgAssetPath;
  final String svgElementId;
}

class SubRegion {
  const SubRegion({
    required this.id,
    required this.regionId,
    required this.label,
    required this.svgElementId,
    this.order,
    this.helperText,
  });

  final String id;
  final String regionId;
  final String label;
  final String svgElementId;
  final int? order;
  final String? helperText;
}

class MedicationApplicationProtocol {
  const MedicationApplicationProtocol({
    required this.id,
    required this.strategy,
    required this.regions,
    required this.subRegions,
    required this.rotationInstruction,
    this.preventImmediateRegionRepeat = true,
    this.preventImmediateSubRegionRepeat = true,
  });

  final String id;
  final ApplicationRotationStrategy strategy;
  final List<Region> regions;
  final List<SubRegion> subRegions;
  final String rotationInstruction;
  final bool preventImmediateRegionRepeat;
  final bool preventImmediateSubRegionRepeat;
}

class ApplicationSite {
  const ApplicationSite({
    required this.id,
    required this.label,
    required this.bodyRegion,
    required this.side,
    required this.imageAssetPath,
    this.regionId,
  });

  final String id;
  final String label;
  final String bodyRegion;
  final String side;
  final String imageAssetPath;
  final String? regionId;
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
    this.regionId,
    this.subRegionId,
    this.regionType,
    this.bodySide,
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
  final String? regionId;
  final String? subRegionId;
  final AnatomicalRegionType? regionType;
  final BodySide? bodySide;
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
    this.applicationProtocol,
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
  final MedicationApplicationProtocol? applicationProtocol;
  final String? helperText;
}
