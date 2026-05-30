# Spec 019 - Minimum Dose Intervals

## Goal

Add medication-specific minimum interval rules between registrations/doses.

This prevents the app from allowing a new medication use too soon after a previous one.

## Scope

Implement:

- minimum interval metadata in medication catalog
- interval validation in eligibility service
- UI warning/blocking behavior
- tests for medications where interval applies

Do not implement:

- notifications
- reminders
- diary
- timeline

## Product Rules

- The app must not allow registrations that violate a known minimum interval.
- Minimum interval is medication-specific.
- The app must not provide medical advice.
- Always show:
  "Siga sempre a prescrição e orientação da sua equipe de saúde."

## Medication Model

Add:

- minimumIntervalHours

Nullable.

If null:

- no minimum interval validation is applied beyond existing schedule rules.

## Catalog Rules

### Tecfidera

- scheduleType: twiceDaily
- intervalHours: 12
- minimumIntervalHours: 4
- frequencyLabel: 2 vezes ao dia

Rule:

- allow two daily dose slots
- do not allow a second registration less than 4 hours after the previous Tecfidera registration

### Copaxone 40 mg

- scheduleType: threeTimesPerWeek
- minimumIntervalHours: 48

Rule:

- do not allow registration less than 48 hours after previous Copaxone 40 mg registration

### Copaxone 20 mg

- scheduleType: onceDaily
- minimumIntervalHours: 20

Rule:

- avoid same-day or too-close registrations

### Avonex

- scheduleType: weekly
- minimumIntervalHours: 120

Rule:

- weekly schedule adjustments may be allowed, but not extremely close duplicate registrations

### Plegridy

- scheduleType: every14Days
- minimumIntervalHours: 240

### Betaferon

- scheduleType: everyOtherDay
- minimumIntervalHours: 36

## Eligibility Service

Before allowing registration:

- get latest ApplicationRecord for same treatment/medication
- calculate hours since latest registeredAt
- if minimumIntervalHours is set and elapsed time is lower:
  - return eligibilityStatus: tooSoon
  - canRegister: false

## Eligibility Status

Add:

- tooSoon

## UI Behavior

When tooSoon:

Disable register button.

Show message:

"Registro indisponível: intervalo mínimo entre doses ainda não foi atingido."

If useful, show:

"Próximo registro possível: [date/time]"

## Registration Flow

Re-check minimum interval before saving.

If tooSoon:

- do not save record
- do not advance schedule
- do not advance rotation
- show feedback

## Tests

Add tests:

### Tecfidera

Given a dose registered at 08:00  
When trying to register again at 10:00  
Then eligibility is tooSoon

Given a dose registered at 08:00  
When trying to register again at 12:00  
Then minimum interval rule no longer blocks

### Copaxone 40 mg

Given application registered now  
When trying again before 48 hours  
Then eligibility is tooSoon

### Registration Flow

When tooSoon  
Then no record is created  
And rotation does not advance  
And schedule does not advance

## Acceptance Criteria

- Medication model supports minimumIntervalHours.
- Tecfidera has minimumIntervalHours = 4.
- Copaxone 40 mg has minimumIntervalHours = 48.
- Eligibility blocks too-soon registrations.
- Register button disables when tooSoon.
- Registration flow also protects against tooSoon.
- `flutter analyze` passes.
- `flutter test` passes.
