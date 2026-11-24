# Usability, accessibility and App Review assessment

2026-11-24 — design-stage review. Companion to DESIGN-HANDOFF.md, revision 2. This document adds review findings; it does not silently approve recommendations or alter agreed product behavior. No application code was reviewed. Mockups cannot establish actual contrast, touch dimensions, assistive-technology support or App Review acceptance.

## Overall assessment

Keep the simple photo-first direction, predictable navigation, reversible flags and separation between reviewing and deleting. Close gaps around destructive-action clarity, accessible layouts and state transitions before treating the design as complete.

## Highest-priority usability findings

| Priority | Finding | Recommendation / next decision |
|---|---|---|
| High | Queue removal and library deletion have different consequences | Consistently say Remove from queue versus Delete from Photos; avoid ambiguous Remove for destructive operations. |
| High | iCloud Photos deletion propagates beyond this app | Explain synced-device effects before deletion and distinguish Recently Deleted recovery from permanent erasure. Validate wording for supported shared-library cases. |
| High | Persistent backup override may be forgotten | Retain agreed default-on protection and confirmation. Recommend a prominent Backup protection is off status for every cleanup session; the agreed no-backup warning and system confirmation still apply. |
| High | Keep-selection can imply automatic destruction of the rest | Explain explicit keeper selection followed by Flag the other N. Leaving without applying must make no changes. |
| Medium | Partial selection of group members undefined | Specify unselected, partly selected and fully selected group states. Count individual photos, accounting for already-flagged members. |
| Medium | Date/mode controls remain visible during selection | Decide whether to preserve or discard selection on navigation. Recommendation: selection scoped to one day, with an explicit decision before discarding. Not yet approved. |
| Medium | Calendar navigation can require searching many empty queue dates | Recommend total queue count and optional Next day with queued photos. Preserve calendar/date semantics; these additions are not yet approved. |
| Medium | New photos can arrive after a day is finished | Decide on a New photos since your review indicator rather than silently resetting completion. Not yet approved. |
| Medium | Yearless calendar may look unfamiliar | Test whether people understand it is a recurring month/day picker, not a calendar for a specific year. Keep agreed permanent February 29. |

## Accessibility design work

- Large text: produce layouts at the largest accessibility sizes. Long mode labels, gear, date controls, Settings rows and calendar may need rearrangement and scrolling. Do not shrink text to preserve a screenshot layout.
- Touch targets: use 44 by 44 points as the design target for dates, chevrons, gear, filmstrip items and other actions. Seven 44-point columns require 308 points before spacing; check supported compact widths. This is our design target, not a claim that every smaller target automatically causes rejection.
- Gestures: provide accessible Previous/Next actions and zoom controls. VoiceOver, Voice Control and Switch Control users must not depend solely on swipe/pinch gestures.
- Labels: specify meaningful photo date, position, flag state, group size and selection state. Examples: November 15, in progress, 38 photos; Similar-photo group, 30 photos, partly selected; Photo 7 of 24, November 24, 2025, flagged for cleanup.
- Focus: after a flag change, announce status without moving focus or navigating. Calendar presentation/dismissal needs predictable focus restoration. Bulk-result messages must be announced without stealing focus unnecessarily.
- Contrast: measure implemented colors. Target at least 4.5:1 for normal text. Pale helper text, lavender badges and dimmed thumbnails are potential weak spots. Status/selection must have cues beyond color.
- Bulk Undo: determine an accessible duration or persistent recovery mechanism. A fleeting toast alone may be insufficient. Scope Undo to changes actually made by that operation.
- Test Bold Text, Increase Contrast, Differentiate Without Color, Reduce Motion and relevant appearance settings. Define dark-appearance behavior rather than assuming the light mockups establish it.
- Test screen-reader reading order for headers, grouped photos, mode control, calendar dates, warning dialogs, export progress and completion results.

## Apple submission considerations

These are possible review risks grounded in published guidance, not a prediction of rejection and not a completed compliance audit.

| Area | Required preparation / concern |
|---|---|
| Privacy policy | Provide an easily accessible in-app policy link and App Store metadata policy URL, even without analytics or an app account. Explain actual processing, synced state, exports and retention. |
| Permission purpose strings | Explain why photo access is needed and how it is used, including library management/user-requested deletion where applicable. Custom explanatory screens do not replace system purpose strings. |
| Respect for permission choices | Preserve honest limited-access behavior and optional notifications; avoid coercion or repeated permission pressure. Validate underlying capabilities. |
| Accurate claims | Do not promise ZIP backup on the deliberately enabled no-backup route. Do not equate a cloud-folder write with confirmed remote upload. Explain originals/resources supported by the export accurately. |
| Completeness | Export, verification, resume, cancellation, permissions and partial deletion must work. App Store screenshots must reflect the shipped app, not these generated concept boards. |
| Reviewability | Explain non-obvious cleanup and calendar behavior in review notes, and provide a practical way to exercise it without dependence on a particular date or external drive. |

The single Continue button on the photo pre-alert aligns with Apple's neutral pre-alert guidance. System-placeholder panels in onboarding are documentation only and must not ship as imitation permission dialogs.

No requirement for a mandatory ZIP before user-requested photo deletion was identified in the cited rules. The backup override remains a product-safety choice requiring clear behavior; this is not an assurance of App Review approval.

## Next-session agenda

1. No-backup warning and cleanup result/partial-failure screens.
2. End-to-end walkthrough: setup, review, group flags, completion, queue revisit, optional cleanup; include cancel, resume and access changes.
3. Main screen and calendar at large accessibility text sizes.
4. Decisions on partial group selection, bulk Undo lifetime, changing date/mode during selection and new photos after completion.
5. Convert agreed outcomes into acceptance criteria; retain recommendations as open proposals until Alison decides.

## Sources checked on 2026-11-24

- [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) — privacy, permission choices, completeness, metadata and review preparation.
- [App Review guidance](https://developer.apple.com/app-store/review/) — clear data-access requests and accurate screenshots.
- [Privacy — Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/privacy) — contextual permission requests and neutral pre-alert design.
- [Accessibility — Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/accessibility) — inclusive interaction and accessible presentation.
- [Typography — Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/typography) — larger text and readability.
- [UI Design Dos and Don'ts](https://developer.apple.com/design/tips/) — touch targets, contrast and layout.
- [Sufficient Contrast evaluation criteria](https://developer.apple.com/help/app-store-connect/manage-app-accessibility/sufficient-contrast-evaluation-criteria/) — contrast evaluation; accessibility claims must be supported by testing.
- [Delete and recover photos and videos on iCloud.com](https://support.apple.com/guide/icloud/delete-and-recover-photos-and-videos-mm08b49040b5/icloud) — synced deletion and recovery.

Recheck relevant Apple requirements before submission; guidance can change.
