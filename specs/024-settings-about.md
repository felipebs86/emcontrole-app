# Spec 024 - Settings and About

## Goal

Create a Settings/About area that explains the app, reinforces safety, and gives the user basic local preferences.

## Scope

Implement:

- Settings screen polish
- About EMControle section
- Medical safety disclaimer
- Offline/local data explanation
- Theme mode setting
- Reminder status section if reminders already exist
- App version placeholder

Do not implement:

- account
- login
- cloud sync
- export
- backup
- analytics
- remote settings

## Product Rules

- The app is offline-first.
- No backend.
- No authentication.
- No cloud sync.
- User data stays on the device.
- The app does not replace medical advice.
- The app does not diagnose, prescribe, or recommend treatment.

## Settings Sections

### Appearance

Allow user to choose:

- Sistema
- Claro
- Escuro

Persist preference locally.

### Reminders

Show current reminder status:

- Ativados
- Desativados

If reminders are implemented:

- allow enabling/disabling if connected to existing treatment settings

Do not create new notification logic.

### About EMControle

Show:

- EMControle logo
- App name
- Short description

Text:

"EMControle ajuda pessoas com Esclerose Múltipla a acompanhar tratamento, aplicações, lembretes e registros pessoais de sintomas."

### Medical Disclaimer

Show:

"Este aplicativo não substitui orientação médica. Siga sempre a prescrição e as recomendações da sua equipe de saúde."

### Data and Privacy

Show:

"Seus dados ficam armazenados apenas neste dispositivo. O EMControle não envia dados para servidores, não usa conta online e não possui sincronização em nuvem nesta versão."

### App Version

Show placeholder:

- Versão 1.0.0

## UI Requirements

- Use Material 3 cards.
- Use clear Portuguese copy.
- Keep layout simple.
- Use orange accent consistently.
- Use EMControle logo where appropriate.

## Acceptance Criteria

- Settings screen exists and is useful.
- Theme preference can be changed and persists.
- About section exists.
- Medical disclaimer exists.
- Local data/privacy explanation exists.
- No backend or account feature is introduced.
- `flutter analyze` passes.
- `flutter test` passes.
