import 'package:flutter/material.dart';

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colors = _getColors(context, type);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(colors.icon, color: colors.foreground),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: colors.foreground),
              ),
            ),
          ],
        ),
        backgroundColor: colors.background,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
  static _SnackbarColors _getColors(BuildContext context, SnackbarType type) {
    switch (type) {
      case SnackbarType.success:
        return _SnackbarColors(
          background: Colors.green.shade600,
          foreground: Colors.white,
          icon: Icons.check_circle,
        );
      case SnackbarType.error:
        return _SnackbarColors(
          background: Colors.red.shade600,
          foreground: Colors.white,
          icon: Icons.error,
        );
      case SnackbarType.warning:
        return _SnackbarColors(
          background: Colors.orange.shade50,
          foreground: Colors.orange.shade800,
          icon: Icons.warning,
        );
      case SnackbarType.info:
        return _SnackbarColors(
          background: Colors.blue.shade50,
          foreground: Colors.blue.shade800,
          icon: Icons.info,
        );
    }
  }
}

class _SnackbarColors {
  final Color background;
  final Color foreground;
  final IconData icon;
  
  _SnackbarColors({
    required this.background,
    required this.foreground,
    required this.icon,
  });
}

enum SnackbarType { success, error, warning, info }
