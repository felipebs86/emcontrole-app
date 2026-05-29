# Spec 003 - Medication Catalog

## Goal

Provide a built-in medication catalog for Multiple Sclerosis treatments.

The catalog must be bundled with the application and work completely offline.

## Scope

Implement only:

- Medication model
- Medication repository
- Static local data source
- Medication selector integration in Treatment Setup
- Replacement of any map/geographic icon used for application site fields

## Product Rules

- Version 1 supports only one active treatment medication.
- The medication represents the user's primary Multiple Sclerosis treatment.
- The user cannot register multiple active medications.
- Application site means body injection/application area, not geographic location.
- The catalog must be easy to extend through code.
- UI must not depend on hardcoded medication names.

## Medication Model

Each medication must contain:

- id
- name
- activeIngredient
- administrationType
- description
- requiresApplicationRotation
- applicationFrequency
- applicationSites

## Administration Types

Supported values:

- injectable
- oral
- infusion

## Initial Catalog V1

Include these medications:

- Copaxone
- Avonex
- Rebif
- Betaferon
- Plegridy
- Kesimpta
- Tecfidera
- Aubagio
- Gilenya
- Tysabri
- Mavenclad

## Application Sites

For this spec, only store the application site data as text/list values.

Do not implement rotation logic yet.

Do not implement application site images yet.

Do not implement body diagrams yet.

Do not use map, GPS, pin, route, place, or geographic location icons.

Use icons related to:

- health
- treatment
- medication
- body area
- injection

## UI

Replace the free-text medication input in Treatment Setup with a medication selector.

The user must choose a medication from the catalog.

Use Portuguese labels:

- Medicamento
- Tipo de administração
- Frequência
- Local inicial de aplicação

The selector should display at least:

- medication name
- administration type

If useful, show active ingredient as secondary text.

## Architecture

Repository may remain memory-based.

Do not implement database persistence yet.

Do not implement local notifications.

Do not implement reminder scheduling.

Do not implement application rotation logic.

Do not implement diary.

Do not implement history.

## Acceptance Criteria

- Medication model exists.
- Medication repository exists.
- Static local catalog exists.
- Catalog data is not hardcoded directly inside widgets.
- Treatment Setup loads medications from repository.
- User can select one medication.
- Free-text medication field is removed.
- No map/geographic icon is used for application site fields.
- `flutter analyze` passes.
