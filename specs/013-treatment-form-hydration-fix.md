# Spec 013 - Treatment Form Hydration Fix

## Goal

Fix the Treatment screen so it loads and displays the previously saved treatment data.

## Problem

Treatment data is saved locally, but when opening the Treatment screen the form fields are empty/default instead of showing the persisted treatment.

## Scope

Implement only:

- load persisted treatment when opening Treatment screen
- populate form state/controllers from saved treatment
- keep selected medication restored
- keep selected application point restored
- keep application time restored
- keep treatment start date restored
- keep remindersEnabled restored

Do not implement:

- new database tables
- reminders
- notifications
- diary
- timeline

## Required Behavior

When Treatment screen opens:

- query TreatmentRepository
- if treatment exists, populate form with saved values
- if no treatment exists, show empty setup form

When saved treatment has medicationId:

- restore selected medication from medication catalog by id

When saved treatment has selectedApplicationPointId:

- restore selected application point from medication/protocol by id

When saved treatment has applicationTime:

- restore selected time in UI

When saved treatment has treatmentStartDate:

- restore selected date in UI

When saved treatment has remindersEnabled:

- restore switch value

## UI Rules

- Do not show empty fields if saved data exists.
- Do not overwrite saved data with default values during screen initialization.
- Avoid saving automatically during initial hydration.
- Save only when user explicitly submits/updates the form.

## Acceptance Criteria

- Configure treatment.
- Restart or refresh app.
- Open Treatment screen.
- Previously saved values are visible.
- Medication selector shows saved medication.
- Application point selector shows saved point when applicable.
- Date and time fields show saved values.
- Reminder switch shows saved value.
- `flutter analyze` passes.
