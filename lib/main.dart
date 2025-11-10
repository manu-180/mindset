import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/config/router/app_router.dart';
import 'package:mindset/src/config/theme/app_theme.dart';
// 1. Importar la librería de gestos
import 'package:flutter/gestures.dart';

// 2. Definir un ScrollBehavior personalizado que incluya el mouse
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse, // <--- Habilita el arrastre con mouse
  };
}


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
      
      // 3. Aplicar el ScrollBehavior personalizado a toda la app
      scrollBehavior: MyCustomScrollBehavior(),
      
      routerConfig: goRouter,
    );
  }
}