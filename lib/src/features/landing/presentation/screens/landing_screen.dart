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
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollKeys = ref.watch(landingScrollProvider);

    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomAppDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            // 1. Quitar la clave de aquí
            // key: scrollKeys.heroKey, 
            child: Column(
              children: [
                // 2. Poner la clave aquí
                HeroSection(key: scrollKeys.heroKey), 
                
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

                TestimonialsSection(key: scrollKeys.testimonialsKey),
                
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