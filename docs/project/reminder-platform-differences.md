# Reminder platform differences

EMControle uses offline-only local reminders. There is no backend, no authentication, no external API, no push provider, and no cloud scheduling.

## Android and iOS

Android and iOS are the primary and recommended reminder targets.

- The app requests local notification permission when reminders are enabled.
- The next medication reminder is scheduled with the native local notification plugin.
- Existing reminders are canceled and rescheduled when the active treatment changes or an application is registered.
- Reminder data remains on the local device.

## Web/PWA

Web/PWA reminder support is best-effort.

Lembretes na versão Web/PWA dependem do navegador e podem não funcionar em todas as situações. Para uma experiência mais confiável, utilize a versão móvel do EMControle.

Current Web/PWA limitations:

- Browser notification support varies by browser, operating system, install state, and user settings.
- Browser notification permission may be blocked or denied by the user or browser policy.
- Scheduled reminders depend on the app page remaining active in the browser session.
- Timers are not guaranteed to fire if the browser suspends, closes, discards, or heavily throttles the page.
- No remote push notifications, service worker push, backend jobs, or cloud scheduling are used.

## Debug test reminder

In debug builds, the settings screen shows a test action that schedules a reminder attempt for 1 minute later. It uses the same local notification path on Android/iOS and the same best-effort browser notification path on Web/PWA.
