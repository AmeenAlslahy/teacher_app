import 'package:flutter/foundation.dart';
import '../utils/error_handler.dart';

abstract class BaseProvider extends ChangeNotifier {
  String? _error;
  bool _isLoading = false;
  
  String? get error => _error;
  bool get isLoading => _isLoading;
  
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }
  
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void handleError(dynamic error, {String? fallbackMessage}) {
    _error = ErrorHandler.humanize(error, fallback: fallbackMessage);
    debugPrint('Error: $error');
    notifyListeners();
  }
  
  void clearError() {
    _error = null;
    notifyListeners();
  }
  
  void showSuccess(String message) {
    debugPrint('Success: $message');
    // يمكن إضافة Snackbar هنا
  }
  
  void showWarning(String message) {
    debugPrint('Warning: $message');
  }
  
  @override
  void dispose() {
    _error = null;
    super.dispose();
  }
}