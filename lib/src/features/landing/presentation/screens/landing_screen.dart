import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importar Riverpod
import 'package:mindset/src/core/widgets/animations/fade_in_on_scroll.dart';
import 'package:mindset/src/core/widgets/app_bar/custom_app_bar.dart';
import 'package:mindset/src/core/widgets/drawer/custom_app_drawer.dart';
import 'package:mindset/src/features/landing/presentation/providers/landing_scroll_provider.dart'; // Importar el Provider
import 'package:mindset/src/features/landing/presentation/widgets/about_author_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/about_program_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/elite_program_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/faq_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/guarantee_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/hero_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/pricing_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/testimonials_section.dart';

// Cambiamos a ConsumerWidget
class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Leemos el estado para obtener todas las GlobalKeys
    final scrollKeys = ref.watch(landingScrollProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomAppDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            // Asignamos una GlobalKey al SingleChildScrollView
            // Esto es necesario para que Scrollable.ensureVisible funcione correctamente
            key: scrollKeys.heroKey, 
            child: Column(
              children: [
                // Sección 1: Hero (usa la misma key que el SingleChildScrollView)
                HeroSection(key: scrollKeys.heroKey),
                
                // Sección 2: About Program
                FadeInOnScroll(
                  child: AboutProgramSection(key: scrollKeys.aboutKey),
                ),
            
                // Sección 3: Elite Program
                FadeInOnScroll(
                  child: EliteProgramSection(key: scrollKeys.eliteKey),
                ),
            
                // Sección 4: About Author
                FadeInOnScroll(
                  child: AboutAuthorSection(key: scrollKeys.authorKey),
                ),
            
                // Sección 5: Pricing (Planes)
                FadeInOnScroll(
                  child: PricingSection(key: scrollKeys.plansKey),
                ),

                // Sección 6: Testimonials
                FadeInOnScroll(
                  child: TestimonialsSection(key: scrollKeys.testimonialsKey),
                ),
            
                // Sección 7: Guarantee
                // Esta sección y la FAQ no necesitan key si no se accede desde el menú
                FadeInOnScroll(
                  child: const GuaranteeSection(),
                ),
            
                // Sección 8: FAQ
                FadeInOnScroll(
                  child: const FaqSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}