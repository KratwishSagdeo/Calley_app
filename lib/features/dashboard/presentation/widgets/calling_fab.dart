import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../providers/dashboard_provider.dart';

class CallingFab extends ConsumerWidget {
  const CallingFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final dashboardState = ref.watch(dashboardProvider);

    // ✅ Instead of "is DashboardLoading", check if it's loading via AsyncValue
    final isLoading = dashboardState.isLoading;

    return FloatingActionButton.extended(
      onPressed: isLoading
          ? null
          : () async {
        final contact =
        await ref.read(dashboardProvider.notifier).startCalling();
        if (contact != null && context.mounted) {
          _showCallingDialog(context, contact);
        }
      },
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      icon: isLoading
          ? const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      )
          : const Icon(Icons.phone),
      label: Text(l10n?.startCalling ?? 'Start Calling'),
    );
  }

  void _showCallingDialog(BuildContext context, dynamic contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Calling'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.phone_in_talk, size: 48, color: AppColors.primary),
            const SizedBox(height: 16),
            Text(
              contact.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(contact.phone),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Update call status to failed
            },
            child: const Text('End Call'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Update call status to completed
            },
            child: const Text('Complete Call'),
          ),
        ],
      ),
    );
  }
}
