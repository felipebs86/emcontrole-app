# Spec 004 - Medication Catalog Clinical Correction

## Goal

Correct the full Multiple Sclerosis medication catalog so each medication has useful default frequency, route, administration type, and application site rules.

## Scope

Update only:

* medication catalog model
* static medication data
* treatment setup display
* application site model
* placeholder support for local application site images

Do not implement:

* database persistence
* reminders
* application rotation logic
* diary
* history

## Product Rules

* V1 supports only one active Multiple Sclerosis treatment medication.
* Medication frequency must not be generic.
* Do not use "a definir pela equipe de saúde" as the main frequency.
* Each medication must have a default frequency based on its standard use.
* Always show this safety note: "Siga sempre a prescrição e orientação da sua equipe de saúde."
* Oral medications must not ask for application site.
* Infusion medications must not ask for application site.
* Injectable medications may require application site selection.
* Application site means body area, not geographic location.
* Do not use map, GPS, pin, route, place, or geographic location icons.

## Medication Model

Update the medication model to support:

* id
* name
* activeIngredient
* administrationType
* injectionType
* route
* frequencyLabel
* scheduleDescription
* requiresApplicationSite
* requiresApplicationRotation
* applicationSites
* safetyNote

## Administration Types

Supported values:

* injectable
* oral
* infusion

## Injection Types

Supported values:

* subcutaneous
* intramuscular
* none

## Application Site Model

Each site must contain:

* id
* label
* bodyRegion
* side
* imageAssetPath

Examples:

* right_thigh: Coxa direita
* left_thigh: Coxa esquerda
* abdomen_right: Abdômen direito
* abdomen_left: Abdômen esquerdo
* arm_right: Braço direito
* arm_left: Braço esquerdo
* hip_right: Quadril direito
* hip_left: Quadril esquerdo

## Catalog Corrections

### Copaxone

* activeIngredient: Acetato de glatirâmer
* administrationType: injectable
* injectionType: subcutaneous
* route: Subcutânea
* frequencyLabel: 20 mg 1 vez ao dia ou 40 mg 3 vezes por semana
* scheduleDescription: Conforme apresentação prescrita. A apresentação de 20 mg costuma ser diária; a de 40 mg costuma ser 3 vezes por semana, com intervalo mínimo entre aplicações.
* requiresApplicationSite: true
* requiresApplicationRotation: true
* applicationSites:

  * Abdômen direito
  * Abdômen esquerdo
  * Coxa direita
  * Coxa esquerda
  * Braço direito
  * Braço esquerdo
  * Quadril direito
  * Quadril esquerdo

### Avonex

* activeIngredient: Betainterferona 1a
* administrationType: injectable
* injectionType: intramuscular
* route: Intramuscular
* frequencyLabel: 1 vez por semana
* scheduleDescription: Aplicação semanal, preferencialmente no mesmo dia e horário.
* requiresApplicationSite: true
* requiresApplicationRotation: true
* applicationSites:

  * Coxa direita
  * Coxa esquerda
* helperText: Aplicação intramuscular na parte superior/lateral da coxa, alternando o lado semanalmente.

### Rebif

* activeIngredient: Betainterferona 1a
* administrationType: injectable
* injectionType: subcutaneous
* route: Subcutânea
* frequencyLabel: 3 vezes por semana
* scheduleDescription: Aplicação subcutânea três vezes por semana, conforme prescrição.
* requiresApplicationSite: true
* requiresApplicationRotation: true
* applicationSites:

  * Abdômen direito
  * Abdômen esquerdo
  * Coxa direita
  * Coxa esquerda
  * Braço direito
  * Braço esquerdo

### Betaferon

* activeIngredient: Betainterferona 1b
* administrationType: injectable
* injectionType: subcutaneous
* route: Subcutânea
* frequencyLabel: Em dias alternados
* scheduleDescription: Aplicação subcutânea em dias alternados, conforme prescrição.
* requiresApplicationSite: true
* requiresApplicationRotation: true
* applicationSites:

  * Abdômen direito
  * Abdômen esquerdo
  * Coxa direita
  * Coxa esquerda
  * Braço direito
  * Braço esquerdo
  * Glúteo/quadril direito
  * Glúteo/quadril esquerdo

### Plegridy

* activeIngredient: Peginterferona beta-1a
* administrationType: injectable
* injectionType: subcutaneous
* route: Subcutânea
* frequencyLabel: A cada 14 dias
* scheduleDescription: Aplicação subcutânea a cada duas semanas, conforme prescrição.
* requiresApplicationSite: true
* requiresApplicationRotation: true
* applicationSites:

  * Abdômen
  * Coxa direita
  * Coxa esquerda
  * Braço direito
  * Braço esquerdo

### Kesimpta

* activeIngredient: Ofatumumabe
* administrationType: injectable
* injectionType: subcutaneous
* route: Subcutânea
* frequencyLabel: Semanas iniciais e depois mensal
* scheduleDescription: Aplicações iniciais nas primeiras semanas conforme bula/prescrição; depois aplicação mensal.
* requiresApplicationSite: true
* requiresApplicationRotation: true
* applicationSites:

  * Abdômen
  * Coxa direita
  * Coxa esquerda
  * Braço externo superior

### Tecfidera

* activeIngredient: Fumarato de dimetila
* administrationType: oral
* injectionType: none
* route: Oral
* frequencyLabel: 2 vezes ao dia
* scheduleDescription: Cápsula por via oral duas vezes ao dia, conforme fase de tratamento e prescrição.
* requiresApplicationSite: false
* requiresApplicationRotation: false
* applicationSites: []

### Aubagio

* activeIngredient: Teriflunomida
* administrationType: oral
* injectionType: none
* route: Oral
* frequencyLabel: 1 vez ao dia
* scheduleDescription: Comprimido por via oral uma vez ao dia.
* requiresApplicationSite: false
* requiresApplicationRotation: false
* applicationSites: []

### Gilenya

* activeIngredient: Fingolimode
* administrationType: oral
* injectionType: none
* route: Oral
* frequencyLabel: 1 vez ao dia
* scheduleDescription: Cápsula por via oral uma vez ao dia.
* requiresApplicationSite: false
* requiresApplicationRotation: false
* applicationSites: []

### Tysabri

* activeIngredient: Natalizumabe
* administrationType: infusion
* injectionType: none
* route: Infusão intravenosa
* frequencyLabel: Infusão periódica
* scheduleDescription: Infusão intravenosa realizada em serviço de saúde, conforme prescrição.
* requiresApplicationSite: false
* requiresApplicationRotation: false
* applicationSites: []

### Mavenclad

* activeIngredient: Cladribina
* administrationType: oral
* injectionType: none
* route: Oral
* frequencyLabel: Ciclos curtos de tratamento
* scheduleDescription: Tratamento oral em ciclos específicos definidos por peso corporal, ano de tratamento e prescrição médica.
* requiresApplicationSite: false
* requiresApplicationRotation: false
* applicationSites: []

## Image Assets

Prepare support for local image assets.

Use this folder:

assets/images/application_sites/

Expected placeholder assets:

* thigh_right.png
* thigh_left.png
* abdomen_right.png
* abdomen_left.png
* arm_right.png
* arm_left.png
* hip_right.png
* hip_left.png
* abdomen.png
* thigh.png
* upper_arm.png

If real illustrations are not available yet, show neutral placeholder cards with body-region labels.

Do not fetch remote images.

Do not copy images directly from medication leaflets.

## UI Requirements

Treatment Setup must:

* show medication name
* show active ingredient
* show route
* show default frequency
* show administration type
* show safety note
* show application site selector only when requiresApplicationSite is true
* hide application site selector for oral and infusion medications

## Acceptance Criteria

* No catalog item uses "a definir pela equipe de saúde" as frequencyLabel.
* Every medication has a meaningful frequencyLabel.
* Every medication has route and administrationType.
* Injectable medications have application site data.
* Oral medications have empty applicationSites.
* Infusion medications have empty applicationSites.
* Avonex only shows right and left thigh as application sites.
* UI hides application site field for oral and infusion medications.
* UI supports imageAssetPath for application sites.
* `flutter analyze` passes.

