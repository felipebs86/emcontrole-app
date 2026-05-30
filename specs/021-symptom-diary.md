# Spec 021 - Symptom Diary

## Goal

Allow the user to register symptoms, feelings, and daily observations to support future medical appointments.

## Scope

Implement:

- Diary entry model
- Drift table for diary entries
- Diary repository
- Diary screen
- Create diary entry
- View diary entries
- Empty state

Do not implement:

- timeline
- export
- charts
- cloud sync
- medical diagnosis

## Product Rules

- Diary data must be local only.
- No backend.
- No auth.
- No cloud sync.
- The diary is not a diagnosis tool.
- The user writes personal observations.
- The app must not infer disease activity or medical conclusions.

## Diary Entry Model

Fields:

- id
- createdAt
- title
- notes
- fatigueLevel
- painLevel
- moodLevel
- sleepQualityLevel

Levels:

- nullable integer from 0 to 10

## UI

Diary screen must show:

- empty state when no entries exist
- list of entries ordered newest first
- button to add new entry

## Create Entry

Fields:

- title
- notes
- fatigue level
- pain level
- mood level
- sleep quality level

Portuguese labels:

- Título
- Observações
- Fadiga
- Dor
- Humor
- Sono

## Empty State

Title:

- Nenhuma anotação ainda

Description:

- Registre sintomas, sensações ou observações para conversar com sua equipe de saúde.

## List Item

Show:

- title
- created date/time
- fatigue level when present
- pain level when present
- mood level when present

## Detail View

When tapping an entry, show:

- title
- notes
- created date/time
- fatigue level
- pain level
- mood level
- sleep quality level

Read-only in V1.

## Acceptance Criteria

- Diary entries are persisted with Drift.
- Entries survive app restart.
- Diary list loads saved entries.
- User can create an entry.
- User can view entry details.
- Empty state works.
- No backend is introduced.
- No medical conclusion is inferred.
- `flutter analyze` passes.
- `flutter test` passes if tests exist.
