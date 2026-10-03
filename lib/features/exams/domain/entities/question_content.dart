// lib/features/exams/domain/entities/question_content.dart


// أنواع المحتوى المدعومة
enum ContentBlockType {
  text('نص'),
  math('معادلة رياضية'),
  physics('معادلة فيزيائية'),
  chemistry('معادلة كيميائية'),
  image('صورة'),
  table('جدول'),
  chemicalFormula('صيغة كيميائية'),
  fraction('كسر'),
  matrix('مصفوفة'),
  integral('تكامل'),
  summation('مجموع'),
  vector('متجه'),
  greekLetter('حرف يوناني');

  final String label;
  const ContentBlockType(this.label);
}

class ContentBlock {
  final String id;
  final ContentBlockType type;
  final String content; // النص أو الصيغة
  final Map<String, dynamic>? metadata; // بيانات إضافية
  final int order;
  
  const ContentBlock({
    required this.id,
    required this.type,
    required this.content,
    this.metadata,
    required this.order,
  });
  
  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'content': content,
      'metadata': metadata,
      'order': order,
    };
  }
  
  // إنشاء من JSON
  factory ContentBlock.fromJson(Map<String, dynamic> json) {
    return ContentBlock(
      id: json['id'],
      type: ContentBlockType.values.firstWhere((t) => t.name == json['type']),
      content: json['content'],
      metadata: json['metadata'],
      order: json['order'],
    );
  }
}

// نموذج الصيغة الرياضية
class MathFormula {
  final String latex;
  final String displayText;
  final MathCategory category;
  
  const MathFormula({
    required this.latex,
    required this.displayText,
    this.category = MathCategory.general,
  });
}

enum MathCategory {
  algebra('جبر'),
  geometry('هندسة'),
  trigonometry('حساب مثلثات'),
  calculus('تفاضل وتكامل'),
  statistics('إحصاء'),
  general('عام');

  final String label;
  const MathCategory(this.label);
}

// نموذج الصيغة الكيميائية
class ChemicalFormula {
  final String formula; // H2O, CO2, NaCl
  final String name; // اسم المركب
  final ChemicalType type;
  
  const ChemicalFormula({
    required this.formula,
    required this.name,
    this.type = ChemicalType.molecule,
  });
}

enum ChemicalType {
  element('عنصر'),
  molecule('جزيء'),
  compound('مركب'),
  ion('أيون'),
  isotope('نظير');

  final String label;
  const ChemicalType(this.label);
}

// نموذج المعادلة الفيزيائية
class PhysicsFormula {
  final String latex;
  final String name;
  final String description;
  final List<String> variables;
  final List<String> units;
  
  const PhysicsFormula({
    required this.latex,
    required this.name,
    required this.description,
    required this.variables,
    required this.units,
  });
}
