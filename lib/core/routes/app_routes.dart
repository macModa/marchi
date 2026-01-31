import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/products/screens/home_screen.dart';
import '../../features/products/screens/product_detail_screen.dart';
import '../../features/products/screens/product_search_screen.dart';
import '../../features/products/screens/artisan_product_list_screen.dart';
import '../../features/products/screens/product_form_screen.dart';
import '../../features/orders/screens/cart_screen.dart';
import '../../features/orders/screens/checkout_screen.dart';
import '../../features/orders/screens/orders_list_screen.dart';
import '../../features/categories/screens/category_form_screen.dart';
import '../../features/payments/screens/payment_screen.dart';
import '../../features/auth/providers/auth_providers.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ProductDetailScreen(productId: id);
        },
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/payment/:orderId',
        builder: (context, state) {
          final orderId = int.parse(state.pathParameters['orderId']!);
          return PaymentScreen(orderId: orderId);
        },
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersListScreen(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const ProductSearchScreen(),
      ),
      GoRoute(
        path: '/artisan/products',
        builder: (context, state) => const ArtisanProductListScreen(),
      ),
      GoRoute(
        path: '/artisan/product/new',
        builder: (context, state) => const ProductFormScreen(),
      ),
      GoRoute(
        path: '/artisan/product/edit/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ProductFormScreen(productId: id);
        },
      ),
      GoRoute(
        path: '/admin/category/new',
        builder: (context, state) => const CategoryFormScreen(),
      ),
    ],
    redirect: (context, state) {
      // Get the current auth state
      final authValue = ref.read(authStateProvider);
      
      if (authValue is AsyncLoading) return null;

      final isAuthenticated = authValue.maybeWhen(
        data: (auth) => auth != null,
        orElse: () => false,
      );

      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';
      final isSplash = state.matchedLocation == '/';

      if (!isAuthenticated) {
        if (isLoggingIn || isRegistering) return null;
        return '/login';
      }

      if (isAuthenticated && (isLoggingIn || isRegistering || isSplash)) {
        return '/home';
      }

      return null;
    },
  );
});
