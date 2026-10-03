# Exam Builder UX Changeset

## Modified / added files

- `exams/presentation/pages/exam_editor_page.dart`
  - Removes the Stepper flow.
  - New exams start with setup, then move to the canvas.
  - Existing exams open directly on the canvas.
  - Auto-save remains available.
  - Review is a lightweight modal instead of a mandatory step.

- `exams/presentation/pages/exam_setup_page.dart`
  - New setup experience focused on only essential exam information.

- `exams/presentation/pages/exam_canvas_page.dart`
  - User-centric Question Canvas.
  - Add question / add section.
  - Group-aware drag & drop so a section moves with its children.
  - Edit / duplicate / delete actions.
  - Direct question counts and total marks.

- `exams/presentation/pages/question_editor_page.dart`
  - Compatibility wrapper for existing routes.
  - Uses the new shared question editor.

- `exams/presentation/widgets/question_type_dialog.dart`
  - Phase 1 exposes only fully supported editors:
    MCQ, True/False, Short Answer, Essay.

- `exams/presentation/widgets/question_editor_sheet.dart`
  - New sheet-based specialized editor.
  - MCQ supports adding/removing options and direct correct-answer selection.
  - True/False uses a simple segmented choice.
  - Short Answer supports an accepted answer.
  - Essay keeps the creation path intentionally minimal.
  - Save & Add New keeps type, option count, marks and difficulty.

- `exams/presentation/widgets/question_card.dart`
  - Reduced visual noise.
  - Drag handle, question type, marks, content, answers and overflow actions.

- `exams/presentation/widgets/exam_review_sheet.dart`
  - Lightweight validation/review surface.

- `exams/providers/exam_provider.dart`
  - Add section abstraction.
  - Group-aware insertion.
  - Duplicate returns the created copy for immediate editing.
  - Persistent deletion through DeleteQuestionUseCase.
  - Reordering by canvas units while preserving section/child relationships.

- `exams/providers/question_editor_provider.dart`
  - Add/remove MCQ options.
  - Preserve real option count when editing.
  - Preserve ordering when editing/creating.
  - Fix inline block removal so placeholders are removed too.
  - Reset for rapid creation without resetting marks/type/options/difficulty.

- `exams/data/repositories/exam_repository_impl.dart`
  - Synchronizes question child collections on edit by replacing options/blocks atomically.

- `exams/domain/usecases/delete_question_use_case.dart`
  - New use case for persisted question deletion.

- `EXAM_BUILDER_DI_REQUIRED.txt`
  - Required GetIt registration for DeleteQuestionUseCase.

## Important

The archive provided for this task did not contain `flutter_quill` or the Prototype implementation, so no `flutter_quill` dependency was introduced. The current rich-text controller and existing math/chemistry insertion remain intact.

The supplied archive also does not include the project's GetIt/injection file, so one DI registration is documented separately instead of being guessed.

## Verification performed here

- Modified Dart files passed structural brace/parenthesis checks.
- Question type picker contains no Phase-2-only types.
- No Flutter SDK was available in the execution environment, so `flutter analyze` / widget tests could not be run here.
