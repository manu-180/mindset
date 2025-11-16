import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/core/widgets/animations/fade_in_on_scroll.dart';
import 'package:mindset/src/core/widgets/app_bar/custom_app_bar.dart';
import 'package:mindset/src/core/widgets/drawer/custom_app_drawer.dart';
import 'package:mindset/src/features/landing/presentation/providers/landing_scroll_provider.dart';
import 'package:mindset/src/features/landing/presentation/widgets/about_author_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/about_program_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/elite_program_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/faq_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/guarantee_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/hero_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/pricing_section.dart';
import 'package:mindset/src/features/landing/presentation/widgets/testimonials_section.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext, WidgetRef ref) {
    final scrollKeys = ref.watch(landingScrollProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomAppDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            key: scrollKeys.heroKey, // <-- USO 1 (Correcto, se queda aquí)
            child: Column(
              children: [
                // --- INICIO DE LA CORRECCIÓN ---
                // Se elimina la clave de aquí para evitar el error.
                const HeroSection(),
                // --- FIN DE LA CORRECCIÓN ---

                FadeInOnScroll(
                  child: AboutProgramSection(key: scrollKeys.aboutKey),
                ),

                FadeInOnScroll(
                  child: EliteProgramSection(key: scrollKeys.eliteKey),
                ),

                FadeInOnScroll(
                  child: AboutAuthorSection(key: scrollKeys.authorKey),
                ),

                FadeInOnScroll(
                  child: PricingSection(key: scrollKeys.plansKey),
                ),

                // --- INICIO DE LA CORRECCIÓN ---
                // Eliminamos el FadeInOnScroll que envolvía a TestimonialsSection.
                // La animación ahora se maneja internamente en TestimonialsSection
                // usando visibility_detector para evitar el error de layout.
                TestimonialsSection(key: scrollKeys.testimonialsKey),
                // --- FIN DE LA CORREGCCIÓN ---

                FadeInOnScroll(
                  child: const GuaranteeSection(),
                ),

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