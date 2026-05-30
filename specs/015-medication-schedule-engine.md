# Spec 015 - Medication Schedule Engine

## Goal

Fix next expected medication date/time calculation for all medication frequencies.

The app must calculate the next expected use/application based on the medication schedule, not by assuming every medication is once per day.

## Problem

Tecfidera is taken twice per day, but after registering one use the app shows the next expected use as the next day.

This is incorrect.

## Scope

Implement:

- Medication schedule model improvements
- Schedule calculation service
- Correct next expected date/time calculation
- Support for multiple daily doses
- Unit tests for schedule calculation

Do not implement:

- local notifications
- reminder scheduling
- diary
- timeline

## Product Rules

- Rotation engine controls application point.
- Schedule engine controls next expected date/time.
- These concerns must be separated.
- The app must not assume all medications are once daily.
- The app must not provide medical advice.
- Always show: "Siga sempre a prescrição e orientação da sua equipe de saúde."

## Schedule Model

Add structured scheduling metadata to medication catalog.

Support:

- onceDaily
- twiceDaily
- threeTimesPerWeek
- everyOtherDay
- weekly
- every14Days
- monthly
- cycleBased
- manual

Each medication should expose:

- scheduleType
- dailyDoseCount
- intervalHours
- intervalDays
- weeklyDoseCount
- preferredWeekdays
- scheduleDescription

Use nullable fields when not applicable.

## Catalog Schedule Rules

### Tecfidera

- scheduleType: twiceDaily
- dailyDoseCount: 2
- intervalHours: 12
- frequencyLabel: 2 vezes ao dia

Expected behavior:

- if first use is 08:00, next expected use is 20:00
- after 20:00 use, next expected use is next day 08:00

### Aubagio

- scheduleType: onceDaily
- dailyDoseCount: 1
- intervalDays: 1

### Gilenya

- scheduleType: onceDaily
- dailyDoseCount: 1
- intervalDays: 1

### Copaxone 20 mg

- scheduleType: onceDaily
- dailyDoseCount: 1
- intervalDays: 1

### Copaxone 40 mg

If catalog currently represents Copaxone as mixed "20 mg daily or 40 mg 3 times per week", keep current label but default scheduleType to manual until the app supports presentation selection.

Do not guess which presentation the user uses.

### Avonex

- scheduleType: weekly
- intervalDays: 7

### Rebif

- scheduleType: threeTimesPerWeek
- weeklyDoseCount: 3

### Betaferon

- scheduleType: everyOtherDay
- intervalDays: 2

### Plegridy

- scheduleType: every14Days
- intervalDays: 14

### Kesimpta

- scheduleType: monthly
- scheduleDescription: initial loading schedule then monthly
- For V1, after initial setup, calculate as monthly unless explicitly configured otherwise.

### Tysabri

- scheduleType: monthly
- administrationType: infusion

### Mavenclad

- scheduleType: cycleBased
- For V1, do not auto-calculate complex cycles. Show manual follow-up date behavior.

## Schedule Service

Create service:

- getNextExpectedDateTime(medication, treatment, applicationRecords, now)
- getCurrentExpectedDateTime(medication, treatment, applicationRecords, now)

Rules:

### Twice Daily

Use treatment applicationTime as first daily dose.

Second dose = first dose + intervalHours.

Example:

- configured time: 08:00
- no record today
- now 07:00 → current expected 08:00
- record at 08:10 → next expected 20:00
- record at 20:10 → next expected tomorrow 08:00

### Once Daily

Next expected = next day at configured time after registration.

### Weekly

Next expected = registeredAt + 7 days, preserving configured time unless schedule adjustment has occurred.

### Every Other Day

Next expected = registeredAt + 2 days.

### Every 14 Days

Next expected = registeredAt + 14 days.

### Monthly

Next expected = registeredAt + 1 month when applicable.

### Manual/Cycle Based

Do not auto-generate complex schedule.

Show a message:

"Próxima data deve ser acompanhada conforme orientação médica."

## Eligibility Update

Eligibility service must use ScheduleService.

Duplicate detection must respect dose slots.

For Tecfidera:

- registering morning dose must not block evening dose
- registering the same morning slot twice must be blocked
- registering evening dose twice must be blocked

## UI Requirements

Home Dashboard must display:

- next expected date/time from ScheduleService
- not a hardcoded next day

For twice-daily medication, display:

- Próximo uso: hoje às 20:00
- or Próximo uso: amanhã às 08:00

## Tests

Add unit tests for:

### Tecfidera

- no record today → expected first configured time
- after morning record → expected evening dose
- after evening record → expected next morning
- duplicate morning blocked
- duplicate evening blocked

### Once Daily

- after registration → next day

### Weekly

- after registration → +7 days

### Every Other Day

- after registration → +2 days

### Every 14 Days

- after registration → +14 days

## Acceptance Criteria

- Tecfidera next use is 12 hours after first daily dose.
- Tecfidera does not jump directly to next day after morning dose.
- Duplicate detection respects twice-daily slots.
- Once-daily medications still work.
- Weekly medications still work.
- Every-other-day medications work.
- Every-14-days medications work.
- Home Dashboard uses ScheduleService.
- `flutter analyze` passes.
- `flutter test` passes.
