# Spec 006 - Detailed Application Points & Illustrations

## Goal

Improve application site guidance by showing detailed body-region illustrations and specific numbered application points.

The user must understand the exact suggested application point without opening the medication leaflet.

## Scope

Implement:

* Detailed application point model
* Medication-specific application point lists
* More zoomed SVG illustrations by body region
* Numbered application points
* UI for showing selected point clearly

Do not implement:

* database persistence
* reminders
* notification scheduling
* diary
* history

## Product Rules

* Application guidance must be visual and specific.
* Broad regions like "Coxa direita" are not enough when the medication requires precise rotation.
* Do not copy leaflet images directly.
* Create original simplified SVG illustrations inspired by the body regions described in medication instructions.
* The app must not provide medical advice.
* Always show: "Siga sempre a orientação da sua equipe de saúde."

## Application Point Model

Create a model named ApplicationPoint with:

* id
* order
* label
* bodyRegion
* side
* parentSiteLabel
* imageAssetPath
* highlightAreaId
* helperText

Example:

* id: copaxone_abdomen_01
* order: 1
* label: Local 1
* bodyRegion: abdomen
* side: right
* parentSiteLabel: Abdômen direito
* imageAssetPath: assets/images/application_sites/copaxone_abdomen.svg
* highlightAreaId: abdomen_right_upper
* helperText: Evite a região próxima ao umbigo.

## Medication Catalog Update

Injectable medications must support applicationPoints.

For each injectable medication:

* applicationSites: broad regions
* applicationPoints: specific numbered points when applicable

## Copaxone Application Points

For Copaxone, create a rotation sequence with numbered points grouped by region.

Use these body regions:

* Abdômen
* Coxa direita
* Coxa esquerda
* Braço direito
* Braço esquerdo
* Quadril direito
* Quadril esquerdo

Create multiple numbered points per region.

Minimum V1 sequence:

* Local 1 - Abdômen direito superior
* Local 2 - Abdômen direito inferior
* Local 3 - Abdômen esquerdo superior
* Local 4 - Abdômen esquerdo inferior
* Local 5 - Coxa direita superior
* Local 6 - Coxa direita média
* Local 7 - Coxa direita inferior
* Local 8 - Coxa esquerda superior
* Local 9 - Coxa esquerda média
* Local 10 - Coxa esquerda inferior
* Local 11 - Braço direito posterior superior
* Local 12 - Braço direito posterior inferior
* Local 13 - Braço esquerdo posterior superior
* Local 14 - Braço esquerdo posterior inferior
* Local 15 - Quadril direito superior
* Local 16 - Quadril direito inferior
* Local 17 - Quadril esquerdo superior
* Local 18 - Quadril esquerdo inferior

## Avonex Application Points

For Avonex:

* Local 1 - Coxa direita
* Local 2 - Coxa esquerda

Helper text:

Aplicação intramuscular na região superior/lateral da coxa, alternando os lados semanalmente.

## SVG Illustration Requirements

Create more zoomed illustrations.

Use separate SVGs for:

* abdomen_detailed.svg
* thigh_right_detailed.svg
* thigh_left_detailed.svg
* arm_right_detailed.svg
* arm_left_detailed.svg
* hip_right_detailed.svg
* hip_left_detailed.svg

Each SVG must:

* focus on the relevant body region
* show numbered orange application points
* use clean line art
* avoid excessive anatomical detail
* have no copyrighted leaflet content
* be readable on mobile screens

## UI Requirements

When the user selects a medication and application point:

Display:

* medication name
* selected application point label
* parent body region
* detailed SVG illustration
* helper text
* safety note

Example:

Próximo local de aplicação

Local 5
Coxa direita superior

[Detailed thigh SVG with highlighted point]

Siga sempre a orientação da sua equipe de saúde.

## Acceptance Criteria

* ApplicationPoint model exists.
* Copaxone has numbered application points.
* Avonex has two application points.
* SVGs are more zoomed and readable.
* UI displays the selected point, not only broad region.
* No leaflet images are copied.
* No remote assets are used.
* flutter analyze passes.

