import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Top Bar for Hub navigation screens.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withOpacity(0.9),
        border: const Border(
          bottom: BorderSide(color: AppTheme.glassBorder, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            iconSize: 28,
            icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.accentCyan),
            onPressed: () => Navigator.maybePop(context),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const Spacer(),
          if (actions != null) ...actions!,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
