import '../domain/medication.dart';

class MedicationCatalogDataSource {
  const MedicationCatalogDataSource();

  List<Medication> loadMedications() => _medications;
}

const _safetyNote =
    'Siga sempre a prescrição e orientação da sua equipe de saúde.';

const _abdomenRightRegion = Region(
  id: 'abdomen_right',
  label: 'Abdômen direito',
  type: AnatomicalRegionType.abdomen,
  side: BodySide.right,
  svgAssetPath: 'assets/images/application_sites/abdomen_right.svg',
  svgElementId: 'abdomen_right',
);

const _abdomenLeftRegion = Region(
  id: 'abdomen_left',
  label: 'Abdômen esquerdo',
  type: AnatomicalRegionType.abdomen,
  side: BodySide.left,
  svgAssetPath: 'assets/images/application_sites/abdomen_left.svg',
  svgElementId: 'abdomen_left',
);

const _rightThighRegion = Region(
  id: 'right_thigh',
  label: 'Coxa direita',
  type: AnatomicalRegionType.thigh,
  side: BodySide.right,
  svgAssetPath: 'assets/images/application_sites/thigh_right.svg',
  svgElementId: 'thigh_right',
);

const _leftThighRegion = Region(
  id: 'left_thigh',
  label: 'Coxa esquerda',
  type: AnatomicalRegionType.thigh,
  side: BodySide.left,
  svgAssetPath: 'assets/images/application_sites/thigh_left.svg',
  svgElementId: 'thigh_left',
);

const _armRightRegion = Region(
  id: 'arm_right',
  label: 'Braço direito',
  type: AnatomicalRegionType.arm,
  side: BodySide.right,
  svgAssetPath: 'assets/images/application_sites/arm_right.svg',
  svgElementId: 'arm_right',
);

const _armLeftRegion = Region(
  id: 'arm_left',
  label: 'Braço esquerdo',
  type: AnatomicalRegionType.arm,
  side: BodySide.left,
  svgAssetPath: 'assets/images/application_sites/arm_left.svg',
  svgElementId: 'arm_left',
);

const _hipRightRegion = Region(
  id: 'hip_right',
  label: 'Quadril direito',
  type: AnatomicalRegionType.hip,
  side: BodySide.right,
  svgAssetPath: 'assets/images/application_sites/hip_right.svg',
  svgElementId: 'hip_right',
);

const _hipLeftRegion = Region(
  id: 'hip_left',
  label: 'Quadril esquerdo',
  type: AnatomicalRegionType.hip,
  side: BodySide.left,
  svgAssetPath: 'assets/images/application_sites/hip_left.svg',
  svgElementId: 'hip_left',
);

const _abdomenRightPngRegion = Region(
  id: 'abdomen_right',
  label: 'Abdômen direito',
  type: AnatomicalRegionType.abdomen,
  side: BodySide.right,
  svgAssetPath: 'assets/images/application_sites/abdomen_right_region.png',
  svgElementId: 'abdomen_right',
);

const _abdomenLeftPngRegion = Region(
  id: 'abdomen_left',
  label: 'Abdômen esquerdo',
  type: AnatomicalRegionType.abdomen,
  side: BodySide.left,
  svgAssetPath: 'assets/images/application_sites/abdomen_left_region.png',
  svgElementId: 'abdomen_left',
);

const _rightThighPngRegion = Region(
  id: 'right_thigh',
  label: 'Coxa direita',
  type: AnatomicalRegionType.thigh,
  side: BodySide.right,
  svgAssetPath: 'assets/images/application_sites/right_thigh_region.png',
  svgElementId: 'thigh_right',
);

const _leftThighPngRegion = Region(
  id: 'left_thigh',
  label: 'Coxa esquerda',
  type: AnatomicalRegionType.thigh,
  side: BodySide.left,
  svgAssetPath: 'assets/images/application_sites/left_thigh_region.png',
  svgElementId: 'thigh_left',
);

const _armRightPngRegion = Region(
  id: 'arm_right',
  label: 'Braço direito',
  type: AnatomicalRegionType.arm,
  side: BodySide.right,
  svgAssetPath: 'assets/images/application_sites/right_arm_region.png',
  svgElementId: 'arm_right',
);

const _armLeftPngRegion = Region(
  id: 'arm_left',
  label: 'Braço esquerdo',
  type: AnatomicalRegionType.arm,
  side: BodySide.left,
  svgAssetPath: 'assets/images/application_sites/left_arm_region.png',
  svgElementId: 'arm_left',
);

const _upperArmPngRegion = Region(
  id: 'upper_arm',
  label: 'Braço externo superior',
  type: AnatomicalRegionType.arm,
  side: BodySide.bilateral,
  svgAssetPath: 'assets/images/application_sites/upper_arm_region.png',
  svgElementId: 'upper_arm',
);

const _gluteHipRightPngRegion = Region(
  id: 'glute_hip_right',
  label: 'Glúteo/quadril direito',
  type: AnatomicalRegionType.gluteHip,
  side: BodySide.right,
  svgAssetPath: 'assets/images/application_sites/right_hip_region.png',
  svgElementId: 'glute_hip_right',
);

const _gluteHipLeftPngRegion = Region(
  id: 'glute_hip_left',
  label: 'Glúteo/quadril esquerdo',
  type: AnatomicalRegionType.gluteHip,
  side: BodySide.left,
  svgAssetPath: 'assets/images/application_sites/left_hip_region.png',
  svgElementId: 'glute_hip_left',
);

const _rightThigh = ApplicationSite(
  id: 'right_thigh',
  label: 'Coxa direita',
  bodyRegion: 'Coxa',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/thigh_right.svg',
  regionId: 'right_thigh',
);

const _leftThigh = ApplicationSite(
  id: 'left_thigh',
  label: 'Coxa esquerda',
  bodyRegion: 'Coxa',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/thigh_left.svg',
  regionId: 'left_thigh',
);

const _abdomenRight = ApplicationSite(
  id: 'abdomen_right',
  label: 'Abdômen direito',
  bodyRegion: 'Abdômen',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/abdomen_right.svg',
  regionId: 'abdomen_right',
);

const _abdomenLeft = ApplicationSite(
  id: 'abdomen_left',
  label: 'Abdômen esquerdo',
  bodyRegion: 'Abdômen',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/abdomen_left.svg',
  regionId: 'abdomen_left',
);

const _armRight = ApplicationSite(
  id: 'arm_right',
  label: 'Braço direito',
  bodyRegion: 'Braço',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/arm_right.svg',
  regionId: 'arm_right',
);

const _armLeft = ApplicationSite(
  id: 'arm_left',
  label: 'Braço esquerdo',
  bodyRegion: 'Braço',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/arm_left.svg',
  regionId: 'arm_left',
);

const _hipRight = ApplicationSite(
  id: 'hip_right',
  label: 'Quadril direito',
  bodyRegion: 'Quadril',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/hip_right.svg',
  regionId: 'hip_right',
);

const _hipLeft = ApplicationSite(
  id: 'hip_left',
  label: 'Quadril esquerdo',
  bodyRegion: 'Quadril',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/hip_left.svg',
  regionId: 'hip_left',
);

const _rightThighPngSite = ApplicationSite(
  id: 'right_thigh',
  label: 'Coxa direita',
  bodyRegion: 'Coxa',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/right_thigh_region.png',
  regionId: 'right_thigh',
);

const _leftThighPngSite = ApplicationSite(
  id: 'left_thigh',
  label: 'Coxa esquerda',
  bodyRegion: 'Coxa',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/left_thigh_region.png',
  regionId: 'left_thigh',
);

const _abdomenRightPngSite = ApplicationSite(
  id: 'abdomen_right',
  label: 'Abdômen direito',
  bodyRegion: 'Abdômen',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/abdomen_right_region.png',
  regionId: 'abdomen_right',
);

const _abdomenLeftPngSite = ApplicationSite(
  id: 'abdomen_left',
  label: 'Abdômen esquerdo',
  bodyRegion: 'Abdômen',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/abdomen_left_region.png',
  regionId: 'abdomen_left',
);

const _armRightPngSite = ApplicationSite(
  id: 'arm_right',
  label: 'Braço direito',
  bodyRegion: 'Braço',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/right_arm_region.png',
  regionId: 'arm_right',
);

const _armLeftPngSite = ApplicationSite(
  id: 'arm_left',
  label: 'Braço esquerdo',
  bodyRegion: 'Braço',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/left_arm_region.png',
  regionId: 'arm_left',
);

const _upperArmPngSite = ApplicationSite(
  id: 'upper_arm',
  label: 'Braço externo superior',
  bodyRegion: 'Braço',
  side: 'Não especificado',
  imageAssetPath: 'assets/images/application_sites/upper_arm_region.png',
  regionId: 'upper_arm',
);

const _gluteHipRightPngSite = ApplicationSite(
  id: 'glute_hip_right',
  label: 'Glúteo/quadril direito',
  bodyRegion: 'Glúteo/quadril',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/right_hip_region.png',
  regionId: 'glute_hip_right',
);

const _gluteHipLeftPngSite = ApplicationSite(
  id: 'glute_hip_left',
  label: 'Glúteo/quadril esquerdo',
  bodyRegion: 'Glúteo/quadril',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/left_hip_region.png',
  regionId: 'glute_hip_left',
);

const _copaxoneSites = [
  _abdomenRight,
  _abdomenLeft,
  _rightThigh,
  _leftThigh,
  _armRight,
  _armLeft,
  _hipRight,
  _hipLeft,
];

const _rotateEveryInjectionInstruction =
    'Troque o local de aplicação a cada dose, seguindo a orientação recebida da sua equipe de saúde.';

const _copaxoneProtocol = MedicationApplicationProtocol(
  id: 'copaxone_subcutaneous_rotation',
  strategy: ApplicationRotationStrategy.sequential,
  rotationInstruction:
      'Use uma área diferente a cada aplicação entre braços, abdômen, quadris e coxas, conforme orientação recebida.',
  regions: [
    _abdomenRightRegion,
    _abdomenLeftRegion,
    _rightThighRegion,
    _leftThighRegion,
    _armRightRegion,
    _armLeftRegion,
    _hipRightRegion,
    _hipLeftRegion,
  ],
  subRegions: [
    SubRegion(
      id: 'abdomen_right_upper',
      regionId: 'abdomen_right',
      label: 'Direita superior',
      svgElementId: 'abdomen_right_upper',
      order: 1,
      helperText: 'Evite a região próxima ao umbigo.',
    ),
    SubRegion(
      id: 'abdomen_right_lower',
      regionId: 'abdomen_right',
      label: 'Direita inferior',
      svgElementId: 'abdomen_right_lower',
      order: 2,
      helperText: 'Evite a região próxima ao umbigo.',
    ),
    SubRegion(
      id: 'abdomen_left_upper',
      regionId: 'abdomen_left',
      label: 'Esquerda superior',
      svgElementId: 'abdomen_left_upper',
      order: 3,
      helperText: 'Evite a região próxima ao umbigo.',
    ),
    SubRegion(
      id: 'abdomen_left_lower',
      regionId: 'abdomen_left',
      label: 'Esquerda inferior',
      svgElementId: 'abdomen_left_lower',
      order: 4,
      helperText: 'Evite a região próxima ao umbigo.',
    ),
    SubRegion(
      id: 'thigh_right_upper',
      regionId: 'right_thigh',
      label: 'Superior',
      svgElementId: 'thigh_right_upper',
      order: 5,
    ),
    SubRegion(
      id: 'thigh_right_middle',
      regionId: 'right_thigh',
      label: 'Média',
      svgElementId: 'thigh_right_middle',
      order: 6,
    ),
    SubRegion(
      id: 'thigh_right_lower',
      regionId: 'right_thigh',
      label: 'Inferior',
      svgElementId: 'thigh_right_lower',
      order: 7,
    ),
    SubRegion(
      id: 'thigh_left_upper',
      regionId: 'left_thigh',
      label: 'Superior',
      svgElementId: 'thigh_left_upper',
      order: 8,
    ),
    SubRegion(
      id: 'thigh_left_middle',
      regionId: 'left_thigh',
      label: 'Média',
      svgElementId: 'thigh_left_middle',
      order: 9,
    ),
    SubRegion(
      id: 'thigh_left_lower',
      regionId: 'left_thigh',
      label: 'Inferior',
      svgElementId: 'thigh_left_lower',
      order: 10,
    ),
    SubRegion(
      id: 'arm_right_posterior_upper',
      regionId: 'arm_right',
      label: 'Posterior superior',
      svgElementId: 'arm_right_posterior_upper',
      order: 11,
    ),
    SubRegion(
      id: 'arm_right_posterior_lower',
      regionId: 'arm_right',
      label: 'Posterior inferior',
      svgElementId: 'arm_right_posterior_lower',
      order: 12,
    ),
    SubRegion(
      id: 'arm_left_posterior_upper',
      regionId: 'arm_left',
      label: 'Posterior superior',
      svgElementId: 'arm_left_posterior_upper',
      order: 13,
    ),
    SubRegion(
      id: 'arm_left_posterior_lower',
      regionId: 'arm_left',
      label: 'Posterior inferior',
      svgElementId: 'arm_left_posterior_lower',
      order: 14,
    ),
    SubRegion(
      id: 'hip_right_upper',
      regionId: 'hip_right',
      label: 'Superior',
      svgElementId: 'hip_right_upper',
      order: 15,
    ),
    SubRegion(
      id: 'hip_right_lower',
      regionId: 'hip_right',
      label: 'Inferior',
      svgElementId: 'hip_right_lower',
      order: 16,
    ),
    SubRegion(
      id: 'hip_left_upper',
      regionId: 'hip_left',
      label: 'Superior',
      svgElementId: 'hip_left_upper',
      order: 17,
    ),
    SubRegion(
      id: 'hip_left_lower',
      regionId: 'hip_left',
      label: 'Inferior',
      svgElementId: 'hip_left_lower',
      order: 18,
    ),
  ],
);

const _avonexProtocol = MedicationApplicationProtocol(
  id: 'avonex_thigh_alternation',
  strategy: ApplicationRotationStrategy.alternateSides,
  rotationInstruction:
      'Alterne entre coxa direita e coxa esquerda conforme orientação recebida.',
  regions: [_rightThighRegion, _leftThighRegion],
  subRegions: [
    SubRegion(
      id: 'thigh_right_upper_lateral',
      regionId: 'right_thigh',
      label: 'Superior/lateral',
      svgElementId: 'thigh_right_upper_lateral',
      order: 1,
    ),
    SubRegion(
      id: 'thigh_left_upper_lateral',
      regionId: 'left_thigh',
      label: 'Superior/lateral',
      svgElementId: 'thigh_left_upper_lateral',
      order: 2,
    ),
  ],
);

const _rebifProtocol = MedicationApplicationProtocol(
  id: 'rebif_subcutaneous_rotation',
  strategy: ApplicationRotationStrategy.alternateSides,
  regions: [
    _abdomenRightPngRegion,
    _abdomenLeftPngRegion,
    _rightThighPngRegion,
    _leftThighPngRegion,
    _armRightPngRegion,
    _armLeftPngRegion,
    _gluteHipRightPngRegion,
    _gluteHipLeftPngRegion,
  ],
  subRegions: [],
  rotationInstruction: _rotateEveryInjectionInstruction,
);

const _betaferonProtocol = MedicationApplicationProtocol(
  id: 'betaferon_subcutaneous_rotation',
  strategy: ApplicationRotationStrategy.alternateSides,
  regions: [
    _abdomenRightPngRegion,
    _abdomenLeftPngRegion,
    _rightThighPngRegion,
    _leftThighPngRegion,
    _armRightPngRegion,
    _armLeftPngRegion,
    _gluteHipRightPngRegion,
    _gluteHipLeftPngRegion,
  ],
  subRegions: [],
  rotationInstruction: _rotateEveryInjectionInstruction,
);

const _plegridySubcutaneousProtocol = MedicationApplicationProtocol(
  id: 'plegridy_subcutaneous_rotation',
  strategy: ApplicationRotationStrategy.alternateSides,
  regions: [
    _abdomenRightPngRegion,
    _abdomenLeftPngRegion,
    _rightThighPngRegion,
    _leftThighPngRegion,
    _armRightPngRegion,
    _armLeftPngRegion,
  ],
  subRegions: [],
  rotationInstruction: _rotateEveryInjectionInstruction,
);

const _kesimptaProtocol = MedicationApplicationProtocol(
  id: 'kesimpta_subcutaneous_rotation',
  strategy: ApplicationRotationStrategy.alternateSides,
  regions: [
    _abdomenRightPngRegion,
    _abdomenLeftPngRegion,
    _rightThighPngRegion,
    _leftThighPngRegion,
    _upperArmPngRegion,
  ],
  subRegions: [],
  rotationInstruction: _rotateEveryInjectionInstruction,
);

const _copaxoneApplicationPoints = [
  ApplicationPoint(
    id: 'copaxone_abdomen_01',
    order: 1,
    label: 'Local 1',
    bodyRegion: 'Abdômen',
    side: 'Direita superior',
    parentSiteLabel: 'Abdômen direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_abdomen_points.png',
    highlightAreaId: 'abdomen_right_upper',
    helperText: 'Evite a região próxima ao umbigo.',
    regionId: 'abdomen_right',
    subRegionId: 'abdomen_right_upper',
    regionType: AnatomicalRegionType.abdomen,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'copaxone_abdomen_02',
    order: 2,
    label: 'Local 2',
    bodyRegion: 'Abdômen',
    side: 'Direita inferior',
    parentSiteLabel: 'Abdômen direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_abdomen_points.png',
    highlightAreaId: 'abdomen_right_lower',
    helperText: 'Evite a região próxima ao umbigo.',
    regionId: 'abdomen_right',
    subRegionId: 'abdomen_right_lower',
    regionType: AnatomicalRegionType.abdomen,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'copaxone_abdomen_03',
    order: 3,
    label: 'Local 3',
    bodyRegion: 'Abdômen',
    side: 'Esquerda superior',
    parentSiteLabel: 'Abdômen esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_abdomen_points.png',
    highlightAreaId: 'abdomen_left_upper',
    helperText: 'Evite a região próxima ao umbigo.',
    regionId: 'abdomen_left',
    subRegionId: 'abdomen_left_upper',
    regionType: AnatomicalRegionType.abdomen,
    bodySide: BodySide.left,
  ),
  ApplicationPoint(
    id: 'copaxone_abdomen_04',
    order: 4,
    label: 'Local 4',
    bodyRegion: 'Abdômen',
    side: 'Esquerda inferior',
    parentSiteLabel: 'Abdômen esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_abdomen_points.png',
    highlightAreaId: 'abdomen_left_lower',
    helperText: 'Evite a região próxima ao umbigo.',
    regionId: 'abdomen_left',
    subRegionId: 'abdomen_left_lower',
    regionType: AnatomicalRegionType.abdomen,
    bodySide: BodySide.left,
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_right_05',
    order: 5,
    label: 'Local 5',
    bodyRegion: 'Coxa direita',
    side: 'Superior',
    parentSiteLabel: 'Coxa direita',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_thigh_points.png',
    highlightAreaId: 'thigh_right_upper',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'right_thigh',
    subRegionId: 'thigh_right_upper',
    regionType: AnatomicalRegionType.thigh,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_right_06',
    order: 6,
    label: 'Local 6',
    bodyRegion: 'Coxa direita',
    side: 'Média',
    parentSiteLabel: 'Coxa direita',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_thigh_points.png',
    highlightAreaId: 'thigh_right_middle',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'right_thigh',
    subRegionId: 'thigh_right_middle',
    regionType: AnatomicalRegionType.thigh,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_right_07',
    order: 7,
    label: 'Local 7',
    bodyRegion: 'Coxa direita',
    side: 'Inferior',
    parentSiteLabel: 'Coxa direita',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_thigh_points.png',
    highlightAreaId: 'thigh_right_lower',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'right_thigh',
    subRegionId: 'thigh_right_lower',
    regionType: AnatomicalRegionType.thigh,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_left_08',
    order: 8,
    label: 'Local 8',
    bodyRegion: 'Coxa esquerda',
    side: 'Superior',
    parentSiteLabel: 'Coxa esquerda',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_thigh_points.png',
    highlightAreaId: 'thigh_left_upper',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'left_thigh',
    subRegionId: 'thigh_left_upper',
    regionType: AnatomicalRegionType.thigh,
    bodySide: BodySide.left,
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_left_09',
    order: 9,
    label: 'Local 9',
    bodyRegion: 'Coxa esquerda',
    side: 'Média',
    parentSiteLabel: 'Coxa esquerda',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_thigh_points.png',
    highlightAreaId: 'thigh_left_middle',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'left_thigh',
    subRegionId: 'thigh_left_middle',
    regionType: AnatomicalRegionType.thigh,
    bodySide: BodySide.left,
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_left_10',
    order: 10,
    label: 'Local 10',
    bodyRegion: 'Coxa esquerda',
    side: 'Inferior',
    parentSiteLabel: 'Coxa esquerda',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_thigh_points.png',
    highlightAreaId: 'thigh_left_lower',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'left_thigh',
    subRegionId: 'thigh_left_lower',
    regionType: AnatomicalRegionType.thigh,
    bodySide: BodySide.left,
  ),
  ApplicationPoint(
    id: 'copaxone_arm_right_11',
    order: 11,
    label: 'Local 11',
    bodyRegion: 'Braço direito',
    side: 'Posterior superior',
    parentSiteLabel: 'Braço direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_arm_points.png',
    highlightAreaId: 'arm_right_posterior_upper',
    helperText: 'Use a região posterior indicada conforme orientação recebida.',
    regionId: 'arm_right',
    subRegionId: 'arm_right_posterior_upper',
    regionType: AnatomicalRegionType.arm,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'copaxone_arm_right_12',
    order: 12,
    label: 'Local 12',
    bodyRegion: 'Braço direito',
    side: 'Posterior inferior',
    parentSiteLabel: 'Braço direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_arm_points.png',
    highlightAreaId: 'arm_right_posterior_lower',
    helperText: 'Use a região posterior indicada conforme orientação recebida.',
    regionId: 'arm_right',
    subRegionId: 'arm_right_posterior_lower',
    regionType: AnatomicalRegionType.arm,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'copaxone_arm_left_13',
    order: 13,
    label: 'Local 13',
    bodyRegion: 'Braço esquerdo',
    side: 'Posterior superior',
    parentSiteLabel: 'Braço esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_arm_points.png',
    highlightAreaId: 'arm_left_posterior_upper',
    helperText: 'Use a região posterior indicada conforme orientação recebida.',
    regionId: 'arm_left',
    subRegionId: 'arm_left_posterior_upper',
    regionType: AnatomicalRegionType.arm,
    bodySide: BodySide.left,
  ),
  ApplicationPoint(
    id: 'copaxone_arm_left_14',
    order: 14,
    label: 'Local 14',
    bodyRegion: 'Braço esquerdo',
    side: 'Posterior inferior',
    parentSiteLabel: 'Braço esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_arm_points.png',
    highlightAreaId: 'arm_left_posterior_lower',
    helperText: 'Use a região posterior indicada conforme orientação recebida.',
    regionId: 'arm_left',
    subRegionId: 'arm_left_posterior_lower',
    regionType: AnatomicalRegionType.arm,
    bodySide: BodySide.left,
  ),
  ApplicationPoint(
    id: 'copaxone_hip_right_15',
    order: 15,
    label: 'Local 15',
    bodyRegion: 'Quadril direito',
    side: 'Superior',
    parentSiteLabel: 'Quadril direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_hip_points.png',
    highlightAreaId: 'hip_right_upper',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'hip_right',
    subRegionId: 'hip_right_upper',
    regionType: AnatomicalRegionType.hip,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'copaxone_hip_right_16',
    order: 16,
    label: 'Local 16',
    bodyRegion: 'Quadril direito',
    side: 'Inferior',
    parentSiteLabel: 'Quadril direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_hip_points.png',
    highlightAreaId: 'hip_right_lower',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'hip_right',
    subRegionId: 'hip_right_lower',
    regionType: AnatomicalRegionType.hip,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'copaxone_hip_left_17',
    order: 17,
    label: 'Local 17',
    bodyRegion: 'Quadril esquerdo',
    side: 'Superior',
    parentSiteLabel: 'Quadril esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_hip_points.png',
    highlightAreaId: 'hip_left_upper',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'hip_left',
    subRegionId: 'hip_left_upper',
    regionType: AnatomicalRegionType.hip,
    bodySide: BodySide.left,
  ),
  ApplicationPoint(
    id: 'copaxone_hip_left_18',
    order: 18,
    label: 'Local 18',
    bodyRegion: 'Quadril esquerdo',
    side: 'Inferior',
    parentSiteLabel: 'Quadril esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_hip_points.png',
    highlightAreaId: 'hip_left_lower',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
    regionId: 'hip_left',
    subRegionId: 'hip_left_lower',
    regionType: AnatomicalRegionType.hip,
    bodySide: BodySide.left,
  ),
];

const _avonexApplicationPoints = [
  ApplicationPoint(
    id: 'avonex_thigh_right_01',
    order: 1,
    label: 'Local 1',
    bodyRegion: 'Coxa direita',
    side: 'Superior/lateral',
    parentSiteLabel: 'Coxa direita',
    imageAssetPath: 'assets/images/application_sites/avonex_thigh_right.png',
    highlightAreaId: 'thigh_right_upper_lateral',
    helperText:
        'Aplicação intramuscular na região superior/lateral da coxa, alternando os lados semanalmente.',
    regionId: 'right_thigh',
    subRegionId: 'thigh_right_upper_lateral',
    regionType: AnatomicalRegionType.thigh,
    bodySide: BodySide.right,
  ),
  ApplicationPoint(
    id: 'avonex_thigh_left_02',
    order: 2,
    label: 'Local 2',
    bodyRegion: 'Coxa esquerda',
    side: 'Superior/lateral',
    parentSiteLabel: 'Coxa esquerda',
    imageAssetPath: 'assets/images/application_sites/avonex_thigh_left.png',
    highlightAreaId: 'thigh_left_upper_lateral',
    helperText:
        'Aplicação intramuscular na região superior/lateral da coxa, alternando os lados semanalmente.',
    regionId: 'left_thigh',
    subRegionId: 'thigh_left_upper_lateral',
    regionType: AnatomicalRegionType.thigh,
    bodySide: BodySide.left,
  ),
];

const _medications = [
  Medication(
    id: 'copaxone_20mg',
    name: 'Copaxone 20 mg',
    activeIngredient: 'Acetato de glatirâmer',
    administrationType: AdministrationType.injectable,
    injectionType: InjectionType.subcutaneous,
    route: 'Subcutânea',
    frequencyLabel: '1 vez ao dia',
    scheduleType: MedicationScheduleType.onceDaily,
    dailyDoseCount: 1,
    intervalDays: 1,
    minimumIntervalHours: 20,
    scheduleDescription: 'Aplicação subcutânea uma vez ao dia.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: _copaxoneSites,
    applicationPoints: _copaxoneApplicationPoints,
    applicationProtocol: _copaxoneProtocol,
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'copaxone_40mg',
    name: 'Copaxone 40 mg',
    activeIngredient: 'Acetato de glatirâmer',
    administrationType: AdministrationType.injectable,
    injectionType: InjectionType.subcutaneous,
    route: 'Subcutânea',
    frequencyLabel: '3 vezes por semana',
    scheduleType: MedicationScheduleType.threeTimesPerWeek,
    weeklyDoseCount: 3,
    minimumIntervalHours: 48,
    scheduleDescription:
        'Aplicação três vezes por semana, nos mesmos dias da semana, com intervalo mínimo de 48 horas.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: _copaxoneSites,
    applicationPoints: _copaxoneApplicationPoints,
    applicationProtocol: _copaxoneProtocol,
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'avonex',
    name: 'Avonex',
    activeIngredient: 'Betainterferona 1a',
    administrationType: AdministrationType.injectable,
    injectionType: InjectionType.intramuscular,
    route: 'Intramuscular',
    frequencyLabel: '1 vez por semana',
    scheduleType: MedicationScheduleType.weekly,
    intervalDays: 7,
    minimumIntervalHours: 120,
    scheduleDescription:
        'Aplicação semanal, preferencialmente no mesmo dia e horário.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: [_rightThigh, _leftThigh],
    applicationPoints: _avonexApplicationPoints,
    applicationProtocol: _avonexProtocol,
    safetyNote: _safetyNote,
    helperText:
        'Aplicação intramuscular na parte superior/lateral da coxa, alternando o lado semanalmente.',
  ),
  Medication(
    id: 'rebif',
    name: 'Rebif',
    activeIngredient: 'Betainterferona 1a',
    administrationType: AdministrationType.injectable,
    injectionType: InjectionType.subcutaneous,
    route: 'Subcutânea',
    frequencyLabel: '3 vezes por semana',
    scheduleType: MedicationScheduleType.threeTimesPerWeek,
    weeklyDoseCount: 3,
    scheduleDescription:
        'Aplicação subcutânea três vezes por semana, conforme prescrição.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: [
      _abdomenRightPngSite,
      _abdomenLeftPngSite,
      _rightThighPngSite,
      _leftThighPngSite,
      _armRightPngSite,
      _armLeftPngSite,
      _gluteHipRightPngSite,
      _gluteHipLeftPngSite,
    ],
    applicationPoints: [],
    applicationProtocol: _rebifProtocol,
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'betaferon',
    name: 'Betaferon',
    activeIngredient: 'Betainterferona 1b',
    administrationType: AdministrationType.injectable,
    injectionType: InjectionType.subcutaneous,
    route: 'Subcutânea',
    frequencyLabel: 'Em dias alternados',
    scheduleType: MedicationScheduleType.everyOtherDay,
    intervalDays: 2,
    minimumIntervalHours: 36,
    scheduleDescription:
        'Aplicação subcutânea em dias alternados, conforme prescrição.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: [
      _abdomenRightPngSite,
      _abdomenLeftPngSite,
      _rightThighPngSite,
      _leftThighPngSite,
      _armRightPngSite,
      _armLeftPngSite,
      _gluteHipRightPngSite,
      _gluteHipLeftPngSite,
    ],
    applicationPoints: [],
    applicationProtocol: _betaferonProtocol,
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'plegridy',
    name: 'Plegridy',
    activeIngredient: 'Peginterferona beta-1a',
    administrationType: AdministrationType.injectable,
    injectionType: InjectionType.subcutaneous,
    route: 'Subcutânea',
    frequencyLabel: 'A cada 14 dias',
    scheduleType: MedicationScheduleType.every14Days,
    intervalDays: 14,
    minimumIntervalHours: 240,
    scheduleDescription:
        'Aplicação subcutânea a cada duas semanas, conforme prescrição.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: [
      _abdomenRightPngSite,
      _abdomenLeftPngSite,
      _rightThighPngSite,
      _leftThighPngSite,
      _armRightPngSite,
      _armLeftPngSite,
    ],
    applicationPoints: [],
    applicationProtocol: _plegridySubcutaneousProtocol,
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'kesimpta',
    name: 'Kesimpta',
    activeIngredient: 'Ofatumumabe',
    administrationType: AdministrationType.injectable,
    injectionType: InjectionType.subcutaneous,
    route: 'Subcutânea',
    frequencyLabel: 'Semanas iniciais e depois mensal',
    scheduleType: MedicationScheduleType.monthly,
    scheduleDescription:
        'Aplicações iniciais nas primeiras semanas conforme bula/prescrição; depois aplicação mensal.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: [
      _abdomenRightPngSite,
      _abdomenLeftPngSite,
      _rightThighPngSite,
      _leftThighPngSite,
      _upperArmPngSite,
    ],
    applicationPoints: [],
    applicationProtocol: _kesimptaProtocol,
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'tecfidera',
    name: 'Tecfidera',
    activeIngredient: 'Fumarato de dimetila',
    administrationType: AdministrationType.oral,
    injectionType: InjectionType.none,
    route: 'Oral',
    frequencyLabel: '2 vezes ao dia',
    scheduleType: MedicationScheduleType.twiceDaily,
    dailyDoseCount: 2,
    intervalHours: 12,
    minimumIntervalHours: 4,
    scheduleDescription:
        'Cápsula por via oral duas vezes ao dia, conforme fase de tratamento e prescrição.',
    requiresApplicationSite: false,
    requiresApplicationRotation: false,
    applicationSites: [],
    applicationPoints: [],
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'aubagio',
    name: 'Aubagio',
    activeIngredient: 'Teriflunomida',
    administrationType: AdministrationType.oral,
    injectionType: InjectionType.none,
    route: 'Oral',
    frequencyLabel: '1 vez ao dia',
    scheduleType: MedicationScheduleType.onceDaily,
    dailyDoseCount: 1,
    intervalDays: 1,
    scheduleDescription: 'Comprimido por via oral uma vez ao dia.',
    requiresApplicationSite: false,
    requiresApplicationRotation: false,
    applicationSites: [],
    applicationPoints: [],
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'gilenya',
    name: 'Gilenya',
    activeIngredient: 'Fingolimode',
    administrationType: AdministrationType.oral,
    injectionType: InjectionType.none,
    route: 'Oral',
    frequencyLabel: '1 vez ao dia',
    scheduleType: MedicationScheduleType.onceDaily,
    dailyDoseCount: 1,
    intervalDays: 1,
    scheduleDescription: 'Cápsula por via oral uma vez ao dia.',
    requiresApplicationSite: false,
    requiresApplicationRotation: false,
    applicationSites: [],
    applicationPoints: [],
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'tysabri',
    name: 'Tysabri',
    activeIngredient: 'Natalizumabe',
    administrationType: AdministrationType.infusion,
    injectionType: InjectionType.none,
    route: 'Infusão intravenosa',
    frequencyLabel: 'Infusão periódica',
    scheduleType: MedicationScheduleType.monthly,
    scheduleDescription:
        'Infusão intravenosa realizada em serviço de saúde, conforme prescrição.',
    requiresApplicationSite: false,
    requiresApplicationRotation: false,
    applicationSites: [],
    applicationPoints: [],
    safetyNote: _safetyNote,
  ),
  Medication(
    id: 'mavenclad',
    name: 'Mavenclad',
    activeIngredient: 'Cladribina',
    administrationType: AdministrationType.oral,
    injectionType: InjectionType.none,
    route: 'Oral',
    frequencyLabel: 'Ciclos curtos de tratamento',
    scheduleType: MedicationScheduleType.cycleBased,
    scheduleDescription:
        'Tratamento oral em ciclos específicos definidos por peso corporal, ano de tratamento e prescrição médica.',
    requiresApplicationSite: false,
    requiresApplicationRotation: false,
    applicationSites: [],
    applicationPoints: [],
    safetyNote: _safetyNote,
  ),
];
