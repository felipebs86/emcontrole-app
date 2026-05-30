# Spec 016 - Copaxone Presentation Split

## Goal

Split Copaxone into separate catalog entries by presentation/dosage so the app can calculate schedules correctly.

## Scope

Update:

- Medication catalog
- Medication selector
- Schedule engine
- Existing tests if needed

Do not implement:

- local notifications
- diary
- timeline

## Product Rule

Do not keep Copaxone as a single ambiguous medication with mixed frequency.

The user must choose the prescribed presentation.

## Catalog Changes

Remove generic:

- Copaxone

Add:

### Copaxone 20 mg

- name: Copaxone 20 mg
- activeIngredient: Acetato de glatirâmer
- administrationType: injectable
- injectionType: subcutaneous
- route: Subcutânea
- frequencyLabel: 1 vez ao dia
- scheduleType: onceDaily
- dailyDoseCount: 1
- intervalDays: 1
- requiresApplicationSite: true
- requiresApplicationRotation: true
- application protocol: SubcutaneousRotationProtocol

### Copaxone 40 mg

- name: Copaxone 40 mg
- activeIngredient: Acetato de glatirâmer
- administrationType: injectable
- injectionType: subcutaneous
- route: Subcutânea
- frequencyLabel: 3 vezes por semana
- scheduleType: threeTimesPerWeek
- weeklyDoseCount: 3
- minimumIntervalHours: 48
- scheduleDescription: Aplicação três vezes por semana, nos mesmos dias da semana, com intervalo mínimo de 48 horas.
- requiresApplicationSite: true
- requiresApplicationRotation: true
- application protocol: SubcutaneousRotationProtocol

## UI Requirements

Medication selector must show both entries separately:

- Copaxone 20 mg
- Copaxone 40 mg

Medication details must show:

- active ingredient
- route
- frequency
- safety note

## Schedule Engine

Copaxone 20 mg:

- after registration, next expected = next day at configured time

Copaxone 40 mg:

- follow threeTimesPerWeek rules
- preserve minimum 48h interval
- if weekday pattern is not configured yet, use default pattern based on treatment start date:
  - start day
  - start day + 2 days
  - start day + 4 days
  - then repeat weekly

Example:

- start Monday → Monday, Wednesday, Friday
- start Tuesday → Tuesday, Thursday, Saturday

## Tests

Add/adjust tests:

- Copaxone 20 mg after registration → next day
- Copaxone 40 mg start Monday → next Wednesday
- Copaxone 40 mg start Wednesday → next Friday
- Copaxone 40 mg third weekly dose → next week first dose
- minimum interval is not below 48h

## Acceptance Criteria

- Generic Copaxone no longer appears.
- Copaxone 20 mg appears.
- Copaxone 40 mg appears.
- Copaxone 20 mg calculates daily schedule.
- Copaxone 40 mg calculates 3x/week schedule.
- Existing application points still work.
- `flutter analyze` passes.
- `flutter test` passes.
