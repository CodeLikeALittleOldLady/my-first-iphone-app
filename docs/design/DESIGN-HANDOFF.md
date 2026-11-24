# ApplePhotoCleanup — design handoff

Revision 2 — 2026-11-24. Supersedes the first handoff. Prepared for Alison and Lovelace. Design only; no application code or repository issues were changed.

## How to use this package

Copy `docs/design` into the application repository. Read this document before updating the README and backlog. Reconcile with existing issues rather than duplicating them. The supplied README references grouping issue #43; extend or link that issue where appropriate. Existing issues have not been inspected in this chat.

Written decisions below take precedence over illustrative text, counts, icons, and layout accidents in generated mockups. These are concept images, not production specifications. Earlier mockups with permanent calendars, separate Cleanup Queue tabs, or flagged-date navigation are superseded and intentionally omitted.

## Product and visual direction

A little each day, with optional cleanup whenever the user chooses. Year end is a suggested rhythm, not a deadline. Users may keep flagging for years without deleting. Simple, clean, photo-first iPhone experience, white surfaces and restrained purple accents. No streaks or guilt about unfinished days. Flagging is reversible and never deletes a photo. No application account, server, or analytics. Similarity processing stays on device. Preserve the learning-project scope; no additional feature expansion is implied.

## Main screen and navigation — agreed

- One main screen, with Review / Cleanup Queue segmented control at the top. Preserve the selected date when switching modes.
- Compact date row: previous day, month/day heading with dropdown affordance, next day, Today shortcut. No bottom tabs.
- Photos use the remaining area, in a grid grouped by original photo year. Open an individual photo or group for focused review and easy swiping.
- Tapping the date opens a temporary dismissible calendar sheet. Selecting a day closes the sheet and opens that date. Month arrows navigate months; no year or weekday labels in this cross-year picker.
- A date always means the photo's capture month and day. November 15 shows November 15 photos across all years in Review, and only flagged November 15 photos across all years in Cleanup Queue. Do not add a calendar based on when flags were created.
- Every month/day is accessible, including future calendar dates and a permanent February 29. February 29 is Today only in leap years; do not fold its photos into February 28.
- On first use, open Today; all dates begin incomplete except confirmed dates with no photos, which complete automatically. There is no opt-in earlier-days backlog setting.
- Calendar Review markers: reviewed, in progress, waiting; distinguish empty dates. Queue mode displays remaining queued-photo counts for each capture month/day.

## Daily review and completion — agreed

- Review in any order. Individual flagging writes to the Cleanup Queue album; original stays in Photos. Use one reversible flag/unflag action; no separate Undo for an individual photo.
- Finish review is explicit. It does not require opening every photo or flagging anything.
- Leaving midway preserves place and keeps the date unfinished. Reopening a completed date allows changes.
- Completion wording MUST follow selected date: 'Done for today' only for today's date; otherwise 'Day reviewed'. Show the selected month/day beneath. Apply this to accessibility announcements as well as visible copy.
- No photos: say 'No photos for [month day]' and mark reviewed only after a successful complete query. Permission-limited or failed loading must not be reported as a truly empty full library.

## Bursts and similar-shot groups — agreed

- Identify actual camera bursts and likely near-identical photos taken close together. Detection approach and thresholds remain investigation work.
- One stacked tile per group: e.g. 'Burst · 30' for actual burst or '30 similar' for inferred grouping.
- Focused viewer: large swipeable photo, scrolling filmstrip following selection, position counter and reversible individual flag actions. Reserve Undo for bulk actions, including flagging the rest of a group.
- Provide explicit keeper selection within the group, then 'Flag the other N'. Keeper choices alone do not flag anything. Never automatically flag or delete because of group membership.
- Keep-selection is a review control, not an instruction to alter Apple Photos Favorites.
- Preserve place on leaving and returning.
- Queue mode keeps flagged members grouped as e.g. '27 flagged'; open to swipe and remove flags. Support selecting multiple queued items to remove their flags.
- Side-by-side comparison is not required by the agreed design; easy swiping is sufficient.

## First launch and reminders — agreed

1. Brief introduction: photos across the years, reversible flags, backup before deletion.
2. Explain photo access; a SINGLE 'Continue' button opens Apple's permission dialog. Do not render the extra 'Opens Apple’s permission prompt' line or a second permission action.
3. Apple photo-access system prompt, then appropriate access result handling.
4. Optional daily reminder with time choice, Enable reminder and clear Not now.
5. Enable reminder invokes Apple's notification prompt. Not now skips it. Declining notifications still permits app use.
6. Open today's review.

Reminder behavior: one reminder at chosen time, skip today if finished, no repeated nudges, notification opens today's review. Easy change/disable through Settings. System-prompt panels in the board are annotations, not app screens or exact OS dialog designs. Use archive/file icon for backup, not a cloud-only implication.

## Cleanup Queue — agreed

Use the same compact navigation and capture-date calendar as Review. A selected-day empty state says 'Nothing queued for this date', not that the entire queue is empty. Opening a queued photo offers Remove from queue, which cancels the flag; the original never needed restoration. Allow bulk unflagging and undo. Grouping prevents large bursts overwhelming the grid.

## Cleanup anytime and backup policy — agreed

A dedicated guided flow operates across the entire queue or selected dates, independent of the currently selected day. Enter through Settings → Clean up flagged photos, or Resume cleanup when work is unfinished. No December 31 date lock.

1. Summary: queue photo count, scope choice (entire queue or selected dates), estimated export size and chosen destination.
2. Export in smaller independently resumable batches. Save completed work; allow returning later. Exact batch sizes are NOT decided.
3. For each batch, prepare originals (including fetching unavailable originals), save the zip to chosen destination, verify the saved export.
4. With Require ZIP backup before deletion ON (the default), only a successfully saved and verified batch is eligible for deletion. Show its count, filename and destination, plus access to the saved copy.
5. Offer an explicit Delete these N photos choice or Keep photos and continue. Successful export never triggers deletion automatically. Deletion requires Apple's system confirmation.
6. Track results per batch, including interrupted, not started, saved/kept, and confirmed deletion. Do not mark deletion successful until the result is confirmed.
7. On the backup-required path, failed or incomplete exports cannot proceed to deletion. Newly added photos remain outside the current fixed batch. A batch uses a fixed membership snapshot; subsequent flags wait for another export.

Destination options discussed: chosen Files location or attached external drive; one zip may suit small queues, but smaller batches are the agreed baseline. Size/space estimates and interruption handling must be validated before final claims. Saving to a cloud-backed Files folder does not by itself establish that remote upload has completed. Define what saved-and-verified means for each supported destination before enabling deletion on the protected path. Include insufficient storage, unavailable destination, inaccessible originals, verification failure, cancellation, and partial deletion outcomes in acceptance criteria.

## Settings and backup override — agreed in revision 2

- Settings opens from the main-screen gear; back returns to photos.
- Daily reminder toggle and time. Preserve chosen time when disabled. If OS notification permission is blocked, show that status and Open iPhone Settings; never imply notifications are active.
- Photo access section shows current status and appropriate management/recovery action.
- Cleanup entry is visible year-round: Clean up flagged photos, or Resume cleanup for unfinished batches.
- About & privacy explains local processing, synced state and user-chosen export destinations.
- Separate Danger Zone: Require ZIP backup before deletion, ON by default. Helper: Save and verify a copy before deleting flagged photos.
- Turning protection OFF requires confirmation: Allow deletion without a backup? / Flagged photos can be deleted without saving a copy first. Actions: Keep backup required / Allow without backup.
- With protection OFF, cleanup offers Back up and delete OR Delete without backup. The no-backup route warns with the exact selected-photo count before Apple's system confirmation. Changing the setting alone never deletes anything.
- Backup remains optional on this deliberately enabled route. Do not retain absolute mandatory-backup claims in README, onboarding, issues, or cleanup copy. Existing onboarding backup wording describes the default and should be reconciled accordingly.
- Existing batch board illustrates the protected path only. A no-backup cleanup confirmation screen has not yet been drawn; do not pretend the protected-path image covers both branches.

## Individual viewer — agreed in revision 2

- Large photo, capture date including year, position counter, current mode label, and back to selected-day grid.
- Swipe to navigate, pinch or double-tap to zoom, drag to pan while zoomed. Filmstrip follows current selection. Maintain stable control positions between flag states.
- Exactly one reversible action: Flag for cleanup → Remove from queue. After removal, Flag again is available. No separate individual Undo bar.
- Flagging/unflagging NEVER changes mode, date, or automatically advances the photo.
- Screen 2 in the viewer board intentionally remains in Review: a photo can be flagged while still browsing all photos.
- In Cleanup Queue, an unflagged photo remains visible with Removed from queue until the user navigates away. It can immediately be flagged again. Then omit it from the live queued collection. Session counter behavior during this temporary retention needs implementation detail; do not treat the displayed denominator as a live queue total.

## Bulk selection — agreed in revision 2

- Select enters grid selection; Cancel exits without changes. Count selected individual photos, not tiles.
- Selecting a group tile includes all its represented photos; three grouped plus two individual photos equals five selected. To inspect individual group members, open the group outside selection mode.
- Review action: Flag N photos. Queue action: Remove N from queue. Exit selection after applying and remain on same date/in same mode.
- Show result count and Undo for the bulk operation. Undo reverses only the changes made by that operation.
- Queue grid updates after removal; unlike the individual viewer, removed tiles need not stay visible. The corrected board shows seven queued photos minus five removed, leaving two.

## Photo access recovery — agreed in revision 2

- Limited access: available photos plus You're viewing selected photos and Manage access. Counts describe accessible photos, not the full library.
- Denied access: explanatory screen and Open iPhone Settings, not an empty-library message.
- Refresh after changes; preserve saved review progress and existing flags. Inaccessible items are not evidence of deletion.
- Never automatically mark a day reviewed because incomplete/limited/failed results are empty.
- Access-board footer about not marking a day is behavior guidance; simplify production helper copy if needed. Permission-management capability must still be validated.

## Annual reset and indefinite queue retention — agreed in revision 2

- January 1 starts a fresh review-completion cycle. Confirmed dates without photos remain automatically complete.
- Queued photos stay flagged indefinitely until explicitly unflagged or deleted. No cleanup deadline and no forced deletion.
- Existing backups and unfinished cleanup/export work remain available; reminder preferences persist.
- Open Today; a quiet A new year of photos to revisit note is appropriate. Do not confuse review reset with clearing the queue or batch state.
- Reviewing and deleting are independent choices; indefinitely marking without running cleanup is valid usage.

## Shared control consistency — agreed in revision 2

Use the earlier compact main-screen Review / Cleanup Queue segmented control as the canonical component: two equal-width segments, rounded light-gray container, purple selected fill, consistent height, typography, spacing and position. Later generated screens drift in styling; these are NOT approved alternative controls. Apply consistently to grid, bulk and calendar states. Focused viewer may show a mode label instead of the segmented control as illustrated.

## Everyday states

- Completion: date-aware text, selected-day flagged count, return to photos or choose another day; no confetti or pressure.
- Empty photo date: nothing to review, choose another date or Today.
- Empty selected-day queue: review this day or choose another day.
- Unavailable original: clear retry/next options, preserve progress, no endless spinner. The mockup's connection message is illustrative; do not claim a network cause without evidence.

## Open design and feasibility work — not settled

- Bulk Undo lifetime and behavior after navigation, partial-success handling, and mixed already-flagged selections need detail. Do not undo pre-existing flags. Specify selection behavior when switching date or mode.
- Validate queue/album capabilities under limited access and exact supported access-management route. Decide manual completion under limited access; the agreed rule prohibits automatic completion from incomplete results, but does not yet settle manual completion.
- Newly arriving photos on already-reviewed dates still need a rule. Annual rollover behavior itself is settled below.
- Precise export verification, temporary storage requirements, resumability and background/foreground constraints; supported original resources (e.g. Live Photos and burst members) and metadata preservation. These require engineering investigation, not claims inferred from concept art.
- Accessibility: dynamic text, contrast, touch targets, non-color status cues, VoiceOver labels/order and reduced motion need specification and review.

## README/backlog reconciliation

| Existing wording | Replace or clarify with |
|---|---|
| Catch-up list | On-demand month/day calendar sheet over the photo grid |
| February 28 includes leap-day photos | February 29 is permanently selectable as its own date |
| Side-by-side group review | Focused swipe viewer plus filmstrip and explicit keeper selection |
| One zip and clear in one step | Resumable independent batches; verified export then explicit batch deletion |
| Delete once | Optional cleanup anytime, with explicit batch confirmations |
| Backup is mandatory | Required by default; explicit Danger Zone override allows the warned no-backup path |
| Only album and review log as state | Account for saved position, group selections and export/batch progress; investigate storage/sync design |
| Photos never leave devices | Clarify user-directed export to chosen storage without introducing app-server collection |

Do not rewrite implementation architecture solely from a screenshot. Reconcile persistence and privacy wording with the behavior actually supported.

## Suggested backlog work packages

- [ ] Shared Review/Queue screen and persistent selected capture date.
- [ ] On-demand yearless calendar, permanent leap day, initial-state rules and date markers/counts.
- [ ] Focused viewer, stable layout, zoom/pan, reversible flag button and date-aware completion; no individual Undo bar.
- [ ] Extend existing grouping issue #43: stacked tiles, swiping, keeper selection, bulk flag-rest and queued groups.
- [ ] Queue single/bulk unflagging and selected-day empty state.
- [ ] Onboarding and photo-permission result/recovery flows.
- [ ] Optional reminder setup, permission branch, scheduling and settings controls.
- [ ] Export feasibility investigation and destination verification contract before destructive implementation.
- [ ] Cleanup scope/destination, fixed batch manifests, export/check pipeline and resumable status.
- [ ] Protected verified-batch deletion and explicitly enabled no-backup branch; warning, system confirmation and accurate outcomes.
- [ ] Everyday/loading/failure states and accessibility review.
- [ ] Implement agreed Settings and annual rollover; resolve newly added photos and remaining feasibility questions.

Use existing labels and episode structure. Add acceptance criteria from these decisions; retain unresolved questions as questions. No application code is requested by this handoff.

## Current screen inventory

### 01-review-and-queue.png

Compact main screen; supersedes permanent calendar and three-tab proposals.

![01-review-and-queue.png](screens/01-review-and-queue.png)

### 02-burst-review.png

Burst/keeper/flagged-group flow. Sample totals are inconsistent; do not implement the numbers.

![02-burst-review.png](screens/02-burst-review.png)

### 03-calendar-sheet.png

Temporary month/day picker. Same picker in Queue mode uses queued counts.

![03-calendar-sheet.png](screens/03-calendar-sheet.png)

### 04-year-end-batches.png

Batch cleanup flow. Destination helper should be neutral, not red; batch sizes are examples.

![04-year-end-batches.png](screens/04-year-end-batches.png)

### 05-onboarding.png

Final onboarding: Continue opens photo permission. System screens are explanatory placeholders, not UI to build.

![05-onboarding.png](screens/05-onboarding.png)

### 06-everyday-states.png

Completion, empty date, empty selected-day queue, unavailable original. Apply the date-aware completion wording in this document.

![06-everyday-states.png](screens/06-everyday-states.png)

### 07-settings.png

Settings and confirmation before disabling default ZIP protection.

![07-settings.png](screens/07-settings.png)

### 08-individual-viewer.png

Final viewer: one reversible button, no individual Undo bar. Middle screen intentionally remains in Review.

![08-individual-viewer.png](screens/08-individual-viewer.png)

### 09-bulk-selection.png

Corrected bulk selection/counts and Undo; use canonical segmented control rather than generated styling drift.

![09-bulk-selection.png](screens/09-bulk-selection.png)

### 10-photo-access.png

Limited/denied access and refresh; permission-management capability requires engineering validation.

![10-photo-access.png](screens/10-photo-access.png)


## Design review supplement

See [USABILITY-ACCESSIBILITY-REVIEW.md](USABILITY-ACCESSIBILITY-REVIEW.md). It supplements this handoff with findings and recommendations; it does not override agreed behavior without an explicit subsequent decision.
