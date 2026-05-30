# Spec 009 - Rotation Engine Tests

## Goal

Add unit tests for the application rotation engine.

## Scope

Implement tests only.

Do not change production behavior unless needed to make the code testable.

## Test Cases

### Avonex

Given current point is Local 1 / Coxa direita  
When calculating next point  
Then next point must be Local 2 / Coxa esquerda

Given current point is Local 2 / Coxa esquerda  
When calculating next point  
Then next point must be Local 1 / Coxa direita

### Copaxone

Given current point is the first Copaxone point  
When calculating next point  
Then next point must be the second Copaxone point

Given current point is the last Copaxone point  
When calculating next point  
Then next point must return to the first Copaxone point

### Oral medications

Given medication is oral  
When calculating next point  
Then result must be null

### Infusion medications

Given medication is infusion  
When calculating next point  
Then result must be null

### Invalid current point

Given current point id does not exist  
When calculating next point  
Then result must return the first available point

## Acceptance Criteria

- Unit tests exist.
- Tests cover Avonex.
- Tests cover Copaxone.
- Tests cover oral medications.
- Tests cover infusion medications.
- Tests cover invalid current point.
- `flutter test` passes.
- `flutter analyze` passes.
