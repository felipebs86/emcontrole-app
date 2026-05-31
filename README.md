# EMControle

EMControle is an offline-first Flutter app created by **Felipe Bahiense Santos** to help people with Multiple Sclerosis organize treatment routines, medication use/application, local reminders, application-site rotation, diary entries, history, and a unified timeline.

The app stores user information locally on the device. It does not use accounts, authentication, backend services, cloud sync, analytics, tracking, or external APIs.

## Background

EMControle is a modern continuation of Felipe's original 2017 TCC Android native project, also called EMControle. The current version rebuilds the concept with Flutter, Material 3, local persistence, and a calmer interface focused on daily organization.

## Purpose

The goal is to help users keep information already provided by their healthcare professional organized in one local app:

- active treatment configuration
- medication use/application registration
- application-site rotation for injectable medication
- local reminders
- diary notes for symptoms and personal observations
- treatment history
- unified timeline of applications, diary entries, and treatment changes

## Main Features

- Configure the active treatment and medication routine.
- Register medication use or application.
- View the next expected use/application.
- Rotate application sites when the medication protocol requires it.
- Keep a symptom diary with emoji-based ratings.
- Review application history grouped by date.
- View a unified timeline.
- Use local reminders without cloud services.
- Choose light, dark, or system theme.

## Tech Stack

- Flutter
- Dart
- Material 3
- GoRouter
- Drift local database
- Local notifications
- Local SVG assets

## Offline-First and Privacy

EMControle is designed for local use only:

- all user data stays on the device
- no backend
- no authentication
- no cloud sync
- no cloud backup in this version
- no analytics or tracking
- no external APIs

## Medical Disclaimer

EMControle does not replace medical advice. It does not diagnose, prescribe, recommend treatment, or suggest medication dosage. Always follow the prescription and recommendations of your healthcare team.

## How to Run Locally

Prerequisites:

- Flutter SDK installed
- Dart SDK compatible with the project SDK constraint

Commands:

```sh
flutter pub get
flutter run
```

For web:

```sh
flutter run -d chrome
```

Recommended checks:

```sh
flutter analyze
flutter test
```

## GitHub Pages

The static documentation site is in [`docs/index.html`](docs/index.html). It is designed to work with GitHub Pages without JavaScript frameworks, tracking, remote fonts, or analytics.

## Project Status

MVP in active development. The app is focused on local, offline organization for V1. Backend, authentication, cloud sync, export, analytics, and AI features are intentionally out of scope.

## Author

**Felipe Bahiense Santos**  
Software Engineer  
Original creator of EMControle

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).
