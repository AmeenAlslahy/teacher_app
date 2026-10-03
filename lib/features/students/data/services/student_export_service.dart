import 'dart:io';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class StudentExportService {
  // تصدير إلى CSV
  static Future<File> exportToCsv(List<Map<String, dynamic>> students) async {
    final headers = ['الرقم المدرسي', 'الاسم', 'الصف', 'الشعبة', 'هاتف ولي الأمر', 'البريد', 'ملاحظات'];
    
    final rows = <List<dynamic>>[headers];
    for (final student in students) {
      rows.add([
        student['studentNumber'] ?? '',
        student['name'] ?? '',
        student['className'] ?? '',
        student['sectionName'] ?? '',
        student['parentPhone'] ?? '',
        student['email'] ?? '',
        student['notes'] ?? '',
      ]);
    }
    
    final csvData = const ListToCsvConverter().convert(rows);
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/students_${DateTime.now().millisecondsSinceEpoch}.csv');
    await file.writeAsString(csvData);
    
    return file;
  }
  
  // تصدير إلى Excel
  static Future<File> exportToExcel(List<Map<String, dynamic>> students) async {
    final excel = Excel.createExcel();
    final sheet = excel['الطلاب'];
    
    // إضافة الرؤوس
    final headers = ['الرقم المدرسي', 'الاسم', 'الصف', 'الشعبة', 'هاتف ولي الأمر', 'البريد', 'ملاحظات'];
    for (var i = 0; i < headers.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
        ..value = TextCellValue(headers[i])
        ..cellStyle = CellStyle(bold: true);
    }
    
    // إضافة البيانات
    for (var i = 0; i < students.length; i++) {
      final student = students[i];
      final rowIndex = i + 1;
      
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex))
        .value = TextCellValue(student['studentNumber'] ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex))
        .value = TextCellValue(student['name'] ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex))
        .value = TextCellValue(student['className'] ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex))
        .value = TextCellValue(student['sectionName'] ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex))
        .value = TextCellValue(student['parentPhone'] ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex))
        .value = TextCellValue(student['email'] ?? '');
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex))
        .value = TextCellValue(student['notes'] ?? '');
    }
    
    // حفظ الملف
    final bytes = excel.encode();
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/students_${DateTime.now().millisecondsSinceEpoch}.xlsx');
    await file.writeAsBytes(bytes!);
    
    return file;
  }
  
  // مشاركة الملف
  static Future<void> shareFile(File file) async {
    final xFile = XFile(file.path);
    await Share.shareXFiles([xFile], text: 'تصدير بيانات الطلاب');
  }
}
