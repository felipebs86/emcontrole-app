# Spec 020 - Local Notifications

## Goal

Remind the user locally when it is time to register medication use/application.

The app must use only local notifications.

## Scope

Implement:

- local notification dependency
- permission request
- notification scheduling service
- schedule notification after treatment setup
- reschedule notification after application registration
- cancel notification when reminders are disabled

Do not implement:

- remote push notifications
- backend
- cloud sync
- diary
- timeline

## Product Rules

- Notifications must work offline.
- No backend.
- No Firebase.
- No remote push.
- No cloud service.
- User must explicitly enable reminders.
- Notifications must be based on ScheduleService.
- Notifications must not mark medication as applied.
- User must open the app and confirm registration.

## Dependencies

Use:

- flutter_local_notifications
- timezone

## Notification Content

For injectable medication:

Title:

- Hora da aplicação

Body:

- [Medication name]
- Local sugerido: [Application point label]

Example:

Copaxone 40 mg  
Local sugerido: Local 7 - Coxa esquerda

For oral medication:

Title:

- Hora do medicamento

Body:

- [Medication name]

For infusion:

Title:

- Lembrete de tratamento

Body:

- [Medication name]

## Behavior

When treatment is saved:

- if remindersEnabled is true:
  - schedule notification for next expected date/time

When application/use is registered:

- recalculate next expected date/time
- cancel previous pending notification
- schedule next notification

When reminders are disabled:

- cancel pending notifications

When treatment changes:

- cancel old notification
- schedule new one if enabled

## Permission

Ask notification permission when the user enables reminders.

If permission denied:

- keep reminders disabled
- show friendly message

## Android

Configure notification channel:

- id: medication_reminders
- name: Lembretes de medicamento
- importance: high

## Web

If local notifications are not supported on Web:

- do not crash
- show message: "Lembretes locais estão disponíveis no aplicativo instalado."

## Acceptance Criteria

- Reminder can be enabled.
- Permission flow works.
- Notification is scheduled from next expected date/time.
- Notification is rescheduled after registration.
- Notifications are canceled when reminders are disabled.
- No backend or Firebase is introduced.
- App does not crash on Web.
- `flutter analyze` passes.
- `flutter test` passes if tests exist.
