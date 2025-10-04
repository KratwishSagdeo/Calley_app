import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/dashboard_provider.dart';

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);

    return Drawer(
      child: Column(
        children: [
          // Header
          UserAccountsDrawerHeader(
            accountName: Text(
              user?.name ?? 'User',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                user?.name.isNotEmpty == true ? user!.name[0].toUpperCase() : '?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: AppColors.primary,
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  icon: Icons.dashboard,
                  title: l10n?.dashboard ?? 'Dashboard',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildMenuItem(
                  icon: Icons.play_lesson,
                  title: l10n?.gettingStarted ?? 'Getting Started',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/onboarding');
                  },
                ),
                _buildMenuItem(
                  icon: Icons.sync,
                  title: l10n?.syncData ?? 'Sync Data',
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(dashboardProvider.notifier).syncData();
                  },
                ),
                _buildMenuItem(
                  icon: Icons.games,
                  title: l10n?.gamification ?? 'Gamification',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to gamification page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.bug_report,
                  title: l10n?.sendLogs ?? 'Send Logs',
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(dashboardProvider.notifier).sendLogs();
                  },
                ),
                _buildMenuItem(
                  icon: Icons.settings,
                  title: l10n?.settings ?? 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/settings');
                  },
                ),
                _buildMenuItem(
                  icon: Icons.help,
                  title: l10n?.help ?? 'Help & Support',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to help page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.info,
                  title: l10n?.aboutUs ?? 'About Us',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to about page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.privacy_tip,
                  title: l10n?.privacyPolicy ?? 'Privacy Policy',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to privacy policy page
                  },
                ),
                _buildMenuItem(
                  icon: Icons.cancel,
                  title: l10n?.cancelSubscription ?? 'Cancel Subscription',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle subscription cancellation
                  },
                ),
              ],
            ),
          ),
          // Footer
          Column(
            children: [
              const Divider(),
              FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Version ${snapshot.data!.version}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              _buildMenuItem(
                icon: Icons.logout,
                title: l10n?.logout ?? 'Logout',
                onTap: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n?.confirm ?? 'Confirm'),
                      content: Text(l10n?.logoutConfirmation ?? 'Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(l10n?.cancel ?? 'Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(l10n?.logout ?? 'Logout'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true && context.mounted) {
                    Navigator.pop(context);
                    await ref.read(authProvider.notifier).logout();
                    context.go('/login');
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.textPrimary,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}