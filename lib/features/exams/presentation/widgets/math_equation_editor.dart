// lib/features/exams/presentation/widgets/math_equation_editor.dart
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/math_formulas_library.dart';
import '../../domain/entities/question_content.dart';

class MathEquationEditor extends StatefulWidget {
  final String? initialLatex;
  final Function(String latex) onSave;
  
  const MathEquationEditor({
    super.key,
    this.initialLatex,
    required this.onSave,
  });

  @override
  State<MathEquationEditor> createState() => _MathEquationEditorState();
}

class _MathEquationEditorState extends State<MathEquationEditor> {
  late TextEditingController _latexController;
  String _previewLatex = '';
  MathCategory _selectedCategory = MathCategory.algebra;
  
  @override
  void initState() {
    super.initState();
    _latexController = TextEditingController(text: widget.initialLatex ?? '');
    _previewLatex = widget.initialLatex ?? '';
  }
  
  @override
  void dispose() {
    _latexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
            Row(
              children: [
                Text(
                  'محرر المعادلات الرياضية',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // شريط الأدوات
            _buildToolbar(),
            const SizedBox(height: AppSpacing.md),
            
            // إدخال LaTeX
            AppTextField(
              label: 'صيغة LaTeX',
              controller: _latexController,
              hint: r'مثال: \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}',
              onChanged: (value) {
                setState(() {
                  _previewLatex = value;
                });
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // المعاينة المباشرة
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المعاينة:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    height: 120,
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: _previewLatex.isNotEmpty
                              ? Math.tex(
                                  _previewLatex,
                                  textStyle: const TextStyle(fontSize: 24),
                                  mathStyle: MathStyle.display,
                                )
                              : const Center(
                                  child: Text(
                                    'اكتب صيغة LaTeX للمعاينة',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                        ),
                      ),
                  ),
                ],
              ),
            const SizedBox(height: AppSpacing.lg),
            
            // الصيغ الجاهزة
            _buildFormulaLibrary(),
            const SizedBox(height: AppSpacing.lg),
            
            // أزرار الحفظ
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'إلغاء',
                    type: AppButtonType.danger,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    text: 'إدراج المعادلة',
                    type: AppButtonType.success,
                    icon: Icons.check,
                    onPressed: () {
                      widget.onSave(_latexController.text);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
  
  Widget _buildToolbar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildToolbarButton(r'\frac{}{}', 'كسر', Icons.vertical_align_center),
          _buildToolbarButton(r'\sqrt{}', 'جذر', Icons.square_foot),
          _buildToolbarButton(r'^{}', 'أس', Icons.superscript),
          _buildToolbarButton(r'_{}', 'دليل', Icons.subscript),
          _buildToolbarButton(r'\int', 'تكامل', Icons.gesture),
          _buildToolbarButton(r'\sum', 'مجموع', Icons.functions),
          _buildToolbarButton(r'\pi', 'π', Icons.circle),
          _buildToolbarButton(r'\theta', 'θ', Icons.text_fields),
          _buildToolbarButton(r'\alpha', 'α', Icons.text_fields),
          _buildToolbarButton(r'\beta', 'β', Icons.text_fields),
          _buildToolbarButton(r'\rightarrow', 'سهم', Icons.arrow_forward),
          _buildToolbarButton(r'\pm', '±', Icons.add),
          _buildToolbarButton(r'\times', '×', Icons.close),
          _buildToolbarButton(r'\div', '÷', Icons.horizontal_rule),
          _buildToolbarButton(r'\leq', '≤', Icons.keyboard_arrow_left),
          _buildToolbarButton(r'\geq', '≥', Icons.keyboard_arrow_right),
        ],
      ),
    );
  }
  
  Widget _buildToolbarButton(String latex, String tooltip, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: () {
            final currentText = _latexController.text;
            final selection = _latexController.selection;
            
            if (selection.isValid && selection.start != selection.end) {
              final start = selection.start;
              final end = selection.end;
              final selectedText = currentText.substring(start, end);
              final newText = currentText.replaceRange(
                start,
                end,
                _wrapLatex(latex, selectedText),
              );
              _latexController.text = newText;
            } else {
              final cursorPos = selection.isValid ? selection.baseOffset : 0;
              final newText = currentText.substring(0, cursorPos) +
                  latex +
                  currentText.substring(cursorPos);
              _latexController.text = newText;
              _latexController.selection = TextSelection.collapsed(
                offset: cursorPos + latex.length,
              );
            }
            
            setState(() {
              _previewLatex = _latexController.text;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20),
          ),
        ),
      ),
    );
  }
  
  String _wrapLatex(String latex, String content) {
    if (latex == r'\frac{}{}') {
      return r'\frac{' '$content' r'}{}';
    }
    if (latex == r'\sqrt{}') {
      return r'\sqrt{' '$content' r'}';
    }
    if (latex == r'^{}') {
      return '^{$content}';
    }
    if (latex == r'_{}') {
      return '_{$content}';
    }
    return '$latex$content';
  }
  
  Widget _buildFormulaLibrary() {
    final formulas = _selectedCategory == MathCategory.general
        ? MathFormulasLibrary.getAllFormulas()
        : MathFormulasLibrary.getAllFormulas()
            .where((f) => f.category == _selectedCategory)
            .toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الصيغ الجاهزة:',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: MathCategory.values.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(category.label),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: formulas.length,
            itemBuilder: (context, index) {
              final formula = formulas[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () {
                    _latexController.text = formula.latex;
                    setState(() {
                      _previewLatex = formula.latex;
                    });
                  },
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Math.tex(
                                formula.latex,
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formula.displayText,
                          style: const TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
