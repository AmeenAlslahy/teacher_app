import 'package:shared_preferences/shared_preferences.dart';

class ContextPreferences {
  static const _keySchoolId = 'context_school_id';
  static const _keyClassId = 'context_class_id';
  static const _keySectionId = 'context_section_id';
  static const _keySubjectId = 'context_subject_id';
  static const _keyFirstLaunchDone = 'app_first_launch_done';

  static Future<Map<String, String?>> load() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'schoolId': prefs.getString(_keySchoolId),
      'classId': prefs.getString(_keyClassId),
      'sectionId': prefs.getString(_keySectionId),
      'subjectId': prefs.getString(_keySubjectId),
    };
  }

  static Future<void> save({
    String? schoolId,
    String? classId,
    String? sectionId,
    String? subjectId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (schoolId != null) await prefs.setString(_keySchoolId, schoolId);
    if (classId != null) await prefs.setString(_keyClassId, classId);
    if (sectionId != null) await prefs.setString(_keySectionId, sectionId);
    if (subjectId != null) await prefs.setString(_keySubjectId, subjectId);
  }

  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_keyFirstLaunchDone) ?? false);
  }

  static Future<void> markLaunched() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstLaunchDone, true);
  }

  static Future<bool> hasContext() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySchoolId) != null &&
        prefs.getString(_keyClassId) != null &&
        prefs.getString(_keySubjectId) != null;
  }

  // ===== Theme Mode =====
  static const _keyThemeMode = 'app_theme_mode';

  static Future<String?> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyThemeMode);
  }

  static Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, mode);
  }

  // ===== Locale =====
  static const _keyLocale = 'app_locale';

  static Future<String?> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLocale);
  }

  static Future<void> saveLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, code);
  }
}
