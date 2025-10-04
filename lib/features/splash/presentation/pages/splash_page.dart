import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';


class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for a moment to show splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Check if user is first time launching app
    final isFirstLaunch = AppConfig.localStorageService.isFirstLaunch();

    if (isFirstLaunch) {
      // Mark as not first launch anymore
      await AppConfig.localStorageService.setFirstLaunch(false);
      // Navigate to language selection
      if (mounted) {
        context.go('/language');
      }
    } else {
      // Check if user is authenticated
      final token = await AppConfig.storageService.getToken();

      if (token != null) {
        // User is authenticated, navigate to dashboard
        if (mounted) {
          context.go('/dashboard');
        }
      } else {
        // User is not authenticated, navigate to login
        if (mounted) {
          context.go('/login');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                Icons.phone_in_talk,
                size: 60,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            // App Name
            Text(
              AppStrings.appName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            Text(
              'Smart Calling Solution',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 40),
            // Loading Indicator
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}