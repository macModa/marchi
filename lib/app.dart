import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routes/app_routes.dart';
import 'core/constants/app_constants.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(AppConstants.colorBackground),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(AppConstants.colorPrimary),
          primary: const Color(AppConstants.colorPrimary),
          secondary: const Color(AppConstants.colorSecondary),
          surface: const Color(AppConstants.colorBackground),
          onSurface: const Color(AppConstants.colorTextPrimary),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          displayLarge: TextStyle(color: const Color(AppConstants.colorTextPrimary), fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: const Color(AppConstants.colorTextPrimary), fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: const Color(AppConstants.colorTextPrimary)),
          bodyMedium: TextStyle(color: const Color(AppConstants.colorTextSecondary)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: AppConstants.defaultPadding,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(AppConstants.colorPrimary),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.largePadding,
              vertical: AppConstants.defaultPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
          ),
        ),
      ),
      routerConfig: router,
    );
  }
}
