import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindset/src/features/landing/presentation/screens/landing_screen.dart';

// Provider para el router, accesible globalmente.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true, // Útil para debuggear la navegación
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LandingScreen();
        },
      ),
      // Aquí agregaremos más rutas en el futuro, ej: /auth, /checkout
    ],
  );
});