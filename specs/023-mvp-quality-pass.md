# Spec 023 - MVP Quality Pass

## Goal

Polish the MVP and fix important UX/product issues before adding new features.

## Scope

Improve:

- Avonex application illustration
- Diary symptom input UX
- App logo/identity
- Treatment change history and timeline integration

Do not implement:

- backend
- auth
- cloud sync
- analytics
- export
- charts

## 1. Avonex Illustration Fix

Problem:

The current Avonex illustration overlaps both legs and is hard to understand.

Required behavior:

- Replace Avonex illustration with a clearer SVG.
- Show two separated thigh options:
  - Local 1 - Coxa direita
  - Local 2 - Coxa esquerda
- Do not overlap legs.
- Use a clean front-view lower-body illustration.
- Highlight only the relevant thigh area.
- The SVG must be understandable on mobile.

Acceptance:

- Avonex Local 1 clearly highlights right thigh.
- Avonex Local 2 clearly highlights left thigh.
- No visual overlap/confusion.

## 2. Diary Rating UX

Problem:

Fatigue, pain, mood, and sleep use long dropdowns from 0 to 10.

This is clunky.

Required behavior:

Replace dropdowns with more intuitive controls.

Use:

- segmented buttons
- slider with labels
- or emoji-based scale

Preferred UX:

### Fatigue

Use 0-10 slider:

- 0 = Sem fadiga
- 10 = Fadiga extrema

### Pain

Use 0-10 slider:

- 0 = Sem dor
- 10 = Dor intensa

### Mood

Use emoji segmented control:

- 😞 Ruim
- 😐 Médio
- 🙂 Bom
- 😄 Ótimo

Internally map to numeric values.

### Sleep

Use emoji segmented control:

- 😴 Ruim
- 😐 Regular
- 🙂 Bom
- 😄 Ótimo

Internally map to numeric values.

Acceptance:

- No long dropdown is used for symptom ratings.
- Inputs are easy to use on mobile.
- Saved diary entries keep numeric values internally.

## 3. Logo and Identity

Problem:

The app does not have a clear logo.

Required behavior:

Create a simple EMControle visual identity inspired by:

- the original TCC app identity
- Multiple Sclerosis orange ribbon
- medication care/routine
- clean medical style

Create local SVG logo assets:

- assets/branding/logo_full.png
- assets/branding/app_icon.png

Logo direction:

- Use the text EMControle.
- Use orange ribbon-inspired element.
- Keep it simple and readable.
- Avoid complex medical symbols.
- Avoid copying copyrighted artwork.

Use logo in:

- splash/initial area if present
- empty states when appropriate
- about/settings screen if present

Acceptance:

- Logo asset exists.
- App has recognizable identity.
- Orange ribbon identity is present but not visually excessive.

## 4. Treatment Change Timeline Event

Problem:

When the user changes the configured medication, the timeline does not record that the treatment changed.

Product rule:

Changing the medication should not be invisible.

A treatment change is an important historical event.

Required behavior:

When user changes from one medication to another:

- persist a TreatmentChangeRecord or generic TimelineEvent
- show event in Timeline

Example:

Timeline item:

Tratamento alterado  
De: Avonex  
Para: Tecfidera  
Hoje às 14:32

If only treatment details changed but medication remains the same:

- do not create treatment change event unless medicationId changed

Treatment screen behavior:

- if existing treatment medicationId changes, create treatment change event
- update active treatment as usual

Timeline behavior:

- include treatment change events
- order them chronologically with applications and diary entries

Acceptance:

- Changing medication creates a timeline event.
- Re-saving same medication does not create duplicate treatment change event.
- Timeline shows old and new medication.
- Active treatment still updates correctly.
- Existing application history remains unchanged.

## General Quality

Also review:

- Portuguese copy
- spacing
- empty states
- navigation clarity
- mobile readability
- accessibility
- button labels

## Acceptance Criteria

- Avonex image is clear.
- Diary rating inputs are improved.
- Logo assets exist and are used.
- Treatment changes appear in Timeline.
- No backend is introduced.
- No new external API is introduced.
- `flutter analyze` passes.
- `flutter test` passes.
