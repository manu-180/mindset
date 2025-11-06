import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- El Provider ---
final landingScrollProvider =
    StateNotifierProvider<LandingScrollNotifier, LandingScrollState>((ref) {
  return LandingScrollNotifier();
});

// --- El Estado ---
@immutable
class LandingScrollState {
  const LandingScrollState({
    required this.heroKey,
    required this.aboutKey,
    required this.eliteKey,
    required this.authorKey,
    required this.plansKey,
    required this.testimonialsKey,
  });

  // Una GlobalKey para cada sección navegable
  final GlobalKey heroKey;
  final GlobalKey aboutKey;
  final GlobalKey eliteKey;
  final GlobalKey authorKey;
  final GlobalKey plansKey;
  final GlobalKey testimonialsKey;
}

// --- El Notifier (El cerebro) ---
class LandingScrollNotifier extends StateNotifier<LandingScrollState> {
  // Inicializa el estado con las GlobalKeys
  LandingScrollNotifier()
      : super(
          LandingScrollState(
            heroKey: GlobalKey(),
            aboutKey: GlobalKey(),
            eliteKey: GlobalKey(),
            authorKey: GlobalKey(),
            plansKey: GlobalKey(),
            testimonialsKey: GlobalKey(),
          ),
        );

  /// Hace scroll suavemente hasta el widget asociado con la [key]
  Future<void> scrollToKey(GlobalKey key) async {
    // Esperamos un momento para asegurar que el widget esté renderizado
    await Future.delayed(const Duration(milliseconds: 50));

    final context = key.currentContext;
    if (context != null) {
      // Usamos Scrollable.ensureVisible para la animación
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.1, // Alinea un poco por debajo del AppBar
      );
    }
  }
}