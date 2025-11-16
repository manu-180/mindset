import 'dart:async';
import 'dart:ui'; // 1. IMPORTAR PARA PointerDeviceKind

import 'package:flutter/material.dart';
import 'package:mindset/src/constants/app_assets.dart';
import 'package:visibility_detector/visibility_detector.dart';

// 2. DEFINIR EL SCROLLBEHAVIOR LOCALMENTE
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse, // <--- Habilita el arrastre con mouse
      };
}

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialCard extends StatefulWidget {
  const _TestimonialCard({
    required this.onHoverChange,
    required this.imageUrl,
  });

  final Function(bool isHovering) onHoverChange;
  final String imageUrl;

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
    with SingleTickerProviderStateMixin {
  final List<String> _data = AppAssets.testimonialList;

  static const int _infiniteCount = 10000;

  late PageController _pageController;
  Timer? _timer;

  late int _initialPage;
  int _currentActualIndex = 0;
  late int _currentVirtualPage;

  double _currentViewportFraction = 0.8;
  bool _isPausedByHover = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initialPage = _infiniteCount ~/ 2;
    _currentActualIndex = _initialPage % _data.length;
    _currentVirtualPage = _initialPage;

    _pageController = PageController(
      viewportFraction: _currentViewportFraction,
      initialPage: _initialPage,
    );

    _pageController.addListener(_handlePageScroll);
    _startAutoScroll();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.2 &&
        _animationController.status == AnimationStatus.dismissed) {
      _animationController.forward();
    }
  }

  void _recreatePageController(double newFraction) {
    if (_currentViewportFraction == newFraction) return;

    final currentPage = _currentVirtualPage;

    _pageController.removeListener(_handlePageScroll);
    _pageController.dispose();

    _currentViewportFraction = newFraction;
    _pageController = PageController(
      viewportFraction: _currentViewportFraction,
      initialPage: currentPage,
    );
    _pageController.addListener(_handlePageScroll);
  }

  void _handlePageScroll() {
    if (!_pageController.hasClients || _pageController.page == null) return;

    if (_pageController.page! % 1.0 == 0) {
      final newVirtualPage = _pageController.page!.toInt();
      final newIndex = newVirtualPage % _data.length;

      if (_currentActualIndex != newIndex) {
        setState(() {
          _currentVirtualPage = newVirtualPage;
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

      int nextPage = (_pageController.page?.toInt() ?? _currentVirtualPage) + 1;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentVirtualPage = index;
      _currentActualIndex = index % _data.length;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.removeListener(_handlePageScroll);
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // --- INICIO DE LA CORRECCIÓN ---
    final double targetViewportFraction;

    if (isMobile) {
      // En mobile, mantenemos el 80% del ancho
      targetViewportFraction = 0.8;
    } else {
      // En desktop, calculamos la fracción basada en un ancho fijo
      const double fixedDesktopCardWidth = 300.0; // <<-- PUEDES AJUSTAR ESTE ANCHO FIJO
      const double horizontalPagePadding = 8.0 * 2; // El padding (8px) a cada lado
      final double totalPageWidth = fixedDesktopCardWidth + horizontalPagePadding;

      // Calculamos la fracción necesaria.
      // Usamos .clamp(0.0, 1.0) para evitar errores si la pantalla es más pequeña que la tarjeta
      targetViewportFraction = (totalPageWidth / screenWidth).clamp(0.0, 1.0);
    }
    // --- FIN DE LA CORRECCIÓN ---

    _recreatePageController(targetViewportFraction);

    return VisibilityDetector(
      key: const Key('testimonials-detector'),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _animation,
        child: Container(
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TESTIMONIOS',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              MouseRegion(
                cursor: SystemMouseCursors.grab,
                child: SizedBox(
                  height: 370,
                  // 4. APLICAR EL SCROLLBEHAVIOR SOLO A ESTE WIDGET
                  child: ScrollConfiguration(
                    behavior: MyCustomScrollBehavior(),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _infiniteCount,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        final actualDataIndex = index % _data.length;
                        final imagePath = _data[actualDataIndex];

                        // Eliminamos el SizedBox con ancho fijo
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: _TestimonialCard(
                            onHoverChange: _handleHoverChange,
                            imageUrl: imagePath,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _data.asMap().entries.map((entry) {
                  final index = entry.key;
                  return GestureDetector(
                    onTap: () {
                      final currentPage = _currentVirtualPage;
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
        ),
      ),
    );
  }
}

// Widget privado para la tarjeta de testimonio
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
      child: AnimatedPhysicalModel(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        elevation: _isHovering ? 12.0 : 4.0,
        color: Theme.of(context).cardTheme.color!,
        shadowColor: Colors.black,
        shape: BoxShape.rectangle,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 370, // Mantiene la altura fija
              width: double.infinity,
              child: Image.asset(
                widget.imageUrl,
                fit: BoxFit.contain, // Mantenemos .contain como pediste
              ),
            ),
          ],
        ),
      ),
    );
  }
}