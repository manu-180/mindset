import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/core/utils/url_launcher_service.dart';
import 'package:mindset/src/core/widgets/buttons/hover_button.dart';
import 'package:mindset/src/features/landing/domain/initiate_purchase_usecase.dart';
import 'package:mindset/src/features/landing/presentation/providers/landing_scroll_provider.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final height = size.height > 700 ? size.height : 700.0;
    
    // Ancho de corte para cambiar de columna a fila (ej: 800 pixeles)
    final isLargeScreen = size.width > 800;
    
    // Lógica del botón: scrollear a Planes (PricingSection)
    final scrollNotifier = ref.read(landingScrollProvider.notifier);
    final plansKey = ref.watch(landingScrollProvider).plansKey;

    final VoidCallback scrollToAction = () {
      scrollNotifier.scrollToKey(plansKey);
    };

    return Container(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          const _BackgroundImage(),
          const _BlackGradient(),
          
          // Contenido adaptativo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: isLargeScreen
                ? _HeroContentDesktop(onScrollToPlans: scrollToAction) // Desktop (Row)
                : _HeroContentMobile(onScrollToPlans: scrollToAction), // Mobile (Column)
          ),
        ],
      ),
    );
  }
}

// --- Widgets privados para organizar el Stack ---

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    // TODO: Reemplazar este Container con tu Image.asset o Image.network
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor, 
      // El Center(child: Icon(...)) ha sido eliminado
    );
  }
}

class _BlackGradient extends StatelessWidget {
  const _BlackGradient();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.4),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }
}

// --- Layout de Columna (Móvil/Default) ---
class _HeroContentMobile extends StatelessWidget {
  const _HeroContentMobile({required this.onScrollToPlans});
  final VoidCallback onScrollToPlans;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: kToolbarHeight + 20),

        // Logo
        Container(
          width: 300, 
          height: 200, 
          child: Image.asset(
            'assets/images/mindsetlogo.png', 
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 24),

        // Headline
        Text(
          'mindSET: Transforma tu cuerpo y tu mente para siempre',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(
            shadows: [const Shadow(blurRadius: 10, color: Colors.black54)],
          ),
        ),
        const SizedBox(height: 16),
        // Sub-headline
        Text(
          'Creemos el cuerpo que siempre soñaste, desarrolla confianza en vos mismo y aumenta tu autoestima a niveles inimaginables. Descubrí una nueva versión de vos mismo que jamás pensaste posible.',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            shadows: [const Shadow(blurRadius: 8, color: Colors.black87)],
          ),
        ),
        const SizedBox(height: 32),
        // CTA Button
        FilledButton(
          onPressed: onScrollToPlans, // Llamada al scroll
          child: const Text('TOMAR ACCION AHORA'),
        ),
        const Spacer(),
      ],
    );
  }
}

// --- Layout de Fila (Desktop/Ancho) ---
class _HeroContentDesktop extends StatelessWidget {
  const _HeroContentDesktop({required this.onScrollToPlans});
  final VoidCallback onScrollToPlans;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Columna 1: Logo Grande (AUMENTAMOS FLEX PARA DAR MÁS ESPACIO)
        Expanded(
          flex:3, // Incrementado de 5 a 6
          child: SizedBox(
            height: size.height * 0.7,
            child: Center(
              child: Container(
                width: 400,
                height: 300,
                child: Image.asset(
                  'assets/images/mindsetlogo.png', 
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),

        // 1. Separador horizontal invisible para empujar el texto a la derecha
        const SizedBox(width: 20), 

        // Columna 2: Texto y Botón (REDUCIMOS FLEX)
        Expanded(
          flex: 3, // Reducido de 4 a 3
          child: Column(
            // 1. Usamos Spacers para centrado vertical en la columna de texto
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kToolbarHeight), // Espacio para el AppBar
              
              // Headline
              Text(
                'mindSET: Transforma tu cuerpo y tu mente para siempre',
                textAlign: TextAlign.left,
                style: textTheme.headlineLarge?.copyWith(
                  shadows: [const Shadow(blurRadius: 10, color: Colors.black54)],
                ),
              ),
              const SizedBox(height: 20),
              // Sub-headline
              Text(
                'Creemos el cuerpo que siempre soñaste, desarrolla confianza en vos mismo y aumenta tu autoestima a niveles inimaginables. Descubrí una nueva versión de vos mismo que jamás pensaste posible.',
                textAlign: TextAlign.left,
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  shadows: [const Shadow(blurRadius: 8, color: Colors.black87)],
                ),
              ),
              const SizedBox(height: 40),
              // CTA Button
              HoverButton(child: const Text('TOMAR ACCION AHORA'), onPressed: onScrollToPlans),
          
            ],
          ),
        ),
      ],
    );
  }
}