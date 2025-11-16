import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/config/router/app_router.dart';
import 'package:mindset/src/config/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'mindSET',
      debugShowCheckedModeBanner: false,
      
      theme: AppTheme.darkTheme,
      
      // Ya no se aplica el ScrollBehavior global
      routerConfig: goRouter,
    );
  }
}