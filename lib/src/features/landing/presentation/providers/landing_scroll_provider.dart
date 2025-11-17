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

  // --- INICIO DE LA CORRECCIÓN ---

  // 1. Definimos un offset (espacio) para dejar arriba de la sección.
  static const double _scrollOffset = 0.0; // Espacio deseado desde el top

  /// Hace scroll suavemente hasta el widget asociado con la [key]
  Future<void> scrollToKey(GlobalKey key) async {
    // Esperamos un momento para asegurar que el widget esté renderizado
    await Future.delayed(const Duration(milliseconds: 50));

    final context = key.currentContext;
    if (context == null) return;

    // 2. Encontramos el Scrollable más cercano
    final scrollableState = Scrollable.of(context);
    if (scrollableState == null) return;

    // 3. Obtenemos el controlador de la posición del scroll
    final scrollPosition = scrollableState.position;

    // 4. Encontramos el RenderObject (el "dibujo") del widget
    final renderBox = context.findRenderObject() as RenderBox;

    // 5. Calculamos la posición del widget relativa al *viewport* (la pantalla)
    final viewportOffset = renderBox.localToGlobal(
      Offset.zero,
      ancestor: scrollableState.context.findRenderObject(),
    );

    // 6. Calculamos la posición absoluta del widget dentro del scroll
    //    (Posición actual) + (Posición relativa en pantalla)
    final absoluteOffset = viewportOffset.dy + scrollPosition.pixels;

    // 7. Calculamos el destino
    //    (Posición absoluta) - (Offset deseado)
    final targetOffset = (absoluteOffset - _scrollOffset)
        // Usamos clamp para no scrollear por debajo de 0 o más allá del final
        .clamp(
      0.0,
      scrollPosition.maxScrollExtent,
    );

    // 8. Animamos al offset de píxeles exacto
    await scrollPosition.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }
  // --- FIN DE LA CORRECCIÓN ---
}