import 'dart:async'; 

import 'package:flutter/material.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final List<String> _data = List.generate(10, (index) => 'Testimonio ${index + 1}');
  
  // Usamos un número grande de elementos para simular un loop infinito.
  static const int _infiniteCount = 10000;
  
  late final PageController _pageController;
  Timer? _timer;
  
  // La página central es el punto de inicio para permitir el scroll hacia ambos lados.
  late int _initialPage; 
  int _currentActualIndex = 0;
  
  static const double _cardWidth = 200.0; 

  @override
  void initState() {
    super.initState();
    // Calculamos una página inicial cerca del centro del carrusel virtual.
    _initialPage = _infiniteCount ~/ 2; 
    _currentActualIndex = _initialPage % _data.length;

    _pageController = PageController(
      viewportFraction: 0.28,
      initialPage: _initialPage, // Empezamos en el centro.
    );
    
    // Al añadir el listener, podemos actualizar el índice de los puntos 
    // y resetear el timer si el usuario interactúa manualmente.
    _pageController.addListener(_handlePageScroll);
    
    _startAutoScroll();
  }

  void _handlePageScroll() {
    // Si la página actual es un número entero (terminó la transición), actualizamos el índice de los puntos.
    if (_pageController.page != null && _pageController.page! % 1.0 == 0) {
      final newIndex = _pageController.page!.toInt() % _data.length;
      if (_currentActualIndex != newIndex) {
        setState(() {
          _currentActualIndex = newIndex;
        });
        // Si el usuario toca/swipea, cancelamos y reiniciamos el auto-scroll
        _startAutoScroll(); 
      }
    }
  }

  void _startAutoScroll() {
    _timer?.cancel();
    
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      if (!_pageController.hasClients) return;

      int nextPage = (_pageController.page?.toInt() ?? _initialPage) + 1;
      
      // No necesitamos un chequeo de final de lista, PageView lo deslizará.
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _pageController.removeListener(_handlePageScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --- Título ---
          Text(
            'TESTIMONIOS', 
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),

          // --- Carrusel Horizontal usando PageView ---
          SizedBox(
            height: 350, 
            child: PageView.builder(
              controller: _pageController,
              // Usamos el itemCount grande.
              itemCount: _infiniteCount, 
              // El onPageChanged solo sirve para actualizar el _currentActualIndex al finalizar el scroll manual.
              onPageChanged: (index) {
                setState(() {
                  _currentActualIndex = index % _data.length;
                });
              },
              itemBuilder: (context, index) {
                // Usamos el módulo para obtener los datos reales.
                final actualDataIndex = index % _data.length;
                
                return SizedBox(
                  width: _cardWidth, 
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    // Nota: No pasamos el index a _TestimonialCard ya que solo tiene el placeholder.
                    child: _TestimonialCard(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          
          // Indicadores de página (Puntitos con color primario)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _data.asMap().entries.map((entry) {
              final index = entry.key;
              return GestureDetector(
                onTap: () {
                  // Calculamos la página a la que saltar desde la posición actual para el tap.
                  // Esto mantiene la animación fluida.
                  final currentPage = _pageController.page?.toInt() ?? _initialPage;
                  final difference = index - _currentActualIndex;
                  final targetPage = currentPage + difference;
                  
                  _pageController.animateToPage(
                    targetPage,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  // Reiniciamos el timer después de la interacción manual.
                  _startAutoScroll();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8.0,
                  // Comparamos con el índice real de los datos (_data.length)
                  width: _currentActualIndex == index ? 24.0 : 8.0, 
                  decoration: BoxDecoration(
                    color: _currentActualIndex == index
                        ? Theme.of(context).colorScheme.primary 
                        : Colors.grey[600],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// Widget privado para la tarjeta de testimonio (sin cambios)
class _TestimonialCard extends StatelessWidget {
  const _TestimonialCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Placeholder de la Imagen ---
          Container(
            height: 350,
            width: double.infinity,
            color: Colors.grey[800],
            child: const Center(
              child: Icon(Icons.image, size: 80, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}