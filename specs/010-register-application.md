# Spec 010 - Register Application

## Goal

Allow the user to confirm that they applied their medication.

When the application is confirmed, the app must register the event in memory and advance the current application point using the rotation engine.

## Scope

Implement:

- Register application button
- Confirmation dialog
- In-memory application history
- Current application point update
- Next application point calculation after confirmation
- Basic feedback after successful registration

Do not implement:

- database persistence
- local notifications
- scheduling
- diary
- timeline

## Product Rules

- The app must never automatically mark medication as applied.
- The user must explicitly confirm the application.
- The app must register the point that was actually used.
- The app must advance rotation only after confirmation.
- Oral and infusion medications must allow treatment tracking without application site rotation.

## Flow

### Injectable medication

Home screen shows:

- selected medication
- current application point
- application point illustration
- register application button

When the user taps the button:

Show confirmation dialog:

"Você aplicou o medicamento no local sugerido?"

Display:

- medication name
- current application point
- body region

Actions:

- Cancelar
- Confirmar aplicação

When confirmed:

- create an in-memory ApplicationRecord
- save medication id
- save application point id
- save application point label
- save application date/time
- update current application point to next point
- show success message
- update UI

### Oral or infusion medication

Home screen shows:

- selected medication
- frequency
- register treatment button

When confirmed:

- create an in-memory ApplicationRecord without application point
- save medication id
- save date/time
- show success message

## ApplicationRecord Model

Create model:

- id
- medicationId
- medicationName
- applicationPointId
- applicationPointLabel
- appliedAt
- notes

For oral/infusion medications:

- applicationPointId: null
- applicationPointLabel: null

## UI Copy

Use Portuguese:

- Registrar aplicação
- Confirmar aplicação
- Aplicação registrada com sucesso
- Próximo local de aplicação
- Cancelar

For oral medication, use:

- Registrar uso do medicamento

For infusion medication, use:

- Registrar tratamento

## Acceptance Criteria

- User can confirm an injectable application.
- Confirmation dialog appears before saving.
- Application record is created in memory.
- Current point advances after confirmation.
- Avonex alternates Local 1 and Local 2 after confirmations.
- Copaxone advances through the ordered points.
- Oral medications can be registered without application point.
- Infusion medications can be registered without application point.
- No database persistence is implemented.
- `flutter analyze` passes.
