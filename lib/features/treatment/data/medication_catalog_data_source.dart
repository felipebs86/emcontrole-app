import '../domain/medication.dart';

class MedicationCatalogDataSource {
  const MedicationCatalogDataSource();

  List<Medication> loadMedications() => _medications;
}

const _safetyNote =
    'Siga sempre a prescrição e orientação da sua equipe de saúde.';

const _rightThigh = ApplicationSite(
  id: 'right_thigh',
  label: 'Coxa direita',
  bodyRegion: 'Coxa',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/thigh_right.svg',
);

const _leftThigh = ApplicationSite(
  id: 'left_thigh',
  label: 'Coxa esquerda',
  bodyRegion: 'Coxa',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/thigh_left.svg',
);

const _abdomenRight = ApplicationSite(
  id: 'abdomen_right',
  label: 'Abdômen direito',
  bodyRegion: 'Abdômen',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/abdomen_right.svg',
);

const _abdomenLeft = ApplicationSite(
  id: 'abdomen_left',
  label: 'Abdômen esquerdo',
  bodyRegion: 'Abdômen',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/abdomen_left.svg',
);

const _armRight = ApplicationSite(
  id: 'arm_right',
  label: 'Braço direito',
  bodyRegion: 'Braço',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/arm_right.svg',
);

const _armLeft = ApplicationSite(
  id: 'arm_left',
  label: 'Braço esquerdo',
  bodyRegion: 'Braço',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/arm_left.svg',
);

const _hipRight = ApplicationSite(
  id: 'hip_right',
  label: 'Quadril direito',
  bodyRegion: 'Quadril',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/hip_right.svg',
);

const _hipLeft = ApplicationSite(
  id: 'hip_left',
  label: 'Quadril esquerdo',
  bodyRegion: 'Quadril',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/hip_left.svg',
);

const _abdomen = ApplicationSite(
  id: 'abdomen',
  label: 'Abdômen',
  bodyRegion: 'Abdômen',
  side: 'Não especificado',
  imageAssetPath: 'assets/images/application_sites/abdomen.svg',
);

const _upperArm = ApplicationSite(
  id: 'upper_arm',
  label: 'Braço externo superior',
  bodyRegion: 'Braço',
  side: 'Não especificado',
  imageAssetPath: 'assets/images/application_sites/upper_arm.svg',
);

const _gluteHipRight = ApplicationSite(
  id: 'glute_hip_right',
  label: 'Glúteo/quadril direito',
  bodyRegion: 'Glúteo/quadril',
  side: 'Direita',
  imageAssetPath: 'assets/images/application_sites/hip_right.svg',
);

const _gluteHipLeft = ApplicationSite(
  id: 'glute_hip_left',
  label: 'Glúteo/quadril esquerdo',
  bodyRegion: 'Glúteo/quadril',
  side: 'Esquerda',
  imageAssetPath: 'assets/images/application_sites/hip_left.svg',
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

const _standardSubcutaneousSites = [
  _abdomenRight,
  _abdomenLeft,
  _rightThigh,
  _leftThigh,
  _armRight,
  _armLeft,
];

const _copaxoneApplicationPoints = [
  ApplicationPoint(
    id: 'copaxone_abdomen_01',
    order: 1,
    label: 'Local 1',
    bodyRegion: 'Abdômen',
    side: 'Direita superior',
    parentSiteLabel: 'Abdômen direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_abdomen_points.svg',
    highlightAreaId: 'abdomen_right_upper',
    helperText: 'Evite a região próxima ao umbigo.',
  ),
  ApplicationPoint(
    id: 'copaxone_abdomen_02',
    order: 2,
    label: 'Local 2',
    bodyRegion: 'Abdômen',
    side: 'Direita inferior',
    parentSiteLabel: 'Abdômen direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_abdomen_points.svg',
    highlightAreaId: 'abdomen_right_lower',
    helperText: 'Evite a região próxima ao umbigo.',
  ),
  ApplicationPoint(
    id: 'copaxone_abdomen_03',
    order: 3,
    label: 'Local 3',
    bodyRegion: 'Abdômen',
    side: 'Esquerda superior',
    parentSiteLabel: 'Abdômen esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_abdomen_points.svg',
    highlightAreaId: 'abdomen_left_upper',
    helperText: 'Evite a região próxima ao umbigo.',
  ),
  ApplicationPoint(
    id: 'copaxone_abdomen_04',
    order: 4,
    label: 'Local 4',
    bodyRegion: 'Abdômen',
    side: 'Esquerda inferior',
    parentSiteLabel: 'Abdômen esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_abdomen_points.svg',
    highlightAreaId: 'abdomen_left_lower',
    helperText: 'Evite a região próxima ao umbigo.',
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_right_05',
    order: 5,
    label: 'Local 5',
    bodyRegion: 'Coxa direita',
    side: 'Superior',
    parentSiteLabel: 'Coxa direita',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_thigh_points.svg',
    highlightAreaId: 'thigh_right_upper',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_right_06',
    order: 6,
    label: 'Local 6',
    bodyRegion: 'Coxa direita',
    side: 'Média',
    parentSiteLabel: 'Coxa direita',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_thigh_points.svg',
    highlightAreaId: 'thigh_right_middle',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_right_07',
    order: 7,
    label: 'Local 7',
    bodyRegion: 'Coxa direita',
    side: 'Inferior',
    parentSiteLabel: 'Coxa direita',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_thigh_points.svg',
    highlightAreaId: 'thigh_right_lower',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_left_08',
    order: 8,
    label: 'Local 8',
    bodyRegion: 'Coxa esquerda',
    side: 'Superior',
    parentSiteLabel: 'Coxa esquerda',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_thigh_points.svg',
    highlightAreaId: 'thigh_left_upper',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_left_09',
    order: 9,
    label: 'Local 9',
    bodyRegion: 'Coxa esquerda',
    side: 'Média',
    parentSiteLabel: 'Coxa esquerda',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_thigh_points.svg',
    highlightAreaId: 'thigh_left_middle',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_thigh_left_10',
    order: 10,
    label: 'Local 10',
    bodyRegion: 'Coxa esquerda',
    side: 'Inferior',
    parentSiteLabel: 'Coxa esquerda',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_thigh_points.svg',
    highlightAreaId: 'thigh_left_lower',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_arm_right_11',
    order: 11,
    label: 'Local 11',
    bodyRegion: 'Braço direito',
    side: 'Posterior superior',
    parentSiteLabel: 'Braço direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_arm_points.svg',
    highlightAreaId: 'arm_right_posterior_upper',
    helperText: 'Use a região posterior indicada conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_arm_right_12',
    order: 12,
    label: 'Local 12',
    bodyRegion: 'Braço direito',
    side: 'Posterior inferior',
    parentSiteLabel: 'Braço direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_arm_points.svg',
    highlightAreaId: 'arm_right_posterior_lower',
    helperText: 'Use a região posterior indicada conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_arm_left_13',
    order: 13,
    label: 'Local 13',
    bodyRegion: 'Braço esquerdo',
    side: 'Posterior superior',
    parentSiteLabel: 'Braço esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_arm_points.svg',
    highlightAreaId: 'arm_left_posterior_upper',
    helperText: 'Use a região posterior indicada conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_arm_left_14',
    order: 14,
    label: 'Local 14',
    bodyRegion: 'Braço esquerdo',
    side: 'Posterior inferior',
    parentSiteLabel: 'Braço esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_arm_points.svg',
    highlightAreaId: 'arm_left_posterior_lower',
    helperText: 'Use a região posterior indicada conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_hip_right_15',
    order: 15,
    label: 'Local 15',
    bodyRegion: 'Quadril direito',
    side: 'Superior',
    parentSiteLabel: 'Quadril direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_hip_points.svg',
    highlightAreaId: 'hip_right_upper',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_hip_right_16',
    order: 16,
    label: 'Local 16',
    bodyRegion: 'Quadril direito',
    side: 'Inferior',
    parentSiteLabel: 'Quadril direito',
    imageAssetPath:
        'assets/images/application_sites/copaxone_right_hip_points.svg',
    highlightAreaId: 'hip_right_lower',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_hip_left_17',
    order: 17,
    label: 'Local 17',
    bodyRegion: 'Quadril esquerdo',
    side: 'Superior',
    parentSiteLabel: 'Quadril esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_hip_points.svg',
    highlightAreaId: 'hip_left_upper',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
  ),
  ApplicationPoint(
    id: 'copaxone_hip_left_18',
    order: 18,
    label: 'Local 18',
    bodyRegion: 'Quadril esquerdo',
    side: 'Inferior',
    parentSiteLabel: 'Quadril esquerdo',
    imageAssetPath:
        'assets/images/application_sites/copaxone_left_hip_points.svg',
    highlightAreaId: 'hip_left_lower',
    helperText: 'Use o ponto indicado conforme orientação recebida.',
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
    imageAssetPath: 'assets/images/application_sites/avonex_thigh_rotation.svg',
    highlightAreaId: 'thigh_right_upper_lateral',
    helperText:
        'Aplicação intramuscular na região superior/lateral da coxa, alternando os lados semanalmente.',
  ),
  ApplicationPoint(
    id: 'avonex_thigh_left_02',
    order: 2,
    label: 'Local 2',
    bodyRegion: 'Coxa esquerda',
    side: 'Superior/lateral',
    parentSiteLabel: 'Coxa esquerda',
    imageAssetPath: 'assets/images/application_sites/avonex_thigh_rotation.svg',
    highlightAreaId: 'thigh_left_upper_lateral',
    helperText:
        'Aplicação intramuscular na região superior/lateral da coxa, alternando os lados semanalmente.',
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
    scheduleDescription: 'Aplicação subcutânea uma vez ao dia.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: _copaxoneSites,
    applicationPoints: _copaxoneApplicationPoints,
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
    scheduleDescription:
        'Aplicação semanal, preferencialmente no mesmo dia e horário.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: [_rightThigh, _leftThigh],
    applicationPoints: _avonexApplicationPoints,
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
    applicationSites: _standardSubcutaneousSites,
    applicationPoints: [],
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
    scheduleDescription:
        'Aplicação subcutânea em dias alternados, conforme prescrição.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: [
      _abdomenRight,
      _abdomenLeft,
      _rightThigh,
      _leftThigh,
      _armRight,
      _armLeft,
      _gluteHipRight,
      _gluteHipLeft,
    ],
    applicationPoints: [],
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
    scheduleDescription:
        'Aplicação subcutânea a cada duas semanas, conforme prescrição.',
    requiresApplicationSite: true,
    requiresApplicationRotation: true,
    applicationSites: [_abdomen, _rightThigh, _leftThigh, _armRight, _armLeft],
    applicationPoints: [],
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
    applicationSites: [_abdomen, _rightThigh, _leftThigh, _upperArm],
    applicationPoints: [],
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
