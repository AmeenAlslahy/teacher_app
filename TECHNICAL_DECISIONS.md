# Technical Decisions

## PDF and Math Equations Strategy

**Decision:** Option B (Flutter `pdf` package + Math to PNG conversion via `OffscreenRenderer`).

**Rationale:**
- The codebase already contains an `OffscreenRenderer` that uses Flutter's native `PlatformDispatcher` to render `flutter_math_fork` widgets into `Uint8List` (PNG images) in the background.
- This is a 100% offline solution, requiring no WebView, no external KaTeX assets, and no internet.
- It perfectly integrates with the `pdf` package which handles Arabic (Cairo font) and RTL flawlessly.
- This avoids the overhead of managing HTML templates and ensures the output is highly deterministic.

## DOCX Strategy

**Decision:** Use a package like `docx_template` or build a simple XML generator, injecting the same PNGs used for PDF.
**Rationale:** Generating DOCX offline in Flutter can be tricky. Using the pre-rendered math PNGs avoids the need to write complex OMML (Office Math ML). We will maintain the LaTeX strings in the database.

## Architecture: Exam Document Engine

**Decision:** We will decouple the `Exam` domain model from the rendering layer.
- `ExamPdfService` acts as the unified renderer for PDFs.
- `ExamPreviewPage` will display the actual generated PDF using a package like `printing` or `pdfx` to ensure the preview is 100% identical to the printed output.

## Database Migration

**Decision:** Use Drift's built-in migration mechanisms.
- We will bump `schemaVersion` to 2.
- In the `onUpgrade` callback, we will create the newly uncommented tables (Settings, Grades, Attendance, etc.) without dropping the existing ones, preserving all user data.
