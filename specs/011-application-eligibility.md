# Spec 011 - Application Eligibility Rules

## Goal

Prevent accidental duplicate records while allowing medically supervised schedule adjustments, especially for weekly medications.

## Scope

Implement:

- Application eligibility service
- Duplicate registration prevention
- Frequency-aware time windows
- Early/late warning dialogs
- Weekly schedule adjustment support

Do not implement:

- database persistence
- local notifications
- scheduling
- diary
- timeline

## Product Rules

- The app must never silently create duplicate medication usage records.
- The app must never automatically register medication usage.
- The user must explicitly confirm registration.
- The app must support schedule adjustments for weekly medications.
- The app must not give medical advice.
- Always show: "Siga sempre a orientação da sua equipe de saúde."

## Eligibility Status

Create enum:

- eligible
- early
- late
- duplicate
- scheduleAdjustment
- notApplicable

## Frequency-Aware Rules

### Daily Medications

Examples:

- Copaxone 20 mg daily
- Tecfidera daily/twice daily
- Aubagio daily
- Gilenya daily

Rules:

- Do not allow more than one registration for the same expected daily period unless medication requires multiple daily doses.
- For V1, treat oral daily medications as one daily tracking event unless the catalog explicitly says otherwise.
- Registration window:
  - 2 hours before scheduled time
  - 6 hours after scheduled time
- Outside this window, allow only with warning.
- Same-day duplicate must be blocked.

### Weekly Medications

Example:

- Avonex

Rules:

- Allow weekly schedule adjustment by registering one day earlier or one day later than the expected date.
- This is considered scheduleAdjustment.
- Show warning before confirming.
- After confirmation, the next expected date must be calculated from the actual registered date, not from the previous expected date.
- This allows gradual migration of application day.

Example:

- Expected: Friday
- User registers Saturday
- Next expected date becomes next Saturday
- If user registers next Sunday, next expected date becomes next Sunday

### Every Other Day Medications

Examples:

- Betaferon

Rules:

- Do not allow duplicate registration for the same expected application date.
- Allow late/early registration with warning.
- After confirmation, next expected date must be calculated from actual registered date.

### Three Times Per Week Medications

Examples:

- Rebif
- Copaxone 40 mg three times per week

Rules:

- Do not allow duplicate registration for the same expected application slot.
- Allow off-window registration with warning.
- Do not automatically create missed records.
- After confirmation, next expected date should follow the configured schedule pattern if available.

### Every 14 Days Medications

Example:

- Plegridy

Rules:

- Do not allow duplicate registration for the same expected cycle.
- Allow early/late registration with warning.
- After confirmation, next expected date must be calculated from the actual registered date.

### Monthly / Cycle-Based Medications

Examples:

- Kesimpta
- Mavenclad
- Tysabri

Rules:

- For V1, allow manual registration with warning if outside expected date.
- Do not block based only on calendar month.
- Block only obvious duplicates on the same day.

## Application Eligibility Service

Create a service that receives:

- medication
- current scheduled date/time
- existing application records
- now

Returns:

- eligibilityStatus
- canRegister
- message

## Duplicate Rules

Block duplicates only when:

- the same medication
- the same expected application period
- already has a confirmed record

Do not block legitimate schedule adjustment for weekly medications.

## UI Behavior

### Eligible

Button enabled.

### Early

Button enabled with warning:

"Este registro está antes do horário previsto."

### Late

Button enabled with warning:

"Este registro está fora da janela prevista."

### Schedule Adjustment

Button enabled with warning:

"Este registro altera o dia previsto da aplicação. Confirme apenas se isso estiver de acordo com sua orientação médica."

### Duplicate

Button disabled.

Message:

"Esta aplicação já foi registrada para o período atual."

## ApplicationRecord Update

Ensure ApplicationRecord supports:

- scheduledAt
- registeredAt
- registrationStatus
- adjustedSchedule

registrationStatus:

- onTime
- early
- late
- scheduleAdjustment

## Acceptance Criteria

- Daily same-day duplicate is blocked.
- Weekly schedule adjustment one day earlier or later is allowed with warning.
- Weekly next expected date is calculated from actual registered date.
- Avonex can migrate from Friday to Saturday to Sunday over consecutive weeks.
- Rotation advances only after confirmed registration.
- Duplicate registration does not advance rotation.
- `flutter analyze` passes.
