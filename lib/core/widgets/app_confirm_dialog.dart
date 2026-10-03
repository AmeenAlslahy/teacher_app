import 'package:flutter/material.dart';

class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final bool isDangerous;
  final IconData? icon;
  
  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = 'تأكيد',
    this.cancelText = 'إلغاء',
    this.isDangerous = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            icon ?? (isDangerous ? Icons.warning : Icons.info),
            color: isDangerous
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
        ],
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          child: Text(cancelText),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          style: isDangerous
              ? FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                )
              : FilledButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
