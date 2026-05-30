# Spec 014 - Home Dashboard

## Goal

Transform the Home screen into the main operational dashboard of EMControle.

The user must immediately understand:

- their current treatment
- next expected application/use
- current application point when applicable
- whether the current application can be registered
- last registered application

## Scope

Implement:

- Home dashboard layout
- Load persisted treatment
- Load latest application record
- Show next/current application information
- Show application point illustration when applicable
- Show register button on Home
- Use existing registration flow
- Use existing eligibility service
- Empty state when no treatment exists

Do not implement:

- local notifications
- reminder scheduling
- diary
- timeline
- new database tables unless strictly necessary

## Product Rules

- Home must be the primary screen for daily use.
- The user should not need to open Treatment screen to know what to do.
- The app must remain offline-first.
- The app must not provide medical advice.
- Always show safety note when relevant:
  "Siga sempre a orientação da sua equipe de saúde."

## Dashboard States

### No Treatment Configured

Show empty state:

Title:

- "Configure seu tratamento"

Text:

- "Cadastre seu medicamento principal para começar a acompanhar suas aplicações."

Primary action:

- "Configurar tratamento"

Action navigates to Treatment screen.

### Treatment Configured - Injectable

Show:

- greeting or simple header
- medication name
- active ingredient
- frequency
- next expected date/time
- current application point label
- body region
- application site illustration
- eligibility status
- register application button
- last application summary if available

### Treatment Configured - Oral

Show:

- medication name
- active ingredient
- frequency
- next expected date/time
- eligibility status
- button: "Registrar uso do medicamento"
- last use summary if available

Do not show application site illustration.

### Treatment Configured - Infusion

Show:

- medication name
- active ingredient
- frequency
- expected treatment date/time when available
- button: "Registrar tratamento"
- last treatment summary if available

Do not show application site illustration.

## UI Content

Use Portuguese.

Labels:

- Meu tratamento
- Próxima aplicação
- Próximo local de aplicação
- Última aplicação
- Registrar aplicação
- Registrar uso do medicamento
- Registrar tratamento
- Configurar tratamento

Eligibility labels:

- Em dia
- Antes do horário previsto
- Fora da janela prevista
- Já registrado

## Register Button Behavior

Use existing registration flow.

When user confirms registration:

- save ApplicationRecord
- advance current application point when applicable
- update dashboard immediately
- show success feedback

If duplicate:

- disable button
- show message explaining current period was already registered

If early/late/schedule adjustment:

- button remains enabled
- confirmation dialog shows warning

## Last Application Summary

If records exist, show latest:

- registered date/time
- medication name
- application point label when applicable
- registration status

Example:

"Última aplicação: hoje às 20:13 · Local 2 - Coxa esquerda"

## Layout Requirements

Use Material 3.

Prioritize:

- large readable cards
- clear hierarchy
- accessible contrast
- orange accent color
- no clutter

Suggested layout:

- Header card: medication summary
- Main action card: next application/application point
- Last application card
- Secondary actions: Treatment, History, Diary

## Acceptance Criteria

- Home loads saved treatment from Drift.
- Home shows empty state when no treatment exists.
- Home shows medication summary when treatment exists.
- Home shows current application point and image for injectable medications.
- Home hides application image for oral and infusion medications.
- Home shows latest application record.
- Register button works from Home.
- Dashboard updates after registration.
- Duplicate state disables registration.
- Early/late warnings still work.
- `flutter analyze` passes.
- `flutter test` passes if tests exist.
