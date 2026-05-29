import 'medication.dart';

class ApplicationRotationService {
  const ApplicationRotationService();

  ApplicationPoint? getInitialPoint(Medication medication) {
    return _protocolFor(medication).getInitialPoint(medication);
  }

  ApplicationPoint? getNextPoint(
    Medication medication,
    String? currentPointId,
  ) {
    return _protocolFor(medication).getNextPoint(medication, currentPointId);
  }

  ApplicationPoint? getPointById(Medication medication, String? pointId) {
    return _protocolFor(medication).getPointById(medication, pointId);
  }

  List<ApplicationPoint> getApplicationPoints(Medication medication) {
    return _protocolFor(medication).getApplicationPoints(medication);
  }

  ApplicationRotationProtocol _protocolFor(Medication medication) {
    if (!medication.requiresApplicationSite ||
        medication.administrationType != AdministrationType.injectable) {
      return const NoApplicationSiteProtocol();
    }

    if (medication.id == 'avonex') {
      return const WeeklyThighProtocol();
    }

    return const SubcutaneousRotationProtocol();
  }
}

abstract class ApplicationRotationProtocol {
  const ApplicationRotationProtocol();

  List<ApplicationPoint> getApplicationPoints(Medication medication);

  ApplicationPoint? getInitialPoint(Medication medication) {
    final points = getApplicationPoints(medication);
    if (points.isEmpty) {
      return null;
    }

    return points.first;
  }

  ApplicationPoint? getPointById(Medication medication, String? pointId) {
    if (pointId == null) {
      return null;
    }

    for (final point in getApplicationPoints(medication)) {
      if (point.id == pointId) {
        return point;
      }
    }

    return null;
  }

  ApplicationPoint? getNextPoint(
    Medication medication,
    String? currentPointId,
  ) {
    final points = getApplicationPoints(medication);
    if (points.isEmpty) {
      return null;
    }

    if (currentPointId == null) {
      return points.first;
    }

    final currentIndex = points.indexWhere(
      (point) => point.id == currentPointId,
    );
    if (currentIndex < 0 || currentIndex == points.length - 1) {
      return points.first;
    }

    return points[currentIndex + 1];
  }
}

class NoApplicationSiteProtocol extends ApplicationRotationProtocol {
  const NoApplicationSiteProtocol();

  @override
  List<ApplicationPoint> getApplicationPoints(Medication medication) {
    return const [];
  }
}

class WeeklyThighProtocol extends ApplicationRotationProtocol {
  const WeeklyThighProtocol();

  @override
  List<ApplicationPoint> getApplicationPoints(Medication medication) {
    return medication.applicationPoints;
  }
}

class SubcutaneousRotationProtocol extends ApplicationRotationProtocol {
  const SubcutaneousRotationProtocol();

  @override
  List<ApplicationPoint> getApplicationPoints(Medication medication) {
    if (medication.applicationPoints.isNotEmpty) {
      return medication.applicationPoints;
    }

    return [
      for (final (index, site) in medication.applicationSites.indexed)
        ApplicationPoint(
          id: '${medication.id}_${site.id}_point',
          order: index + 1,
          label: 'Local ${index + 1}',
          bodyRegion: site.bodyRegion,
          side: site.side,
          parentSiteLabel: site.label,
          imageAssetPath: site.imageAssetPath,
          highlightAreaId: site.id,
          helperText:
              'Aplique conforme orientação recebida da sua equipe de saúde.',
        ),
    ];
  }
}
