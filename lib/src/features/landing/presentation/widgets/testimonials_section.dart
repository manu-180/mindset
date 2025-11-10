import 'dart:async'; 

import 'package:flutter/material.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialCard extends StatefulWidget {
  const _TestimonialCard({required this.onHoverChange});
  
  final Function(bool isHovering) onHoverChange;

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final List<String> _data = List.generate(10, (index) => 'Testimonio ${index + 1}');
  
  static const int _infiniteCount = 10000;
  
  late PageController _pageController;
  Timer? _timer;
  
  late int _initialPage; 
  int _currentActualIndex = 0;
  
  double _currentViewportFraction = 0.8; 
  bool _isPausedByHover = false; 

  @override
  void initState() {
    super.initState();
    _initialPage = _infiniteCount ~/ 2; 
    _currentActualIndex = _initialPage % _data.length;

    _pageController = PageController(
      viewportFraction: _currentViewportFraction,
      initialPage: _initialPage,
    );
    
    _pageController.addListener(_handlePageScroll);
    _startAutoScroll();
  }
  
  void _recreatePageController(double newFraction) {
    if (_currentViewportFraction == newFraction) return;

    final currentPage = _pageController.page?.toInt() ?? _initialPage;
    
    _pageController.removeListener(_handlePageScroll);
    _pageController.dispose();

    _currentViewportFraction = newFraction;
    _pageController = PageController(
      viewportFraction: _currentViewportFraction,
      initialPage: currentPage,
    );
    _pageController.addListener(_handlePageScroll);
    
    // NOTA: Ya no necesitamos setState() aquí porque MediaQuery lo gestiona
  }
  
  void _handlePageScroll() {
    if (_pageController.page != null && _pageController.page! % 1.0 == 0) {
      final newIndex = _pageController.page!.toInt() % _data.length;
      if (_currentActualIndex != newIndex) {
        setState(() {
          _currentActualIndex = newIndex;
        });
        if (!_isPausedByHover) {
          _startAutoScroll(); 
        }
      }
    }
  }
  
  void _handleHoverChange(bool isHovering) {
    if (_isPausedByHover == isHovering) return;
    
    _isPausedByHover = isHovering;
    if (isHovering) {
      _timer?.cancel(); 
    } else {
      _startAutoScroll(); 
    }
  }

  void _startAutoScroll() {
    if (_isPausedByHover) return; 

    _timer?.cancel();
    
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      if (!_pageController.hasClients) return;
      
      if (_isPausedByHover) {
        _timer?.cancel();
        return;
      }
      
      int nextPage = (_pageController.page?.toInt() ?? _initialPage) + 1;
      
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }
  
  void _onPageChanged(int index) {
     setState(() {
      _currentActualIndex = index % _data.length;
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
    // USAMOS MediaQuery.of(context).size.width en lugar de constraints.maxWidth
    final screenWidth = MediaQuery.of(context).size.width; 
    final isMobile = screenWidth < 600;

    // Calcular la responsabilidad *antes* del PageView
    final double cardWidth = isMobile 
        ? screenWidth * 0.75 
        : 200.0; 

    final double targetViewportFraction = isMobile
        ? 0.8 
        : 0.28;
    
    // La recreación debe hacerse aquí para que el controlador se actualice
    // al cambiar el ancho de la pantalla (ej: rotación).
    _recreatePageController(targetViewportFraction); 

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
            // Child de PageView
            child: PageView.builder(
              controller: _pageController,
              itemCount: _infiniteCount, 
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: cardWidth, // Usamos el ancho calculado
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _TestimonialCard(onHoverChange: _handleHoverChange),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          
          // Indicadores de página (Puntitos)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _data.asMap().entries.map((entry) {
              final index = entry.key;
              return GestureDetector(
                onTap: () {
                  final currentPage = _pageController.page?.toInt() ?? _initialPage;
                  final difference = index - _currentActualIndex;
                  final targetPage = currentPage + difference;
                  
                  _pageController.animateToPage(
                    targetPage,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  _startAutoScroll();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8.0,
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

// Widget privado para la tarjeta de testimonio (Integración de Hover/Scale y Bordes)
class _TestimonialCardState extends State<_TestimonialCard> {
  bool _isHovering = false;
  
  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovering = true);
        widget.onHoverChange(true);
      },
      onExit: (_) {
        setState(() => _isHovering = false);
        widget.onHoverChange(false);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: _isHovering ? 1.05 : 1.0, 
        curve: Curves.easeOut,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: borderRadius), // Bordes redondeados
          clipBehavior: Clip.antiAlias,
          elevation: _isHovering ? 8 : 4,
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
        ),
      ),
    );
  }
}