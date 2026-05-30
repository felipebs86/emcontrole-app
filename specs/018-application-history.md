# Spec 018 - Application History

## Goal

Provide a complete application history so the user can review past medication uses and application sites.

## Scope

Implement:

- History screen
- Application history list
- History details
- Empty state
- Grouping by date
- Integration with persisted ApplicationRecords

Do not implement:

- notifications
- diary
- timeline
- export
- editing history

## Product Rules

- History is read-only in V1.
- Application records cannot be edited.
- Application records cannot be deleted.
- History must reflect exactly what was registered.
- The app must not infer missing records.

## Navigation

Add History screen accessible from:

- Home
- Bottom navigation if present

Route:

- /history

## Data Source

Use persisted ApplicationRecords.

Order:

- newest first

## Empty State

Title:

- Nenhuma aplicação registrada

Description:

- Suas aplicações aparecerão aqui conforme forem registradas.

## History List

Group records by date.

Example:

Hoje

- 20:00 · Tecfidera · Uso registrado
- 08:00 · Tecfidera · Uso registrado

Ontem

- 21:15 · Copaxone 40 mg · Local 7

## List Item Content

Always show:

- medication name
- registered date/time
- registration status

For injectable medications also show:

- application point label
- body region when available

Examples:

Copaxone 40 mg
Local 7 - Coxa esquerda
Hoje às 20:13

Avonex
Local 2 - Coxa esquerda
14/09/2025 às 21:00

Tecfidera
Uso registrado
14/09/2025 às 08:00

## Details Screen

Tap a history item.

Show:

- medication name
- active ingredient
- registration date/time
- scheduled date/time
- registration status
- application point
- body region
- illustration if applicable

Do not allow editing.

Do not allow deleting.

## Registration Status Labels

Translate:

- onTime -> Em dia
- early -> Antecipado
- late -> Fora da janela prevista
- scheduleAdjustment -> Ajuste de agenda

## UI Requirements

Use Material 3.

Prioritize:

- readability
- large touch targets
- clear dates
- accessible typography

## Acceptance Criteria

- History screen exists.
- Records are loaded from Drift.
- Records survive app restart.
- Records are ordered newest first.
- Empty state works.
- Injectable records show application point.
- Oral medications show usage history correctly.
- Details screen opens.
- History is read-only.
- `flutter analyze` passes.
- `flutter test` passes.
