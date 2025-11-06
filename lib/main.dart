import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/config/router/app_router.dart';
import 'package:mindset/src/config/theme/app_theme.dart';

void main() {
  runApp(
    // 1. ProviderScope: El widget raíz para Riverpod
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// 2. Usamos ConsumerWidget para leer el provider del router
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Leemos el router desde el provider
    final goRouter = ref.watch(routerProvider);

    // 3. Usamos MaterialApp.router para integrar GoRouter
    return MaterialApp.router(
      title: 'mindSET',
      debugShowCheckedModeBanner: false,
      
      // 4. Aplicamos nuestro tema personalizado
      theme: AppTheme.darkTheme,
      
      // Configuraciones del router
      routerConfig: goRouter,
    );
  }
}