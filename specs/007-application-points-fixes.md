# Spec 007 - Application Points Fixes

## Goal

Fix application point selection bugs and improve application site illustrations.

## Scope

Implement only:

* Dropdown selection bug fix
* ApplicationPoint equality/value stability
* Medication-specific illustration consistency
* Improved SVG body illustrations

Do not implement:

* database persistence
* reminders
* scheduling
* rotation engine
* diary
* history

## Bug 1 - Dropdown Assertion

The app currently crashes with:

"There should be exactly one item with [DropdownButton]'s value: Instance of 'ApplicationPoint'"

Fix this by ensuring Dropdown values are stable and unique.

## Required Fix

Do not use full ApplicationPoint objects as Dropdown values.

Use ApplicationPoint.id as the Dropdown value.

Example:

* DropdownButtonFormField<String>
* value: selectedApplicationPointId
* item.value: applicationPoint.id

When rendering the selected point, find the ApplicationPoint by id.

## Rules

* Every ApplicationPoint id must be globally unique.
* No duplicated ids.
* Dropdown item values must be strings.
* Do not rely on object identity for dropdown comparison.

## Bug 2 - Illustration Number Mismatch

Medication-specific application points must match the displayed illustration.

Example problem:

* Avonex says "Local 1"
* image shows locations 11, 12, 13

This must not happen.

## Required Fix

Use protocol-specific or medication-specific illustration assets.

Avonex must not reuse a generic thigh image with unrelated numbering.

## Avonex Illustration

Create:

assets/images/application_sites/avonex_thigh_rotation.svg

It must show only:

* Local 1 - Coxa direita
* Local 2 - Coxa esquerda

## Copaxone Illustration

Create region-specific detailed assets:

* copaxone_abdomen_points.svg
* copaxone_right_thigh_points.svg
* copaxone_left_thigh_points.svg
* copaxone_right_arm_points.svg
* copaxone_left_arm_points.svg
* copaxone_right_hip_points.svg
* copaxone_left_hip_points.svg

Each SVG must show only the points relevant to that region.

## Image Matching Rule

For each ApplicationPoint:

* label shown in UI must match the number shown in the SVG
* imageAssetPath must point to an SVG containing that point
* do not show unrelated numbered points

## Bug 3 - Poor Illustration Quality

Current SVGs look too simplistic.

Improve illustrations so they look like simplified medical diagrams instead of stick figures.

## SVG Style Requirements

Use:

* more realistic human body contours
* torso/limb silhouettes with natural proportions
* clean medical line art
* subtle gray outline
* orange highlighted points
* larger body region focus
* no stick figures
* no childish drawings
* no decorative elements
* no copied leaflet images
* no remote assets

The illustrations should be original, simplified, and medically understandable.

## UI Requirements

When showing the selected application point:

Display:

* selected point label
* parent body region
* matching SVG
* helper text
* safety note

If a point belongs to Avonex, show only the Avonex thigh rotation image.

If a point belongs to Copaxone, show the matching Copaxone region image.

## Acceptance Criteria

* Dropdown no longer crashes.
* Dropdown uses ApplicationPoint.id as value.
* All ApplicationPoint ids are unique.
* Avonex does not show Copaxone or generic unrelated numbered points.
* Displayed point label matches the SVG numbering.
* SVGs have improved body contours.
* No stick figure illustrations remain for application guidance.
* flutter analyze passes.

