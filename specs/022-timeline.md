# Spec 022 - Timeline

## Goal

Provide a unified chronological timeline combining medication applications and diary entries.

## Scope

Implement:

* Timeline screen
* Timeline repository/service
* Timeline event model
* Combined application history + diary entries
* Date grouping
* Timeline detail navigation

Do not implement:

* charts
* analytics
* export
* cloud sync

## Product Rules

* Timeline is read-only.
* Timeline combines existing data only.
* No new medical calculations.
* No disease predictions.
* No AI analysis.

## Timeline Event Model

Create:

* id
* eventType
* title
* description
* eventDateTime

Supported event types:

* application
* diary

## Timeline Sources

Application events:

* ApplicationRecords

Diary events:

* DiaryEntries

## Sorting

Order:

* newest first

## Grouping

Group by date.

Example:

Hoje

20:00
Aplicação registrada
Copaxone 40 mg
Local 7 - Coxa esquerda

18:30
Diário
Fadiga elevada após trabalho

Ontem

08:00
Aplicação registrada
Tecfidera

## Timeline Item UI

Application:

* medication name
* application point when available
* date/time

Diary:

* title
* mood/fatigue indicators when available
* date/time

## Detail Navigation

Tap item:

Application:

* opens existing history detail

Diary:

* opens diary detail

## Empty State

Title:

* Nenhum evento registrado

Description:

* Seus registros de tratamento e sintomas aparecerão aqui.

## Navigation

Route:

* /timeline

Add navigation from:

* Home
* Diary
* History

## Acceptance Criteria

* Timeline screen exists.
* Application records appear.
* Diary entries appear.
* Events are merged correctly.
* Events are ordered newest first.
* Grouping by date works.
* Existing detail screens open.
* Empty state works.
* `flutter analyze` passes.
* `flutter test` passes.

