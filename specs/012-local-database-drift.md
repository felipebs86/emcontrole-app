# Spec 012 - Local Database with Drift

## Goal

Persist EMControle user data locally on the device using Drift.

The app must remain fully offline and must not use backend, authentication, external APIs, cloud sync, or paid infrastructure.

## Scope

Implement:

- Drift local database setup
- Treatment persistence
- Current application point persistence
- Application history persistence
- Basic repository layer
- Load saved treatment on app startup

Do not implement:

- local notifications
- reminder scheduling
- diary
- timeline
- cloud sync
- authentication

## Product Rules

- All data must stay on the local device.
- V1 supports only one active treatment.
- No backend.
- No auth.
- No remote APIs.
- No cloud backup.
- No paid infrastructure.
- The app must work offline.

## Dependencies

Add required Drift dependencies:

- drift
- drift_flutter or sqlite3_flutter_libs if needed
- drift_dev
- build_runner

Use the setup that best supports Android, iOS, and Web.

## Database Tables

### Treatments

Fields:

- id
- userName
- medicationId
- medicationName
- selectedApplicationPointId
- selectedApplicationPointLabel
- applicationTime
- treatmentStartDate
- remindersEnabled
- createdAt
- updatedAt

V1 supports only one active treatment.

### ApplicationRecords

Fields:

- id
- treatmentId
- medicationId
- medicationName
- applicationPointId
- applicationPointLabel
- scheduledAt
- registeredAt
- registrationStatus
- adjustedSchedule
- notes

For oral/infusion medications:

- applicationPointId nullable
- applicationPointLabel nullable

## Repository Layer

Create repositories for:

- TreatmentRepository
- ApplicationRecordRepository

Repositories must abstract Drift from UI.

UI must not call database classes directly.

## Startup Behavior

When the app starts:

- if treatment exists, load it
- if no treatment exists, show treatment setup flow or empty home state

## Treatment Setup Behavior

When user submits treatment setup:

- save treatment locally
- load saved data on refresh/restart

## Register Application Behavior

When user confirms application:

- save ApplicationRecord locally
- update current application point in Treatment
- update scheduled/registered metadata as needed

## Migration

Create initial database schema version 1.

## Acceptance Criteria

- Drift database is configured.
- Treatment is persisted locally.
- Application records are persisted locally.
- App reload keeps treatment data.
- Current application point survives app restart.
- Application history survives app restart.
- UI does not access Drift directly.
- No backend or external API is introduced.
- `flutter analyze` passes.
- `flutter test` passes if tests exist.
