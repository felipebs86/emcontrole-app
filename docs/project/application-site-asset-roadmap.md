# Application Site Asset Roadmap

This document is the production roadmap for EMControle application site assets.

It combines the technical requirements from:

```text
docs/project/application-site-visual-contract.md
docs/project/application-site-art-direction.md
```

It does not define new medication behavior, new rotation order, new clinical application points, or new image generation work. It lists the assets required by the current application-site contract and recommends the order in which production-quality illustrations should be created or upgraded.

## Priority Scale

| Priority | Meaning |
|---|---|
| P0 | Required first. Highest user-facing specificity or current visual-contract risk. |
| P1 | Required for shared broad-region coverage across multiple medications. |
| P2 | Required, but can follow once shared core regions are complete. |
| P3 | Recommended future refinement; current app can function with existing shared asset, but product quality would improve with a dedicated asset. |

## Asset Type Definitions

| Type | Meaning |
|---|---|
| Detailed subregion asset | Shows multiple specific application points or one medication-specific application target. Must support precise `highlightAreaId` mapping and visual point numbering when multiple points are visible. |
| Broad region asset | Shows a general anatomical region used by generated protocol points. It may support dynamic highlighting at the region level but does not show detailed subregion point maps. |

## Production Requirements

All assets must follow the approved art direction:

- Warm clinical anatomy style.
- White or near-white background.
- EMControle orange for application zones and markers.
- Stable internal SVG IDs.
- No extra uncontracted visible application markers.
- No diagnosis, prescription, dosage, injection action, wounds, or clinical advice.
- No medication logos inside normal app assets unless a future standalone reference asset explicitly requires it.

## Copaxone

Medications:

- `copaxone_20mg`
- `copaxone_40mg`

Copaxone uses shared explicit detailed application points. Both presentations intentionally use the same asset set and the same point IDs.

| Priority | Asset | Used by | SVG IDs required inside asset | Type | Production note |
|---|---|---|---|---|---|
| P0 | `assets/images/application_sites/copaxone_abdomen_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `abdomen_right_upper`, `abdomen_right_lower`, `abdomen_left_upper`, `abdomen_left_lower` | Detailed subregion asset | Highest-priority reference asset. Must visually match the approved abdomen art direction with exactly four contracted points. |
| P0 | `assets/images/application_sites/copaxone_right_thigh_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `thigh_right_upper`, `thigh_right_middle`, `thigh_right_lower` | Detailed subregion asset | Three visible point markers for right thigh. Marker count and numbering must match `Local 5` through `Local 7` in catalog/UI context. |
| P0 | `assets/images/application_sites/copaxone_left_thigh_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `thigh_left_upper`, `thigh_left_middle`, `thigh_left_lower` | Detailed subregion asset | Three visible point markers for left thigh. Marker count and numbering must match `Local 8` through `Local 10` in catalog/UI context. |
| P0 | `assets/images/application_sites/copaxone_right_arm_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `arm_right_posterior_upper`, `arm_right_posterior_lower` | Detailed subregion asset | Two posterior right arm targets. Must make posterior/outer-arm context clear without showing injection action. |
| P0 | `assets/images/application_sites/copaxone_left_arm_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `arm_left_posterior_upper`, `arm_left_posterior_lower` | Detailed subregion asset | Two posterior left arm targets. Must mirror right arm style and anatomical scale. |
| P0 | `assets/images/application_sites/copaxone_right_hip_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `hip_right_upper`, `hip_right_lower` | Detailed subregion asset | Two right hip targets. Needs production review for anatomical clarity between hip/glute placement. |
| P0 | `assets/images/application_sites/copaxone_left_hip_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `hip_left_upper`, `hip_left_lower` | Detailed subregion asset | Two left hip targets. Needs production review for anatomical clarity between hip/glute placement. |

## Avonex

Medication:

- `avonex`

Avonex must remain limited to simple left/right thigh alternation. Do not add abdomen, arm, hip, or detailed multi-point subregions for Avonex.

| Priority | Asset | Used by | SVG IDs required inside asset | Type | Production note |
|---|---|---|---|---|---|
| P0 | `assets/images/application_sites/avonex_thigh_right.svg` | Avonex | `thigh_right_upper_lateral` | Detailed subregion asset | Single right upper/lateral thigh target. Should read as one clear intramuscular-style thigh location, not a multi-point rotation map. |
| P0 | `assets/images/application_sites/avonex_thigh_left.svg` | Avonex | `thigh_left_upper_lateral` | Detailed subregion asset | Single left upper/lateral thigh target. Must visually pair with right-side asset for alternation. |

## Rebif

Medication:

- `rebif`

Rebif currently uses generated broad-region points. It does not have detailed subregion point assets yet.

| Priority | Asset | Used by | SVG IDs required inside asset | Type | Production note |
|---|---|---|---|---|---|
| P1 | `assets/images/application_sites/abdomen_right.svg` | Rebif | `abdomen_right` | Broad region asset | Shared broad right abdomen asset. Should show one broad highlightable region, not detailed numbered points. |
| P1 | `assets/images/application_sites/abdomen_left.svg` | Rebif | `abdomen_left` | Broad region asset | Shared broad left abdomen asset. Must mirror right abdomen style. |
| P1 | `assets/images/application_sites/thigh_right.svg` | Rebif | `thigh_right` | Broad region asset | Shared broad right thigh asset. |
| P1 | `assets/images/application_sites/thigh_left.svg` | Rebif | `thigh_left` | Broad region asset | Shared broad left thigh asset. |
| P1 | `assets/images/application_sites/arm_right.svg` | Rebif | `arm_right` | Broad region asset | Shared broad right arm asset. |
| P1 | `assets/images/application_sites/arm_left.svg` | Rebif | `arm_left` | Broad region asset | Shared broad left arm asset. |
| P2 | `assets/images/application_sites/hip_right.svg` | Rebif | `glute_hip_right` | Broad region asset | Current contracted asset for right glute/hip region. This is acceptable for current behavior but should be evaluated against dedicated glute/hip production art. |
| P2 | `assets/images/application_sites/hip_left.svg` | Rebif | `glute_hip_left` | Broad region asset | Current contracted asset for left glute/hip region. This is acceptable for current behavior but should be evaluated against dedicated glute/hip production art. |
| P3 | `assets/images/application_sites/glute_hip_right.svg` | Rebif | `glute_hip_right` | Broad region asset | Recommended future dedicated asset if product wants glute/hip guidance visually distinct from generic hip. Requires code/catalog migration before use. |
| P3 | `assets/images/application_sites/glute_hip_left.svg` | Rebif | `glute_hip_left` | Broad region asset | Recommended future dedicated asset if product wants glute/hip guidance visually distinct from generic hip. Requires code/catalog migration before use. |

## Betaferon

Medication:

- `betaferon`

Betaferon currently uses the same broad-region structure as Rebif.

| Priority | Asset | Used by | SVG IDs required inside asset | Type | Production note |
|---|---|---|---|---|---|
| P1 | `assets/images/application_sites/abdomen_right.svg` | Betaferon | `abdomen_right` | Broad region asset | Shared with Rebif, Plegridy, and Kesimpta. Produce once and reuse. |
| P1 | `assets/images/application_sites/abdomen_left.svg` | Betaferon | `abdomen_left` | Broad region asset | Shared with Rebif, Plegridy, and Kesimpta. Produce once and reuse. |
| P1 | `assets/images/application_sites/thigh_right.svg` | Betaferon | `thigh_right` | Broad region asset | Shared with Rebif, Plegridy, and Kesimpta. Produce once and reuse. |
| P1 | `assets/images/application_sites/thigh_left.svg` | Betaferon | `thigh_left` | Broad region asset | Shared with Rebif, Plegridy, and Kesimpta. Produce once and reuse. |
| P1 | `assets/images/application_sites/arm_right.svg` | Betaferon | `arm_right` | Broad region asset | Shared with Rebif and Plegridy. Produce once and reuse. |
| P1 | `assets/images/application_sites/arm_left.svg` | Betaferon | `arm_left` | Broad region asset | Shared with Rebif and Plegridy. Produce once and reuse. |
| P2 | `assets/images/application_sites/hip_right.svg` | Betaferon | `glute_hip_right` | Broad region asset | Current contracted asset for right glute/hip region. Same caveat as Rebif. |
| P2 | `assets/images/application_sites/hip_left.svg` | Betaferon | `glute_hip_left` | Broad region asset | Current contracted asset for left glute/hip region. Same caveat as Rebif. |
| P3 | `assets/images/application_sites/glute_hip_right.svg` | Betaferon | `glute_hip_right` | Broad region asset | Recommended future dedicated asset. Requires a separate migration/spec before replacing `hip_right.svg`. |
| P3 | `assets/images/application_sites/glute_hip_left.svg` | Betaferon | `glute_hip_left` | Broad region asset | Recommended future dedicated asset. Requires a separate migration/spec before replacing `hip_left.svg`. |

## Plegridy

Medication:

- `plegridy`

Plegridy currently uses generated broad-region points for subcutaneous application. If a future intramuscular Plegridy protocol is added, it must be modeled separately and must not reuse this table blindly.

| Priority | Asset | Used by | SVG IDs required inside asset | Type | Production note |
|---|---|---|---|---|---|
| P1 | `assets/images/application_sites/abdomen_right.svg` | Plegridy | `abdomen_right` | Broad region asset | Shared broad right abdomen asset. |
| P1 | `assets/images/application_sites/abdomen_left.svg` | Plegridy | `abdomen_left` | Broad region asset | Shared broad left abdomen asset. |
| P1 | `assets/images/application_sites/thigh_right.svg` | Plegridy | `thigh_right` | Broad region asset | Shared broad right thigh asset. |
| P1 | `assets/images/application_sites/thigh_left.svg` | Plegridy | `thigh_left` | Broad region asset | Shared broad left thigh asset. |
| P1 | `assets/images/application_sites/arm_right.svg` | Plegridy | `arm_right` | Broad region asset | Shared broad right arm asset. |
| P1 | `assets/images/application_sites/arm_left.svg` | Plegridy | `arm_left` | Broad region asset | Shared broad left arm asset. |

## Kesimpta

Medication:

- `kesimpta`

Kesimpta currently uses generated broad-region points and includes a bilateral/unspecified upper arm region. The `upper_arm` asset should be visually distinct from generic full-arm assets.

| Priority | Asset | Used by | SVG IDs required inside asset | Type | Production note |
|---|---|---|---|---|---|
| P1 | `assets/images/application_sites/abdomen_right.svg` | Kesimpta | `abdomen_right` | Broad region asset | Shared broad right abdomen asset. |
| P1 | `assets/images/application_sites/abdomen_left.svg` | Kesimpta | `abdomen_left` | Broad region asset | Shared broad left abdomen asset. |
| P1 | `assets/images/application_sites/thigh_right.svg` | Kesimpta | `thigh_right` | Broad region asset | Shared broad right thigh asset. |
| P1 | `assets/images/application_sites/thigh_left.svg` | Kesimpta | `thigh_left` | Broad region asset | Shared broad left thigh asset. |
| P2 | `assets/images/application_sites/upper_arm.svg` | Kesimpta | `upper_arm` | Broad region asset | Must communicate assisted upper outer arm, not generic full arm. This should be produced after shared abdomen/thigh assets but before optional glute/hip refinements. |

## Consolidated Unique Asset List

This section lists each unique production file once, with all current medication consumers.

| Priority | Asset | Used by medications | SVG IDs required inside asset | Type |
|---|---|---|---|---|
| P0 | `assets/images/application_sites/copaxone_abdomen_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `abdomen_right_upper`, `abdomen_right_lower`, `abdomen_left_upper`, `abdomen_left_lower` | Detailed subregion asset |
| P0 | `assets/images/application_sites/copaxone_right_thigh_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `thigh_right_upper`, `thigh_right_middle`, `thigh_right_lower` | Detailed subregion asset |
| P0 | `assets/images/application_sites/copaxone_left_thigh_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `thigh_left_upper`, `thigh_left_middle`, `thigh_left_lower` | Detailed subregion asset |
| P0 | `assets/images/application_sites/copaxone_right_arm_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `arm_right_posterior_upper`, `arm_right_posterior_lower` | Detailed subregion asset |
| P0 | `assets/images/application_sites/copaxone_left_arm_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `arm_left_posterior_upper`, `arm_left_posterior_lower` | Detailed subregion asset |
| P0 | `assets/images/application_sites/copaxone_right_hip_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `hip_right_upper`, `hip_right_lower` | Detailed subregion asset |
| P0 | `assets/images/application_sites/copaxone_left_hip_points.svg` | Copaxone 20 mg, Copaxone 40 mg | `hip_left_upper`, `hip_left_lower` | Detailed subregion asset |
| P0 | `assets/images/application_sites/avonex_thigh_right.svg` | Avonex | `thigh_right_upper_lateral` | Detailed subregion asset |
| P0 | `assets/images/application_sites/avonex_thigh_left.svg` | Avonex | `thigh_left_upper_lateral` | Detailed subregion asset |
| P1 | `assets/images/application_sites/abdomen_right.svg` | Rebif, Betaferon, Plegridy, Kesimpta | `abdomen_right` | Broad region asset |
| P1 | `assets/images/application_sites/abdomen_left.svg` | Rebif, Betaferon, Plegridy, Kesimpta | `abdomen_left` | Broad region asset |
| P1 | `assets/images/application_sites/thigh_right.svg` | Rebif, Betaferon, Plegridy, Kesimpta | `thigh_right` | Broad region asset |
| P1 | `assets/images/application_sites/thigh_left.svg` | Rebif, Betaferon, Plegridy, Kesimpta | `thigh_left` | Broad region asset |
| P1 | `assets/images/application_sites/arm_right.svg` | Rebif, Betaferon, Plegridy | `arm_right` | Broad region asset |
| P1 | `assets/images/application_sites/arm_left.svg` | Rebif, Betaferon, Plegridy | `arm_left` | Broad region asset |
| P2 | `assets/images/application_sites/upper_arm.svg` | Kesimpta | `upper_arm` | Broad region asset |
| P2 | `assets/images/application_sites/hip_right.svg` | Rebif, Betaferon | `glute_hip_right` | Broad region asset |
| P2 | `assets/images/application_sites/hip_left.svg` | Rebif, Betaferon | `glute_hip_left` | Broad region asset |
| P3 | `assets/images/application_sites/glute_hip_right.svg` | Rebif, Betaferon | `glute_hip_right` | Broad region asset |
| P3 | `assets/images/application_sites/glute_hip_left.svg` | Rebif, Betaferon | `glute_hip_left` | Broad region asset |

## Recommended Production Order

1. Produce/approve Copaxone detailed assets, starting from `copaxone_abdomen_points.svg` because it has the approved visual reference.
2. Produce/approve Avonex thigh alternation assets, keeping exactly one target per side.
3. Produce/approve shared broad abdomen and thigh assets because they support Rebif, Betaferon, Plegridy, and Kesimpta.
4. Produce/approve shared broad arm assets for Rebif, Betaferon, and Plegridy.
5. Produce/approve Kesimpta `upper_arm.svg`, with clear assisted upper outer arm framing.
6. Review current `hip_right.svg` and `hip_left.svg` use for glute/hip regions.
7. Create dedicated `glute_hip_right.svg` and `glute_hip_left.svg` only after a separate migration/spec decides to replace the current hip asset references.

## Acceptance Checklist

Before an asset is considered production-ready:

- It follows `application-site-art-direction.md`.
- It preserves the file path required by `application-site-visual-contract.md`.
- It contains every required internal SVG ID.
- It contains no extra visible application markers outside the official point list.
- Detailed assets have one precise visible marker or zone per required ID.
- Broad assets have one precise highlightable region per required ID.
- Anatomical side orientation is correct from the user's body perspective.
- The SVG has no external dependencies or embedded raster images.
- The illustration remains readable at mobile sizes.
