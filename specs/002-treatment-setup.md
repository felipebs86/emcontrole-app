# Spec 002 - Treatment Setup

## Goal

Allow the user to configure their treatment locally on first use.

## Scope

Implement:
- Treatment setup screen
- Basic treatment form
- Local in-memory state for now
- No database yet
- No reminders yet
- No medication catalog logic yet

## Fields

The form must contain:

- User name
- Medication name
- Treatment start date
- Application time
- Initial application site
- Enable reminders switch

## Validation

Required fields:

- User name
- Medication name
- Treatment start date
- Application time

## UX

The screen must be simple and friendly.

Use Portuguese labels:

- Nome
- Medicamento
- Data da primeira aplicação
- Horário da aplicação
- Local inicial de aplicação
- Ativar lembretes

Use large inputs and clear error messages.

## Behavior

- The user can fill the form.
- The user can submit the form.
- On submit, show a success message.
- Keep data only in memory for now.
- Do not persist data yet.
- Do not schedule notifications yet.

## Acceptance criteria

- Form renders correctly.
- Required validation works.
- Date picker works.
- Time picker works.
- Reminder switch works.
- Submit shows success feedback.
- `flutter analyze` passes.
