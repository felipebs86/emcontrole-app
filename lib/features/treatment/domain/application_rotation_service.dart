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

  MedicationApplicationProtocol? getApplicationProtocol(Medication medication) {
    if (!medication.requiresApplicationSite ||
        medication.administrationType != AdministrationType.injectable) {
      return null;
    }

    return medication.applicationProtocol;
  }

  ApplicationRotationProtocol _protocolFor(Medication medication) {
    if (!medication.requiresApplicationSite ||
        medication.administrationType != AdministrationType.injectable) {
      return const NoApplicationSiteProtocol();
    }

    final protocol = medication.applicationProtocol;
    if (protocol?.strategy == ApplicationRotationStrategy.alternateSides) {
      return const AlternatingSideRotationProtocol();
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

class AlternatingSideRotationProtocol extends ApplicationRotationProtocol {
  const AlternatingSideRotationProtocol();

  @override
  List<ApplicationPoint> getApplicationPoints(Medication medication) {
    if (medication.applicationPoints.isNotEmpty) {
      return medication.applicationPoints;
    }

    return const SubcutaneousRotationProtocol().getApplicationPoints(
      medication,
    );
  }

  @override
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
    if (currentIndex < 0) {
      return points.first;
    }

    final currentSide = points[currentIndex].bodySide;
    if (currentSide != null &&
        currentSide != BodySide.bilateral &&
        currentSide != BodySide.unspecified) {
      final nextDifferentSide = points
          .skip(currentIndex + 1)
          .followedBy(points.take(currentIndex + 1))
          .where((point) => point.bodySide != currentSide)
          .firstOrNull;
      if (nextDifferentSide != null) {
        return nextDifferentSide;
      }
    }

    if (currentIndex == points.length - 1) {
      return points.first;
    }

    return points[currentIndex + 1];
  }
}

class SubcutaneousRotationProtocol extends ApplicationRotationProtocol {
  const SubcutaneousRotationProtocol();

  @override
  List<ApplicationPoint> getApplicationPoints(Medication medication) {
    if (medication.applicationPoints.isNotEmpty) {
      return medication.applicationPoints;
    }

    final protocolRegions = medication.applicationProtocol?.regions ?? const [];
    if (protocolRegions.isNotEmpty) {
      return [
        for (final (index, region) in protocolRegions.indexed)
          ApplicationPoint(
            id: '${medication.id}_${region.id}_point',
            order: index + 1,
            label: 'Local ${index + 1}',
            bodyRegion: _regionTypeLabel(region.type),
            side: region.side.label,
            parentSiteLabel: region.label,
            imageAssetPath: region.svgAssetPath,
            highlightAreaId: region.svgElementId,
            regionId: region.id,
            regionType: region.type,
            bodySide: region.side,
            helperText:
                'Aplique conforme orientação recebida da sua equipe de saúde.',
          ),
      ];
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
          regionId: site.regionId ?? site.id,
          regionType: _regionTypeFor(site),
          bodySide: _sideFor(site),
          helperText:
              'Aplique conforme orientação recebida da sua equipe de saúde.',
        ),
    ];
  }

  static String _regionTypeLabel(AnatomicalRegionType type) {
    return switch (type) {
      AnatomicalRegionType.abdomen => 'Abdômen',
      AnatomicalRegionType.thigh => 'Coxa',
      AnatomicalRegionType.arm => 'Braço',
      AnatomicalRegionType.hip => 'Quadril',
      AnatomicalRegionType.gluteHip => 'Glúteo/quadril',
    };
  }

  static AnatomicalRegionType? _regionTypeFor(ApplicationSite site) {
    final region = site.bodyRegion.toLowerCase();
    if (region.contains('abdômen')) {
      return AnatomicalRegionType.abdomen;
    }
    if (region.contains('coxa')) {
      return AnatomicalRegionType.thigh;
    }
    if (region.contains('braço')) {
      return AnatomicalRegionType.arm;
    }
    if (region.contains('glúteo')) {
      return AnatomicalRegionType.gluteHip;
    }
    if (region.contains('quadril')) {
      return AnatomicalRegionType.hip;
    }

    return null;
  }

  static BodySide _sideFor(ApplicationSite site) {
    final side = site.side.toLowerCase();
    if (side.contains('direita') || side.contains('direito')) {
      return BodySide.right;
    }
    if (side.contains('esquerda') || side.contains('esquerdo')) {
      return BodySide.left;
    }
    if (side.contains('bilateral')) {
      return BodySide.bilateral;
    }

    return BodySide.unspecified;
  }
}
