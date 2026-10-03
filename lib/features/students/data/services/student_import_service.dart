import 'dart:io';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';

// نموذج الاستيراد
class StudentImportModel {
  final int rowNumber;
  final String name;
  final String studentNumber;
  final String className;
  final String? sectionName;
  final String? parentPhone;
  final String? email;
  final String? notes;
  
  const StudentImportModel({
    required this.rowNumber,
    required this.name,
    required this.studentNumber,
    required this.className,
    this.sectionName,
    this.parentPhone,
    this.email,
    this.notes,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'rowNumber': rowNumber,
      'name': name,
      'studentNumber': studentNumber,
      'className': className,
      'sectionName': sectionName,
      'parentPhone': parentPhone,
      'email': email,
      'notes': notes,
    };
  }
}

class StudentImportService {
  // استيراد من CSV
  static Future<List<StudentImportModel>> importFromCsv(String filePath) async {
    final file = File(filePath);
    final content = await file.readAsString();
    final rows = const CsvToListConverter().convert(content);
    
    if (rows.isEmpty) return [];
    
    // تحديد أسماء الأعمدة من الصف الأول
    final headers = rows[0].map((e) => e.toString().trim()).toList();
    final students = <StudentImportModel>[];
    
    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.isEmpty) continue;
      
      final student = StudentImportModel(
        rowNumber: i + 1,
        name: _getValue(headers, row, ['name', 'الاسم', 'اسم الطالب']),
        studentNumber: _getValue(headers, row, ['studentNumber', 'number', 'الرقم', 'الرقم المدرسي']),
        className: _getValue(headers, row, ['class', 'className', 'الصف']),
        sectionName: _getValue(headers, row, ['section', 'sectionName', 'الشعبة']),
        parentPhone: _getValue(headers, row, ['parentPhone', 'phone', 'هاتف ولي الأمر', 'رقم ولي الأمر']),
        email: _getValue(headers, row, ['email', 'البريد']),
        notes: _getValue(headers, row, ['notes', 'ملاحظات']),
      );
      
      students.add(student);
    }
    
    return students;
  }
  
  // استيراد من Excel
  static Future<List<StudentImportModel>> importFromExcel(String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final excel = Excel.decodeBytes(bytes);
    
    final students = <StudentImportModel>[];
    
    for (final table in excel.tables.keys) {
      final sheet = excel.tables[table]!;
      if (sheet.rows.isEmpty) continue;
      
      // تحديد أسماء الأعمدة
      final headers = sheet.rows[0].map((e) => e?.value.toString() ?? '').toList();
      
      for (var i = 1; i < sheet.rows.length; i++) {
        final row = sheet.rows[i];
        if (row.isEmpty) continue;
        
        final values = row.map((e) => e?.value.toString() ?? '').toList();
        
        final student = StudentImportModel(
          rowNumber: i + 1,
          name: _getValue(headers, values, ['name', 'الاسم', 'اسم الطالب']),
          studentNumber: _getValue(headers, values, ['studentNumber', 'number', 'الرقم', 'الرقم المدرسي']),
          className: _getValue(headers, values, ['class', 'className', 'الصف']),
          sectionName: _getValue(headers, values, ['section', 'sectionName', 'الشعبة']),
          parentPhone: _getValue(headers, values, ['parentPhone', 'phone', 'هاتف ولي الأمر', 'رقم ولي الأمر']),
          email: _getValue(headers, values, ['email', 'البريد']),
          notes: _getValue(headers, values, ['notes', 'ملاحظات']),
        );
        
        students.add(student);
      }
    }
    
    return students;
  }
  
  // الحصول على قيمة من الصف بناءً على أسماء الأعمدة المحتملة
  static String _getValue(List<String> headers, List<dynamic> row, List<String> possibleNames) {
    for (var i = 0; i < headers.length; i++) {
      if (possibleNames.contains(headers[i].toLowerCase())) {
        return i < row.length ? row[i].toString().trim() : '';
      }
    }
    return '';
  }
  
  // التحقق من صحة البيانات
  static List<String> validateStudents(List<StudentImportModel> students) {
    final errors = <String>[];
    
    for (final student in students) {
      if (student.name.isEmpty) {
        errors.add('الصف ${student.rowNumber}: الاسم مطلوب');
      }
      if (student.studentNumber.isEmpty) {
        errors.add('الصف ${student.rowNumber}: الرقم المدرسي مطلوب');
      }
      if (student.className.isEmpty) {
        errors.add('الصف ${student.rowNumber}: الصف مطلوب');
      }
    }
    
    return errors;
  }
}

class ImportResult {
  final int successCount;
  final int failedCount;

  const ImportResult({
    required this.successCount,
    required this.failedCount,
  });
}
