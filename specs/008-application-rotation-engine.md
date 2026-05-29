# Spec 008 - Application Rotation Engine

## Goal

Implement automatic application point rotation for injectable medications.

After the user registers an application, the app must calculate the next application point based on the medication protocol.

## Scope

Implement:

- Application rotation service
- Current application point state
- Next application point calculation
- Manual initial point selection
- Preview of next application point

Do not implement:

- database persistence
- local reminders
- notification scheduling
- diary
- timeline

## Product Rules

- V1 supports only one active Multiple Sclerosis treatment medication.
- Rotation applies only to medications that require application sites.
- Oral medications do not use rotation.
- Infusion medications do not use rotation.
- The user selects the initial application point during treatment setup.
- After each confirmed application, the app advances to the next point.
- The app must not automatically mark medication as applied.
- Rotation is only advanced after explicit user confirmation.

## Rotation Protocols

Create reusable protocol behavior.

### NoApplicationSiteProtocol

Used by oral and infusion medications.

Behavior:

- has no application points
- does not require site selection
- does not rotate

### WeeklyThighProtocol

Used by Avonex.

Rotation order:

1. Coxa direita
2. Coxa esquerda

After Local 2, return to Local 1.

### SubcutaneousRotationProtocol

Used by subcutaneous injectable medications such as:

- Copaxone
- Rebif
- Betaferon
- Plegridy
- Kesimpta

Behavior:

- uses ordered application points
- advances sequentially
- after the last point, returns to the first point

## Rotation Service

Create a service responsible for calculating the next point.

Example API:

- getInitialPoint(medication)
- getNextPoint(medication, currentPointId)
- getPointById(medication, pointId)

## Edge Cases

- If medication has no application points, return null.
- If currentPointId is null, return the first available point.
- If currentPointId does not exist, return the first available point.
- If currentPointId is the last point, return the first point.

## UI Requirements

Treatment Setup must:

- allow selecting initial application point for injectable medications
- hide application point selection for oral and infusion medications
- show preview of the next point after selection if applicable

Home/Dashboard placeholder may show:

- current selected medication
- current application point
- next application point preview

Do not implement full dashboard yet.

## Acceptance Criteria

- Rotation service exists.
- Avonex alternates between right and left thigh.
- Subcutaneous medications advance through ordered points.
- Oral medications do not show rotation.
- Infusion medications do not show rotation.
- Initial point can be selected.
- Next point can be calculated.
- No automatic application confirmation exists.
- flutter analyze passes.
