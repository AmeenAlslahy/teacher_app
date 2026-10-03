// lib/features/exams/presentation/widgets/chemistry_editor.dart
import 'package:flutter/material.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/math_formulas_library.dart';

class ChemistryEditor extends StatefulWidget {
  final Function(String formula) onSave;
  
  const ChemistryEditor({super.key, required this.onSave});

  @override
  State<ChemistryEditor> createState() => _ChemistryEditorState();
}

class _ChemistryEditorState extends State<ChemistryEditor> {
  final _formulaController = TextEditingController();
  String _previewFormula = '';
  
  @override
  void initState() {
    super.initState();
    _formulaController.addListener(() {
      setState(() {
        _previewFormula = _formulaController.text;
      });
    });
  }
  
  @override
  void dispose() {
    _formulaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'محرر الصيغ الكيميائية',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // شريط أدوات الرموز الكيميائية
            _buildElementToolbar(),
            const SizedBox(height: AppSpacing.md),
            
            // إدخال الصيغة
            TextField(
              controller: _formulaController,
              decoration: InputDecoration(
                labelText: 'الصيغة الكيميائية',
                hintText: 'H2O, NaCl, H2SO4',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // المعاينة
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _previewFormula.isNotEmpty
                  ? Text(
                      _formatChemicalFormula(_previewFormula),
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    )
                  : const Center(
                      child: Text(
                        'اكتب الصيغة الكيميائية للمعاينة',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // الصيغ الجاهزة
            Text(
              'الصيغ الجاهزة:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: ChemistryFormulasLibrary.formulas.map((formula) {
                return ActionChip(
                  label: Text(formula.formula),
                  onPressed: () {
                    _formulaController.text = formula.formula;
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // أزرار
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
                    text: 'إدراج',
                    type: AppButtonType.success,
                    icon: Icons.check,
                    onPressed: () {
                      widget.onSave(_formulaController.text);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildElementToolbar() {
    final elements = ['H', 'He', 'Li', 'C', 'N', 'O', 'F', 'Na', 'Mg', 'Al', 'Si', 'P', 'S', 'Cl', 'K', 'Ca', 'Fe', 'Cu', 'Zn', 'Ag', 'Au'];
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: elements.map((element) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ActionChip(
              label: Text(element),
              onPressed: () {
                final currentText = _formulaController.text;
                _formulaController.text = currentText + element;
              },
            ),
          );
        }).toList(),
      ),
    );
  }
  
  String _formatChemicalFormula(String formula) {
    // تحويل الأرقام إلى أحرف منخفضة (Subscript)
    String result = formula;
    result = result.replaceAllMapped(
      RegExp(r'(\d+)'),
      (match) => String.fromCharCodes(
        match.group(1)!.codeUnits.map((code) => code + 8272),
      ),
    );
    return result;
  }
}
