# Spec 005 - Application Site Illustrations

## Goal

Provide local visual illustrations for medication application sites so the user does not need to open the medication leaflet to understand where to apply the medication.

The illustrations must be bundled with the application and work completely offline.

## Scope

Implement:

* Local SVG application site illustrations
* Asset registration in pubspec.yaml
* SVG rendering support
* Application site illustration display in the UI
* Placeholder illustration fallback

Do not implement:

* database persistence
* reminders
* scheduling
* application rotation logic
* diary
* history

## Product Rules

* Images must be stored locally.
* Images must work offline.
* Do not fetch images from remote URLs.
* Do not copy medication leaflet images directly.
* Use original simplified illustrations.
* Illustrations must be easy to understand.
* Illustrations must be appropriate for all audiences.
* Illustrations must prioritize clarity over realism.

## Asset Folder Structure

Create:

assets/images/application_sites/

## Asset Format

Use SVG files.

Do not use PNG files for placeholder illustrations.

Use the flutter_svg package for rendering.

## Required Assets

Create SVG assets for:

* thigh_right.svg

* thigh_left.svg

* thigh_bilateral.svg

* abdomen_right.svg

* abdomen_left.svg

* abdomen_bilateral.svg

* arm_right.svg

* arm_left.svg

* arm_bilateral.svg

* hip_right.svg

* hip_left.svg

* hip_bilateral.svg

* upper_arm.svg

* abdomen.svg

* thigh.svg

## SVG Visual Style

Create simple medical-style illustrations.

Requirements:

* neutral human silhouette
* front view when appropriate
* simple line art
* clean geometry
* transparent background
* orange highlight for application area
* no text inside the SVG
* no decorative elements
* Material 3 compatible

The highlighted area should clearly indicate where the medication is applied.

## Dependencies

Add:

flutter_svg

## Application Site Model

Ensure ApplicationSite supports:

* id
* label
* bodyRegion
* side
* imageAssetPath

Example:

* Coxa direita → assets/images/application_sites/thigh_right.svg
* Coxa esquerda → assets/images/application_sites/thigh_left.svg
* Abdômen direito → assets/images/application_sites/abdomen_right.svg
* Abdômen esquerdo → assets/images/application_sites/abdomen_left.svg
* Braço direito → assets/images/application_sites/arm_right.svg
* Braço esquerdo → assets/images/application_sites/arm_left.svg
* Quadril direito → assets/images/application_sites/hip_right.svg
* Quadril esquerdo → assets/images/application_sites/hip_left.svg

## UI Requirements

When a medication requires application site selection:

Display:

* selected application site name
* SVG illustration
* helper text when available

Example:

Local de aplicação

Coxa direita

[SVG Illustration]

"Aplique conforme orientação recebida da sua equipe de saúde."

## Fallback Behavior

If an SVG asset is missing:

* show a placeholder card
* show application site name
* never crash the screen

## Technical Requirements

* Register assets in pubspec.yaml
* Use flutter_svg
* Support Android
* Support iOS
* Support Web

## Acceptance Criteria

* SVG assets exist.
* flutter_svg dependency is installed.
* Assets are registered correctly.
* SVG illustrations render correctly.
* Treatment Setup displays application site illustrations.
* Missing assets do not crash the application.
* No remote assets are used.
* No leaflet images are copied directly.
* flutter analyze passes.

