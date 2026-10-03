// lib/core/utils/error_handler.dart
import 'dart:async';
import 'dart:io';

/// استثناء مخصص لأخطاء منطق الأعمال.
class AppException implements Exception {
  final String message;
  final String? userMessage;

  const AppException(this.message, {this.userMessage});

  @override
  String toString() => 'AppException: $message';
}

/// يحوّل أي استثناء إلى رسالة عربية صديقة للمستخدم.
class ErrorHandler {
  /// - استثناءات الأعمال (AppException / نص عربي) → تُعرض كما هي
  /// - الاستثناءات التقنية (Socket, Timeout, FS) → تُترجم
  /// - غير معروف → يستخدم [fallback] أو رسالة عامة
  static String humanize(Object error, {String? fallback}) {
    // 1. AppException
    if (error is AppException) {
      return error.userMessage ?? error.message;
    }

    // 2. نص عربي = خطأ أعمال
    final str = error.toString();
    if (_containsArabic(str)) {
      return str
          .replaceFirst(RegExp(r'^Exception:\s*'), '')
          .replaceFirst(RegExp(r'^AppException:\s*'), '')
          .trim();
    }

    // 3. خطأ تقني
    final technical = _mapTechnical(error);
    if (technical != null) {
      return fallback != null ? '$fallback\n$technical' : technical;
    }

    // 4. غير معروف
    return fallback ?? 'حدث خطأ غير متوقع. حاول مرة أخرى.';
  }

  /// للاستخدام في الـ Snackbars مباشرة.
  static String format(Object error, String context) {
    return humanize(error, fallback: context);
  }

  static String? _mapTechnical(Object error) {
    if (error is SocketException) {
      return 'تعذر الاتصال بالشبكة.';
    }
    if (error is TimeoutException) {
      return 'انتهت مهلة العملية. حاول مرة أخرى.';
    }
    if (error is FileSystemException) {
      return 'تعذر الوصول إلى الملف. تحقق من الصلاحيات.';
    }
    if (error is FormatException) {
      return 'تنسيق البيانات غير صحيح.';
    }
    return null;
  }

  static bool _containsArabic(String s) {
    return RegExp(r'[\u0600-\u06FF]').hasMatch(s);
  }
}
