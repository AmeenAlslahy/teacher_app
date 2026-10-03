import 'package:flutter/material.dart';
import '../../domain/entities/dashboard_data.dart';

class AlertsBanner extends StatelessWidget {
  final List<DashboardAlert> alerts;
  final void Function(DashboardAlert alert)? onAlertTap;

  const AlertsBanner({
    super.key,
    required this.alerts,
    this.onAlertTap,
  });

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) return const SizedBox.shrink();

    return Column(
      children: alerts.map((alert) {
        return _AlertTile(
          alert: alert,
          onTap: onAlertTap != null ? () => onAlertTap!(alert) : null,
        );
      }).toList(),
    );
  }
}

class _AlertTile extends StatelessWidget {
  final DashboardAlert alert;
  final VoidCallback? onTap;

  const _AlertTile({required this.alert, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = _getAlertColors(alert.type);

    return Card(
      color: colors.background,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            colors.icon,
            color: colors.foreground,
          ),
          title: Text(
            alert.title,
            style: TextStyle(
              color: colors.foreground,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            alert.message,
            style: TextStyle(
              color: colors.foreground,
              fontSize: 12,
            ),
          ),
          trailing: onTap != null
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: colors.foreground,
                )
              : null,
        ),
      ),
    );
  }

  _AlertColors _getAlertColors(AlertType type) {
    switch (type) {
      case AlertType.warning:
        return _AlertColors(
          background: Colors.orange.withValues(alpha: 0.1),
          foreground: Colors.orange.shade800,
          icon: Icons.warning_amber,
        );
      case AlertType.info:
        return _AlertColors(
          background: Colors.blue.withValues(alpha: 0.1),
          foreground: Colors.blue.shade800,
          icon: Icons.info,
        );
      case AlertType.success:
        return _AlertColors(
          background: Colors.green.withValues(alpha: 0.1),
          foreground: Colors.green.shade800,
          icon: Icons.check_circle,
        );
      case AlertType.error:
        return _AlertColors(
          background: Colors.red.withValues(alpha: 0.1),
          foreground: Colors.red.shade800,
          icon: Icons.error,
        );
    }
  }
}

class _AlertColors {
  final Color background;
  final Color foreground;
  final IconData icon;

  _AlertColors({
    required this.background,
    required this.foreground,
    required this.icon,
  });
}
