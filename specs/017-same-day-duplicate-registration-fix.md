# Spec 017 - Same-Day Duplicate Registration Fix

## Goal

Prevent repeated same-day medication registrations after the user already registered an application/use for the current day.

## Problem

When using Copaxone 40 mg, the app allows the user to register multiple applications on the same day.

Each registration advances the next expected date, but the button remains available, allowing false application records.

## Scope

Fix:

- eligibility service
- registration flow
- dashboard button state
- duplicate detection tests

Do not implement:

- notifications
- reminders
- diary
- timeline

## Product Rules

- The app must never allow repeated accidental registrations on the same day for the same treatment.
- Rotation must not advance more than once for the same actual day.
- Schedule must not advance more than once for the same actual day.
- Duplicate prevention must be checked before registration and during registration.
- UI button state must reflect duplicate status immediately after registration.

## Duplicate Rule

For V1:

Block same-day duplicate registration for all medications.

If the same treatment already has a record with registeredAt on the same local calendar day, the user cannot register again that day.

Exception:

- Medications with scheduleType twiceDaily must allow up to two distinct dose slots per day.
- For twiceDaily, block duplicate only for the same slot, not the whole day.

## Copaxone 40 mg Rule

For Copaxone 40 mg:

- allow only one confirmed registration per local calendar day
- after registration, button must become disabled
- message must show:
  "Esta aplicação já foi registrada hoje."
- next expected date can advance normally, but user cannot register it before that date/window

## Eligibility Service

Update eligibility service to check:

- existing records for same treatment
- same local calendar day
- scheduleType
- current expected slot

Return duplicate when registration is not allowed.

## Registration Flow

Before saving a new ApplicationRecord:

- re-check eligibility
- if duplicate, do not save
- if duplicate, do not advance application point
- if duplicate, do not advance next expected date
- show duplicate feedback

This protects against UI state bugs.

## Dashboard

After successful registration:

- reload latest records
- recompute eligibility
- disable button when duplicate
- show duplicate message

## Tests

Add tests:

### Copaxone 40 mg

Given one registration today  
When checking eligibility again today  
Then status is duplicate  
And canRegister is false

Given duplicate attempt today  
When registering again  
Then no new record is created  
And rotation does not advance

### Copaxone 20 mg

Given one registration today  
When checking eligibility again today  
Then status is duplicate

### Avonex

Given one registration today  
When checking eligibility again today  
Then status is duplicate

### Tecfidera

Given morning dose registered  
When evening dose slot is due  
Then registration is allowed

Given morning dose registered  
When attempting morning slot again  
Then status is duplicate

Given evening dose registered  
When attempting evening slot again  
Then status is duplicate

## Acceptance Criteria

- Copaxone 40 mg cannot be registered multiple times on the same day.
- Button disables immediately after registration.
- Duplicate attempt does not create a record.
- Duplicate attempt does not advance rotation.
- Duplicate attempt does not advance schedule.
- Twice-daily medications still support two daily dose slots.
- `flutter analyze` passes.
- `flutter test` passes.
