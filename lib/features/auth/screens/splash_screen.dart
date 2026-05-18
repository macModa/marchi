import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../../../../core/constants/app_constants.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for auth state changes
    ref.listen(authStateProvider, (previous, next) {
      if (next is AsyncData) {
        if (next.value != null) {
          // Navigate to Home
          // We will use GoRouter later
        } else {
          // Navigate to Login
        }
      }
    });

    return Scaffold(
      backgroundColor: const Color(AppConstants.colorBackground),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Logo Text
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 48,
                      color: const Color(AppConstants.colorTextPrimary),
                      fontFamily: 'Georgia', // Temporary fallback for serif
                    ),
                    children: [
                      const TextSpan(text: "m'"),
                      TextSpan(
                        text: "art",
                        style: TextStyle(
                          color: const Color(AppConstants.colorPrimary),
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Cursive', // Temporary fallback for script
                        ),
                      ),
                      const TextSpan(text: "Chez"),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "l'artisanat, chez vous",
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color(AppConstants.colorTextSecondary),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            const CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
