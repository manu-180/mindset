import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/features/landing/domain/initiate_purchase_usecase.dart'; 
import 'package:mindset/src/core/utils/url_launcher_service.dart';
import 'package:mindset/src/core/widgets/buttons/hover_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 

class EliteProgramSection extends ConsumerWidget {
  const EliteProgramSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    
    // 1. Color de acento Elite (Dorado/Amarillo) para borde, título y estrellas
    const Color eliteAccentColor = Color(0xFFFFD600); 
    
    // 2. Color bordo opaco para el fondo del botón (el color que te gustó)
    const Color buttonBordoColor = Color(0xFF4A1414); 

    const includesFeatures = [
      'Mentoría personalizada conmigo (llamadas semanales 1 a 1)',
      'Plan de entrenamiento adaptado en tiempo real a tus objetivos, lesiones y estilo de vida.',
      'Guía nutricional estratégica, no una dieta, sino un sistema sostenible que se adapta a vos.',
      'Coaching mental y emocional para eliminar bloqueos, inseguridades y hábitos autodestructivos',
      'Seguimiento diario vía WhatsApp directo conmigo',
      'Acceso prioritario a los cupos trimestrales (no hay mas que 15 lugares los cuales se renuevan cada 3 meses)',
      'Revisión de progresos y ajustes constantes.',
    ];

    const forWhoFeatures = [
      'Para el que ya está harto de empezar y abandonar.',
      'Para el que no quiere excusas, quiere resultados.',
      'Para el que entiende que invertir en sí mismo es el paso más valiente hacia una vida distinta.',
    ];
    
    final initiatePurchase = ref.read(initiatePurchaseUseCaseProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      
      child: Card(
        // Borde dorado para el acento Elite
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: eliteAccentColor, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MindSET ELITE',
                style: textTheme.headlineLarge?.copyWith(
                  color: eliteAccentColor, // Título Dorado
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Mentoría 1 a 1 - Transformación Total con mindSET ELITE',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  children: [
                    const TextSpan(text: 'Esta no es una rutina más. Es una experiencia de transformación '),
                    TextSpan(
                      text: 'física, mental y emocional',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: ' diseñada exclusivamente para vos.'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'En mindSET ELITE, trabajamos vos y yo, codo a codo, en un proceso de alto nivel para construir la mejor versión de vos mismo. Este es un espacio privado, sin distracciones, donde el foco está 100% en tu evolución personal.',
                style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 32),
              Text(
                '¿Qué incluye esta experiencia 1 a 1?',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              ...includesFeatures.map((feature) => _FeatureListItem(text: feature)), 
              const SizedBox(height: 32),
              Text(
                '¿Para quién es esto?',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              // Estrellas de color Dorado/Amarillo
              ...forWhoFeatures.map((feature) => _FeatureListItem(
                    text: feature,
                    iconColor: eliteAccentColor, // Íconos dorados
                    icon: Icons.star_border,
                  )),
              const SizedBox(height: 32),
              Text(
                'Si querés una transformación real, esta es la forma. Y no lo vas a hacer solo.',
                style: textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Aplicá ahora y hablamos para ver si sos apto para esta mentoría.',
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),

              // --- CTA DE CONTACTO CON FONDO BORDO OPACO ---
              HoverButton(
                backgroundColor: buttonBordoColor, // Fondo Bordo Opaco
                onPressed: () {
                  initiatePurchase.execute(
                    productId: 'mindset_elite_mentory',
                    productName: 'Mentoría mindSET ELITE (Contacto)',
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'CLICKEA PARA CONTACTARME',
                      style: textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(width: 12),
                    // Ícono de WhatsApp blanco para contraste
                    // FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 20), 
                  ],
                ),
              ),
              // --- FIN CTA ---
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureListItem extends StatelessWidget {
  const _FeatureListItem({
    required this.text,
    this.icon = Icons.check_circle_outline,
    this.iconColor,
  });
  final String text;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            // Los checks estándar (no estrellas) usan el color primario de la app (rojo)
            color: iconColor ?? Theme.of(context).colorScheme.primary, 
            size: 24,
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}