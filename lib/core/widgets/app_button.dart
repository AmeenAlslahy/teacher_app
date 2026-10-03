import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

enum AppButtonType { primary, secondary, outline, danger, ghost, success }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final String? tooltip;
  final String? semanticLabel;

  const AppButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.tooltip,
    this.semanticLabel,
  });

  bool get _isDisabled => onPressed == null || isLoading;

  @override
  Widget build(BuildContext context) {
    final style = _buildStyle(context);
    final content = _buildContent(context);

    Widget button;
    switch (type) {
      case AppButtonType.outline:
        button = OutlinedButton(
          onPressed: _isDisabled ? null : onPressed,
          style: style,
          child: content,
        );
        break;
      case AppButtonType.ghost:
        button = TextButton(
          onPressed: _isDisabled ? null : onPressed,
          style: style,
          child: content,
        );
        break;
      case AppButtonType.primary:
      case AppButtonType.secondary:
      case AppButtonType.danger:
      case AppButtonType.success:
        button = ElevatedButton(
          onPressed: _isDisabled ? null : onPressed,
          style: style,
          child: content,
        );
        break;
    }

    if (isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return Semantics(
      button: true,
      label: semanticLabel ?? text,
      enabled: !_isDisabled,
      child: button,
    );
  }

  Widget _buildContent(BuildContext context) {
    final iconSize = _iconSize();
    final spacing = _spacing();

    // عند التحميل، نُبقي النص مع spinner جانبه
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _foregroundColor(context),
            ),
          ),
          if (text.isNotEmpty) ...[
            SizedBox(width: spacing),
            Flexible(
              child: Text(
                text,
                style: _textStyle(context),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ],
      );
    }

    if (icon == null) {
      return Text(
        text,
        style: _textStyle(context),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: iconSize, color: _foregroundColor(context)),
        SizedBox(width: spacing),
        Flexible(
          child: Text(
            text,
            style: _textStyle(context),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  ButtonStyle _buildStyle(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = BorderRadius.circular(_borderRadius());
    final minSize = Size(0, _height());

    switch (type) {
      case AppButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
          elevation: 0,
          minimumSize: minSize,
          shape: RoundedRectangleBorder(borderRadius: radius),
        );

      case AppButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: scheme.secondary,
          foregroundColor: scheme.onSecondary,
          disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
          elevation: 0,
          minimumSize: minSize,
          shape: RoundedRectangleBorder(borderRadius: radius),
        );

      case AppButtonType.danger:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          foregroundColor: Colors.white,
          disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
          elevation: 0,
          minimumSize: minSize,
          shape: RoundedRectangleBorder(borderRadius: radius),
        );

      case AppButtonType.success:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
          elevation: 0,
          minimumSize: minSize,
          shape: RoundedRectangleBorder(borderRadius: radius),
        );

      case AppButtonType.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
          side: BorderSide(color: scheme.primary),
          minimumSize: minSize,
          shape: RoundedRectangleBorder(borderRadius: radius),
        );

      case AppButtonType.ghost:
        return TextButton.styleFrom(
          foregroundColor: scheme.primary,
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
          minimumSize: minSize,
          shape: RoundedRectangleBorder(borderRadius: radius),
        );
    }
  }

  double _height() {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 52;
    }
  }

  double _iconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  double _spacing() {
    switch (size) {
      case AppButtonSize.small:
        return AppSpacing.xs;
      case AppButtonSize.medium:
        return AppSpacing.sm;
      case AppButtonSize.large:
        return 12;
    }
  }

  double _borderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return AppRadius.sm;
      case AppButtonSize.medium:
        return AppRadius.md;
      case AppButtonSize.large:
        return AppRadius.lg;
    }
  }

  TextStyle? _textStyle(BuildContext context) {
    final fgColor = _foregroundColor(context);
    switch (size) {
      case AppButtonSize.small:
        return Theme.of(context).textTheme.labelSmall?.copyWith(color: fgColor);
      case AppButtonSize.medium:
        return Theme.of(context).textTheme.labelMedium?.copyWith(color: fgColor);
      case AppButtonSize.large:
        return Theme.of(context).textTheme.labelLarge?.copyWith(color: fgColor);
    }
  }

  Color _foregroundColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (type) {
      case AppButtonType.primary:
        return scheme.onPrimary;
      case AppButtonType.secondary:
        return scheme.onSecondary;
      case AppButtonType.danger:
      case AppButtonType.success:
        return Colors.white;
      case AppButtonType.outline:
      case AppButtonType.ghost:
        return scheme.primary;
    }
  }
}
