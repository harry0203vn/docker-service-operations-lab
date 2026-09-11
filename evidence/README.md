# Evidence

This folder contains a privacy-reviewed subset of the screenshots captured during the real test runs described in [`../docs/testing.md`](../docs/testing.md).

## Included

| File | Test case | What it shows |
|---|---|---|
| `screenshots/01-portal-running.png` | Test Case 1 (normal operation) | The portal loaded in a browser at `http://localhost:8090`, confirming the Nginx container serves the expected content. The browser's personal bookmarks bar was cropped out of this image; the portal content itself is shown unmodified and at its original resolution. |

## Not included (reviewed, but excluded on purpose)

Three additional terminal screenshots were captured during testing (covering Test Cases 1–3: normal operation, the stopped-service failure case, and report generation). Each one was individually reviewed for whether personal information could be safely removed by cropping alone.

In all three, every command line in the terminal begins with a shell prompt in the form `<username>@<hostname>:<personal file path>$`, repeated on essentially every line from the top of the screenshot to the bottom. Because the identifying information is embedded inline within the same lines as the actual command output — not confined to a separate header or footer region — it cannot be removed by cropping without also cutting away the technical evidence the screenshots exist to show.

Per this project's evidence policy, terminal text is never edited, retyped, or altered to remove personal information — only straightforward cropping is used, and only when it doesn't compromise the evidence. Since honest cropping wasn't possible for these three images, they were left out of this public repository rather than modified. They remain available in the original (non-public) project workspace for anyone who needs to review the full test evidence, including the personal environment details.

**It is better to publish fewer clean screenshots than manipulated evidence.**

## Screenshot count

- Captured during testing: 4
- Included in this public repository: 1
- Excluded (personal terminal identity could not be safely cropped out): 3
