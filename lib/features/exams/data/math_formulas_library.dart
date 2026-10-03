// lib/features/exams/data/math_formulas_library.dart
import '../domain/entities/question_content.dart';

class MathFormulasLibrary {
  // الصيغ الجبرية
  static const List<MathFormula> algebraFormulas = [
    MathFormula(
      latex: r'x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}',
      displayText: 'القانون العام للمعادلة التربيعية',
      category: MathCategory.algebra,
    ),
    MathFormula(
      latex: r'(a + b)^2 = a^2 + 2ab + b^2',
      displayText: 'مربع مجموع',
      category: MathCategory.algebra,
    ),
    MathFormula(
      latex: r'a^2 - b^2 = (a+b)(a-b)',
      displayText: 'فرق المربعات',
      category: MathCategory.algebra,
    ),
    MathFormula(
      latex: r'\log_a(xy) = \log_a(x) + \log_a(y)',
      displayText: 'خواص اللوغاريتمات',
      category: MathCategory.algebra,
    ),
  ];
  
  // الصيغ الهندسية
  static const List<MathFormula> geometryFormulas = [
    MathFormula(
      latex: r'A = \pi r^2',
      displayText: 'مساحة الدائرة',
      category: MathCategory.geometry,
    ),
    MathFormula(
      latex: r'V = \frac{4}{3}\pi r^3',
      displayText: 'حجم الكرة',
      category: MathCategory.geometry,
    ),
    MathFormula(
      latex: r'A = \frac{1}{2}bh',
      displayText: 'مساحة المثلث',
      category: MathCategory.geometry,
    ),
    MathFormula(
      latex: r'V = l \times w \times h',
      displayText: 'حجم متوازي المستطيلات',
      category: MathCategory.geometry,
    ),
  ];
  
  // صيغ حساب المثلثات
  static const List<MathFormula> trigonometryFormulas = [
    MathFormula(
      latex: r'\sin^2\theta + \cos^2\theta = 1',
      displayText: 'المتطابقة الأساسية',
      category: MathCategory.trigonometry,
    ),
    MathFormula(
      latex: r'\sin(A+B) = \sin A \cos B + \cos A \sin B',
      displayText: 'جيب مجموع زاويتين',
      category: MathCategory.trigonometry,
    ),
    MathFormula(
      latex: r'\cos 2\theta = \cos^2\theta - \sin^2\theta',
      displayText: 'جيب تمام الزاوية المزدوجة',
      category: MathCategory.trigonometry,
    ),
  ];
  
  // صيغ التفاضل والتكامل
  static const List<MathFormula> calculusFormulas = [
    MathFormula(
      latex: r'\frac{d}{dx}(x^n) = nx^{n-1}',
      displayText: 'قاعدة القوة',
      category: MathCategory.calculus,
    ),
    MathFormula(
      latex: r'\int x^n dx = \frac{x^{n+1}}{n+1} + C',
      displayText: 'تكامل القوة',
      category: MathCategory.calculus,
    ),
    MathFormula(
      latex: r'\int_a^b f(x) dx = F(b) - F(a)',
      displayText: 'النظرية الأساسية للتفاضل والتكامل',
      category: MathCategory.calculus,
    ),
  ];
  
  // جميع الصيغ
  static List<MathFormula> getAllFormulas() {
    return [
      ...algebraFormulas,
      ...geometryFormulas,
      ...trigonometryFormulas,
      ...calculusFormulas,
    ];
  }
  
  // البحث في الصيغ
  static List<MathFormula> searchFormulas(String query) {
    if (query.isEmpty) return getAllFormulas();
    
    return getAllFormulas().where((formula) {
      return formula.displayText.contains(query) ||
             formula.latex.contains(query);
    }).toList();
  }
}

// مكتبة الصيغ الفيزيائية
class PhysicsFormulasLibrary {
  static const List<PhysicsFormula> formulas = [
    PhysicsFormula(
      latex: r'F = ma',
      name: 'قانون نيوتن الثاني',
      description: 'القوة = الكتلة × التسارع',
      variables: ['F', 'm', 'a'],
      units: ['نيوتن (N)', 'كجم (kg)', 'م/ث² (m/s²)'],
    ),
    PhysicsFormula(
      latex: r'E = mc^2',
      name: 'معادلة أينشتاين',
      description: 'الطاقة = الكتلة × مربع سرعة الضوء',
      variables: ['E', 'm', 'c'],
      units: ['جول (J)', 'كجم (kg)', 'م/ث (m/s)'],
    ),
    PhysicsFormula(
      latex: r'v = \frac{d}{t}',
      name: 'السرعة',
      description: 'السرعة = المسافة ÷ الزمن',
      variables: ['v', 'd', 't'],
      units: ['م/ث (m/s)', 'متر (m)', 'ثانية (s)'],
    ),
    PhysicsFormula(
      latex: r'P = \frac{W}{t}',
      name: 'القدرة',
      description: 'القدرة = الشغل ÷ الزمن',
      variables: ['P', 'W', 't'],
      units: ['واط (W)', 'جول (J)', 'ثانية (s)'],
    ),
    PhysicsFormula(
      latex: r'V = IR',
      name: 'قانون أوم',
      description: 'الجهد = التيار × المقاومة',
      variables: ['V', 'I', 'R'],
      units: ['فولت (V)', 'أمبير (A)', 'أوم (Ω)'],
    ),
  ];
}

// مكتبة الصيغ الكيميائية
class ChemistryFormulasLibrary {
  static const List<ChemicalFormula> formulas = [
    ChemicalFormula(
      formula: 'H₂O',
      name: 'الماء',
      type: ChemicalType.molecule,
    ),
    ChemicalFormula(
      formula: 'CO₂',
      name: 'ثاني أكسيد الكربون',
      type: ChemicalType.molecule,
    ),
    ChemicalFormula(
      formula: 'NaCl',
      name: 'كلوريد الصوديوم (ملح الطعام)',
      type: ChemicalType.compound,
    ),
    ChemicalFormula(
      formula: 'H₂SO₄',
      name: 'حمض الكبريتيك',
      type: ChemicalType.compound,
    ),
    ChemicalFormula(
      formula: 'C₆H₁₂O₆',
      name: 'الجلوكوز',
      type: ChemicalType.molecule,
    ),
  ];
  
  // معادلات كيميائية جاهزة
  static const List<String> equations = [
    r'2H_2 + O_2 \rightarrow 2H_2O',
    r'NaOH + HCl \rightarrow NaCl + H_2O',
    r'2Na + Cl_2 \rightarrow 2NaCl',
    r'CaCO_3 \rightarrow CaO + CO_2',
    r'CH_4 + 2O_2 \rightarrow CO_2 + 2H_2O',
  ];
}
