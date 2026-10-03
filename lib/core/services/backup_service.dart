import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../app/database/app_database.dart';

class BackupService {
  final AppDatabase _database;
  
  BackupService(this._database);
  
  Future<File> createBackup() async {
    final data = await _database.exportData();
    final jsonData = jsonEncode(data);
    
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final fileName = 'teacher_exam_backup_$timestamp.json';
    
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(jsonData);
    
    return file;
  }
  
  Future<void> shareBackup(File backupFile) async {
    await Share.shareXFiles(
      [XFile(backupFile.path)],
      subject: 'نسخة احتياطية لتطبيق مدير الاختبارات',
    );
  }
  
  Future<bool> restoreBackup(File backupFile) async {
    try {
      final jsonData = await backupFile.readAsString();
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      
      await _database.importData(data);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  Future<bool> validateBackup(File backupFile) async {
    try {
      final jsonData = await backupFile.readAsString();
      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      // التحقق من المفاتيح المطلوبة (متوافقة مع exportData)
      final requiredKeys = [
        'version',
        'schools',
        'classes',
        'students',
      ];

      for (final key in requiredKeys) {
        if (!data.containsKey(key)) return false;
      }

      // التحقق من الإصدار
      final version = data['version'] as int?;
      if (version == null || version < 1) return false;

      return true;
    } catch (_) {
      return false;
    }
  }
}