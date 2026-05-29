# Spec 001 - Foundation

## Goal

Create the basic Flutter foundation for EMControle.

## Scope

Implement only:
- App name
- Material 3 setup
- Light and dark theme
- Orange ribbon inspired color palette
- Basic navigation
- Basic folder structure
- Placeholder screens

## Screens

- Home
- Treatment
- Diary
- History
- Settings

## Navigation

Use GoRouter.

Initial route:

- `/`

Routes:

- `/`
- `/treatment`
- `/diary`
- `/history`
- `/settings`

## Theme

Use orange as the primary color, inspired by the Multiple Sclerosis awareness ribbon.

The UI must feel:
- calm
- clean
- accessible
- medical but human

Avoid:
- excessive gradients
- tiny text
- dense screens
- too many actions per screen

## Architecture

Create a simple structure:

lib/
  app/
  core/
  features/
    home/
    treatment/
    diary/
    history/
    settings/

## Acceptance criteria

- App runs on Chrome.
- App runs on Android emulator/device if available.
- Navigation works.
- Light and dark themes exist.
- No backend.
- No auth.
- No external APIs.
- `flutter analyze` passes.
