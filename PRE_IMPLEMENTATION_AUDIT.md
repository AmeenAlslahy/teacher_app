# Pre-Implementation Audit Report

## 1. Existing & Working Features
- **Core Architecture:** The app follows a feature-based architecture with `core`, `features`, and `app` folders. State management uses `provider` and routing uses `go_router`.
- **Database (Drift):** The schema exists and works for core entities like `Exams`, `Questions`, `QuestionBlocks`, `QuestionOptions`, `Students`, `Schools`, `Classes`, `Sections`, `Subjects`.
- **Math Rendering (In-App):** `flutter_math_fork` is used, and a clever `OffscreenRenderer` is already built to convert math blocks to PNG images for the PDF package.
- **Exam PDF Service:** There is an `ExamPdfService` in `features/exams/domain/services/exam_pdf_service.dart` that has a good foundation for PDF generation with Arabic fonts (Cairo) and RTL support.

## 2. Partially Existing Features
- **Exam Preview:** `ExamPreviewPage` exists but uses a mock `PdfService` from `core/services` that outputs "Exam PDF Example".
- **Backup/Restore:** Basic `exportData` and `importData` exist in `AppDatabase` but only cover `schools`, `classes`, `sections`, and `students`.

## 3. Missing Features
- **Settings:** No database table or UI for actual settings.
- **Grades & Attendance:** Tables are commented out in `app_database.dart`. UI pages are just placeholders.
- **XLSX/DOCX Export:** Not implemented.
- **Direct Printing:** The print button shows a snackbar.

## 4. Placeholders & Mocks
- **Routing:** `GradesPage`, `AssignmentsPage`, `AttendancePage`, `ReportsPage`, `SchoolsPage`, `ClassesPage`, `SubjectsPage`, `SettingsPage`, `BackupPage` are just empty `Scaffold` placeholders in `app_router.dart`.
- **Providers:** `DashboardProvider` uses mock data. `StudentProvider` returns dummy data for exports.
- **Print:** "سيتم توفير ميزة الطباعة قريباً" snackbar in `ExamPreviewPage`.
- **PDF Export:** `PdfService` in `core` generates a dummy PDF.

## 5. Technical Risks
- **Memory/Performance:** Rendering many large Math/Physics equations using `OffscreenRenderer` might cause memory spikes if not disposed or batched properly.
- **Drift Migration:** We need to uncomment tables in `app_database.dart` which requires bumping the schema version and writing a migration strategy.
- **Pagination in PDF:** `pdf` package handles pagination, but keeping question text and its options together (avoiding orphans) requires careful use of `pw.Wrap` or `pw.Column(crossAxisAlignment...)`.

## 6. What will be modified
- `app_database.dart` (Uncommenting tables, handling migrations).
- `app_router.dart` (Replacing placeholders with actual pages).
- `ExamPreviewPage` (Connecting to real `ExamPdfService`, implementing print).
- `ExamPdfService` (Refining header, supporting all blocks, settings integration).
- Providers for Dashboard, Students, Grades, Attendance.

## 7. What will be kept
- The `Drift` database approach.
- `OffscreenRenderer` logic (it's a great offline approach for math to PDF).
- Overall UI/UX structure using `go_router` and `provider`.
