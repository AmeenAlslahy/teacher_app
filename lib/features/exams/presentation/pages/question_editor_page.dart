import 'package:flutter/material.dart';
import '../../domain/entities/exam.dart';
import '../widgets/question_editor_sheet.dart';

/// Route-compatible wrapper around the new question editor.
/// New creation from ExamCanvas uses QuestionEditorSheet directly so the
/// teacher stays on the canvas instead of navigating to a separate page.
class QuestionEditorPage extends StatelessWidget {
  final QuestionType type;
  final String? questionId;
  final String examId;
  final String? parentId;

  const QuestionEditorPage({
    super.key,
    required this.type,
    this.questionId,
    required this.examId,
    this.parentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QuestionEditorSheet(
        type: type,
        questionId: questionId,
        examId: examId,
        parentId: parentId,
      ),
    );
  }
}
