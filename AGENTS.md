# EMControle

EMControle is a Flutter app for people with Multiple Sclerosis to manage medication routines, application sites, local reminders, diary entries, and treatment history.

## Non-negotiable rules

- Offline-first only.
- No backend.
- No authentication.
- No external APIs.
- No cloud services.
- No paid infrastructure.
- All user data must be stored locally on the device.
- The app must not provide diagnosis, prescription, dosage recommendation, or medical advice.
- The app only helps users organize information already provided by their healthcare professional.

## Stack

- Flutter
- Dart
- Material 3
- Riverpod
- GoRouter
- Local database: prefer Drift over Isar if Web support becomes an issue.
- Local notifications for reminders.

## UX/UI

- Use EMControle as the app name.
- Visual identity inspired by the orange ribbon for Multiple Sclerosis awareness.
- Calm, clean, accessible interface.
- Large touch targets.
- Low cognitive load.
- Light and dark themes.
- Portuguese first.

## Development rules

- Implement one spec at a time.
- Never implement future specs unless explicitly requested.
- Keep architecture simple.
- Prefer readable code over clever abstractions.
- Run `flutter analyze` after every implementation.
