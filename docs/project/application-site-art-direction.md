# Application Site Art Direction

This document defines the visual language for future EMControle medication application site illustrations.

Approved references:

```text
docs/project/reference-assets/copaxone-abdomen-approved.png
docs/project/reference-assets/copaxone-right-thigh-approved.png
```

The approved references are the art-direction source of truth for style, hierarchy, colors, anatomy rendering, body proportions, line treatment, marker scale, label hierarchy, and point spacing. Future assets do not need to copy the references exactly, but they must visually match the same illustration system.

## Purpose

Application site illustrations must help users recognize the correct body region and application point with low cognitive load. They are visual aids inside EMControle, not educational posters, medication leaflets, treatment instructions, or safety handouts.

These illustrations must not provide diagnosis, prescribe treatment, recommend dosage, mention medication schedules, or replace healthcare professional guidance. They must not include treatment instructions, safety notes, medication brand names, or medication logos.

## Visual Principles

- Clinical, calm, and clean.
- Portuguese-first visual language.
- High readability on mobile screens.
- Anatomically recognizable without being graphic.
- Friendly and approachable, but not playful.
- Precise enough to support point rotation, future dynamic highlighting, and heatmaps.
- Reusable across medications whenever the anatomical region and application contract are the same.
- Original artwork only. Do not copy medication leaflets, brand materials, or third-party medical diagrams.
- Visual aid only. Do not design the asset as a poster, leaflet, infographic, or educational card.

## Overall Composition

Use a centered anatomical illustration as the primary focus.

The body region must occupy most of the canvas. Maximize anatomical visibility while leaving enough padding for strokes, marker outlines, and future dynamic highlight states. The composition should remain legible when scaled down inside the app.

Preferred layout:

- White or near-white background.
- Anatomical region centered vertically and horizontally.
- Application zones placed directly on the body illustration.
- Minimal secondary text callouts only when they are required for a standalone review/reference image.
- No embedded brand title, medication name, treatment instructions, or safety note band in production application-site assets.

Avoid:

- Medication brand names or logos.
- Treatment instructions or safety notes.
- Decorative backgrounds.
- Gradients unrelated to anatomy.
- Heavy shadows.
- Busy clinical chart styling.
- Cartoon, mascot, or game-like rendering.
- Dark UI-style panels.
- Photorealistic skin texture.

## Canvas

Use a body-region-first canvas. The anatomy should be large, cropped intentionally, and visually dominant.

Official approved reference canvas:

```text
1402 x 1122 px
```

Use this ratio for full review references when possible. In-app SVGs may use tighter viewBoxes, but they must preserve the same visual density: anatomy first, markers second, text third.

Recommended in-app SVG viewBox patterns:

```text
Abdomen: 320 x 260
Thigh: 260 x 340
Arm: 250 x 330
Hip/glute: 300 x 280
```

The body region must remain centered and should fill most of the available space without touching the canvas edges. Leave padding for strokes, marker outlines, and dynamic highlight expansion, not for poster-like explanatory content.

## Reference Proportions

Future assets must match the proportions established by the approved abdomen and right thigh references.

### Anatomy Proportions

The anatomy should feel close, cropped, and clinically readable:

- The anatomical subject should occupy approximately 70-85% of the canvas height in full review references.
- The anatomical subject should occupy approximately 45-65% of the canvas width when side callouts are present.
- In app-only assets without callouts, the anatomy may occupy 75-90% of the canvas width.
- Cropping should reveal enough context to identify the region, such as waistband for abdomen/hip or shorts/adjacent leg for thigh.
- Cropping should not show a full person when a regional view is enough.
- The body should be centered on the application zone, not centered on clothing or text.

For abdomen assets:

- Show torso from upper abdomen/lower chest context to waistband or hip line.
- Keep the navel visible as a neutral orientation landmark when abdomen zones are shown.
- Keep the abdomen broad and frontal, with the user's left/right sides visually balanced.

For thigh assets:

- Show upper-to-lower thigh with enough shorts/hip context to identify the right or left leg.
- Show the target thigh as dominant and the opposite leg only as soft context if useful.
- Use a slight natural taper from upper thigh to knee/lower thigh.

### Marker Size

Numbered markers must be large enough to read on mobile and must visually match the approved references.

For a 1402 x 1122 review canvas:

- Main numbered marker diameter should be approximately 58-72 px.
- White outline should be approximately 5-8 px.
- Number glyph should fill roughly 55-65% of the marker diameter.
- Side-callout mini markers should match the main marker style and may be the same size or slightly smaller.

For responsive SVGs:

- Marker diameter should be approximately 5-7% of the shorter viewBox dimension.
- Marker outline should be approximately 8-12% of marker diameter.
- Marker numbers must remain readable at 320 px rendered width.

### Marker Spacing

Markers and zones must read as separate application targets:

- Keep markers centered inside their own zone.
- Leave at least one marker diameter of clear space between neighboring zones whenever anatomy allows.
- Avoid placing markers close to anatomical landmarks such as the navel, waistband edge, hip crease, or knee area.
- Keep vertical rhythm consistent for stacked regions, as in the right thigh reference.
- Keep left/right pair spacing symmetrical for paired abdomen zones.

### Line Thickness

Line weights should be visible but soft:

- Body contour: medium soft line, approximately 2-4 px on a 1402 x 1122 reference canvas.
- Clothing contour: lighter line than body contour, approximately 1.5-3 px.
- Application zone dashed outline: approximately 2-3 px.
- Hatching line: thin and subtle, approximately 1 px or less visually.
- Leader line dots: small round dots, approximately 3-5 px, with generous spacing.

In responsive SVGs, scale line thickness proportionally but preserve hierarchy:

1. Marker outline strongest.
2. Zone dashed outline next.
3. Body contour next.
4. Hatching and internal anatomy detail lightest.

### Body Contour Style

The approved references use soft semi-realistic body contours:

- Edges are clean but not vector-sharp.
- Contours use muted warm gray-brown, not black.
- Shading is smooth, low-contrast, and anatomical.
- Skin texture is minimal and airbrushed.
- Internal landmarks are subtle and should never compete with markers.
- Clothing is white or very light neutral, softly shaded, and secondary to anatomy.

Avoid hard comic-style outlines, flat icon anatomy, black strokes, high-contrast medical atlas rendering, and photorealistic skin.

## Color Palette

Use warm clinical neutrals and EMControle's orange application language.

### Background

- Primary background: `#FFFFFF`
- Warm off-white: `#FFF8F1`
- Very light beige anatomy fill: `#F4E8DE`

### Anatomy

- Main skin tone: light warm beige, close to `#F4E8DE`
- Secondary skin shade: soft beige-gray
- Anatomy outline: muted gray-brown, close to `#806E63`
- Subtle internal anatomical lines: muted beige-gray, close to `#BFA99A` or `#DDCABC`

### Application Highlight

- Primary orange: use a vivid medical orange close to `#F97316`.
- Acceptable orange range: `#F57C00` to `#F97316`.
- Existing SVG compatibility orange: `#DF6725`.
- Light orange fill: orange at low opacity, approximately 12-24%
- Dashed zone outline: primary orange
- Marker number text: white
- Marker outline: white or near-white

The approved references use the same orange language for zone outlines, dotted leader lines, and marker circles. Future assets should avoid shifting toward red, brown, yellow, or neon orange.

### Text

When minimal text is part of a standalone review/reference image:

- Label heading: dark navy close to `#0B3473`
- Body label: dark charcoal close to `#202124`
- Secondary text: dark neutral gray

Production application-site assets should generally avoid embedded text. They must not include medication brand names, treatment instructions, safety notes, or poster-style title blocks.

## Anatomy Rendering

Anatomy should be semi-realistic and softly shaded.

Required qualities:

- Smooth skin fill with subtle tonal variation.
- Clean outer contour with a medium-weight muted outline.
- Minimal internal anatomical details.
- No visible veins, wounds, needles, syringes, bruising, or injection action.
- Body proportions should be neutral and non-sexualized.
- Clothing may be shown only as a neutral framing element when useful, such as a waistband for abdomen/hip context.

The reference abdomen uses:

- Soft torso contour.
- Subtle chest/waist context.
- Navel as a small neutral anatomical landmark.
- Light waistband at the bottom.
- No facial features or full-body identity.

Future assets should follow the same restrained anatomical detail level.

## Application Zones

Application zones are the most important visual element after the anatomy.

Use translucent orange zones with dashed orange outlines. The zone shape should be organic and anatomical, not a perfect geometric rectangle, unless the clinical point is intentionally broad.

Required zone style:

- Fill: light orange, low opacity.
- Outline: orange dashed stroke.
- Corners: rounded/organic.
- Optional diagonal hatching inside the zone.
- Hatching should be subtle and lighter than the outline.
- Zone must not overlap unsafe anatomical landmarks such as the navel unless the contract specifically permits it.

Zone proportions should follow the approved references:

- Zones are broad rounded anatomical patches, not tiny dots.
- Abdomen zones are roughly rectangular with organic rounded corners.
- Thigh zones are vertically stacked rounded patches following the thigh taper.
- A zone should be large enough to read as an area while still making its associated marker unambiguous.
- Zone opacity should allow anatomy shading to remain visible underneath.

The reference abdomen uses four zones:

- Right upper abdomen.
- Right lower abdomen.
- Left upper abdomen.
- Left lower abdomen.

The zones are spatially separated and visually equal in hierarchy.

## Point Markers

Detailed application point maps must use one marker per contracted point.

Required marker style:

- Orange circle.
- White number centered inside.
- White outline.
- Strong contrast against the zone.
- Marker should sit inside its corresponding application zone.
- Marker number must match the official `Local N` order.

Marker scale and treatment must match the approved references:

- Use a saturated orange fill.
- Use a clean white circular outline.
- Keep the circle geometrically round.
- Center the number optically, not only mathematically.
- Use a bold sans-serif number with high legibility.
- Do not use pins, teardrops, badges, shields, squares, or outlined-only markers.

Do not show extra orange markers that are not represented by an official `ApplicationPoint`.

If the asset is an SVG used by the app, every visible point marker must have exactly one stable internal ID that maps to `ApplicationPoint.highlightAreaId` or to a single highlightable zone. One ID must not wrap multiple unrelated visible markers.

## Numbering

Use `Local N` ordering from the medication catalog and visual contract.

For Copaxone abdomen:

| Number | Point ID | Visual position | Label |
|---:|---|---|---|
| 1 | `abdomen_right_upper` | User's right upper abdomen | Abdômen superior direito |
| 2 | `abdomen_right_lower` | User's right lower abdomen | Abdômen inferior direito |
| 3 | `abdomen_left_upper` | User's left upper abdomen | Abdômen superior esquerdo |
| 4 | `abdomen_left_lower` | User's left lower abdomen | Abdômen inferior esquerdo |

Important orientation rule:

- Labels use the user's anatomical side, not the viewer's screen side.
- In a front-facing abdomen illustration, the user's right side appears on the viewer's left side.

## Callouts

Text callouts are allowed only as minimal, secondary support. The anatomy and markers must remain the dominant content.

Production in-app SVG assets should usually omit callout text and let Flutter render labels. Standalone review/reference images may include side callouts when needed for approval, but those callouts must not turn the image into an educational poster.

When callouts are used:

- Use a small numbered orange circle near the text.
- Use a dotted orange leader line from the text to the matching zone or marker.
- Keep leader lines thin and horizontal where possible.
- Use bold navy `LOCAL N` heading.
- Use dark neutral body text below the heading.
- Keep Portuguese labels concise.
- Keep callouts outside the anatomy whenever possible.
- Do not include medication names, treatment instructions, schedule guidance, or safety notes.

Example callout structure:

```text
[orange numbered circle] LOCAL 1
                         Abdômen
                         superior direito
```

Do not allow leader lines to cross through important anatomy or other zones.

## Typography

Use typography sparingly. App-owned SVG assets should avoid embedded text unless there is a deliberate reason.

Allowed standalone review/reference hierarchy:

- Optional region title: large bold dark charcoal, centered above anatomy.
- Callout heading: bold uppercase, dark navy.
- Callout body: regular, dark charcoal.

Keep text large enough for mobile screenshots and previews. Avoid condensed fonts and low-contrast gray.

Label hierarchy should match the approved references:

- Region title is the largest text element when present.
- `Local N` heading is secondary and bold.
- Body-region description is tertiary and regular weight.
- Marker numbers are larger than callout body text.
- Text should never compete with the anatomy for attention.
- In production app SVGs, prefer no embedded text and let Flutter own localization and scaling.

Do not include:

- Medication brand names.
- Medication logos.
- Treatment instructions.
- Safety note bands.
- Dosage or schedule guidance.
- Poster-style title/subtitle blocks.

## Reuse Across Medications

Assets should be reusable across medications whenever possible.

Use one shared asset when:

- The anatomical region is the same.
- The required SVG internal ID is the same.
- The asset is a broad region asset.
- The medication-specific rules do not require a different visual point map.

Create medication-specific assets only when:

- The medication has explicit detailed points.
- The target is a medication-specific anatomical subregion.
- The marker count or `highlightAreaId` set differs.
- A future spec requires a distinct protocol-specific visualization.

Do not add medication names or visual branding to force an otherwise reusable asset to become medication-specific.

## SVG Asset Rules

SVG files used by the Flutter app must be implementation-friendly.

Required:

- Stable `viewBox`.
- Stable internal IDs for every highlightable region or point.
- One highlight ID per anatomical region, subregion, or point marker.
- Separate highlightable shape/group from non-highlight anatomy.
- No raster images embedded in SVG.
- No external font dependencies.
- No external links.
- No medication brand names or medication logos.
- No treatment instructions or safety notes.

Preferred SVG structure:

```xml
<svg ... viewBox="0 0 W H" role="img" aria-label="...">
  <rect .../>
  <g id="anatomy">...</g>
  <g id="application_zones">...</g>
  <g id="application_markers">
    <g id="abdomen_right_upper">...</g>
  </g>
</svg>
```

If a highlight ID points to a marker, that group may contain multiple shapes only when all shapes form one single visible marker. It must not contain multiple separate markers.

If a highlight ID points to a zone, that element should represent one precise zone only.

## Raster Reference Rules

PNG reference images may include richer rendering than SVG app assets.

Use raster references for:

- Art approval.
- Visual exploration.
- AI image generation prompts.
- Designer handoff.

Do not use raster references as the only source of truth for app behavior. The visual contract remains the source of truth for point IDs, labels, expected assets, and highlight IDs.

Raster review references may include temporary approval annotations, but production application-site assets must remain clean visual aids without branding, safety-note bands, or treatment instructions.

## AI Image Generation Guidance

When generating future illustrations with an image model, use prompts that preserve the approved clinical style.

Recommended prompt template:

```text
Create a clean clinical medical illustration for a medication application site guide in Portuguese.
Centered semi-realistic [body region] filling most of the canvas on a white background, soft warm beige skin tones,
subtle gray-brown anatomical outlines, minimal internal detail, no needles, no wounds,
no photorealistic texture, no decorative background.
Show [number] translucent orange application zones with dashed orange outlines and subtle diagonal hatching.
Place one circular orange numbered marker inside each zone, white number text, white marker ring.
Use calm clinical app illustration styling, high readability, balanced whitespace, mobile-friendly composition.
No medication brand names, no logos, no treatment instructions, no safety note band, no poster layout.
```

Negative prompt guidance:

```text
No syringe, no injection action, no blood, no bruising, no diagnosis text, no dosage text,
no dark background, no cartoon mascot, no excessive realism, no copied pharmaceutical leaflet,
no extra unnumbered markers, no extra application zones, no brand names, no logo,
no instructional text, no safety note, no educational poster.
```

After generation, a designer or contributor must still align the result with the official application point IDs and SVG contract.

## Medication Branding

Application site illustrations must not contain medication brand names, medication logos, manufacturer marks, or product-title treatments.

Medication names belong in Flutter UI, not inside reusable illustration assets. This keeps assets reusable across medications and avoids turning application-site visuals into medication leaflets.

## Accessibility

Illustrations must remain understandable without relying only on color.

Required:

- Strong contrast between markers and anatomy.
- Numbered markers for detailed point maps.
- Distinct spatial separation between zones.
- SVG `aria-label` that describes the body region.
- Text labels rendered by Flutter wherever possible for accessibility, localization, and scaling.

Avoid using color alone to distinguish left/right or upper/lower points.

## Mobile Readability

Assets must be designed for small screens first.

Minimum readability expectations:

- At 320 px rendered width, every numbered marker must remain readable.
- At 320 px rendered width, each application zone must remain visually separate.
- Marker outlines must not collapse into the orange fill.
- Dashed zone outlines must remain visible but not noisy.
- Hatching must not create moire, dense stripes, or visual vibration.
- Callout text, when present in review/reference images, must remain secondary and should not be required to understand the in-app asset.
- Anatomy should remain identifiable when cropped by app layout constraints.
- There must be enough contrast between orange markers, orange zones, and skin tone.

For in-app SVGs:

- Avoid embedded paragraph text.
- Avoid small labels inside anatomy.
- Avoid thin strokes that disappear on high-density mobile screens.
- Keep all important visual elements inside the safe visual area of the viewBox.

## Consistency Checklist

Before accepting a new application site illustration, verify:

- The anatomy style matches the approved reference.
- Anatomy proportions match the approved abdomen/right thigh reference system.
- The palette uses warm neutrals plus EMControle orange.
- The body region is centered and occupies most of the canvas.
- Body contours are soft, warm gray-brown, and medium-weight.
- Every visible application marker corresponds to an official application point.
- No extra uncontracted markers are visible.
- Marker numbering matches `Local N` order.
- Marker style is orange circle, white number, white outline.
- Marker size and spacing remain readable at mobile scale.
- Zone dashed outlines, hatching, and leader lines use the approved line-weight hierarchy.
- Text callouts are minimal, secondary, and non-instructional.
- Label hierarchy matches the approved references when labels are present.
- Anatomical side labels follow the user's body side.
- SVG internal IDs match the visual contract.
- One highlight ID maps to one precise marker or one precise zone.
- The asset contains no external dependencies.
- The asset is reusable across medications unless the visual contract requires medication-specific points.
- The illustration does not include medication brand names, treatment instructions, safety notes, diagnosis, prescription, dosage, or clinical advice.

## Relationship to the Visual Contract

This art-direction document defines how application site illustrations should look and feel.

The authoritative implementation contract for IDs, medication points, image paths, and highlight areas is:

```text
docs/project/application-site-visual-contract.md
```

When there is a conflict:

1. Use `application-site-visual-contract.md` for technical IDs and point mappings.
2. Use this document for visual style and illustration quality.
3. Create a dedicated spec before changing clinical point sets, rotation order, medication rules, or application behavior.
