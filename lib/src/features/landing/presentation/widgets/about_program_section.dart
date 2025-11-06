import 'package:flutter/material.dart';

class AboutProgramSection extends StatelessWidget {
  const AboutProgramSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    const features = [
      'Plan de nutrición completo',
      'Rutina de entrenamiento personalizada',
      'Ajustes mensuales según tu progreso',
      'Comunidad de apoyo por WhatsApp',
    ];

    // 1. Padding exterior para dar margen a la tarjeta
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      
      // 2. Card para contener la sección
      child: Card(
        // El Card toma el estilo de AppTheme
        child: Padding(
          // 3. Padding interior para el contenido
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SOBRE EL CONTENIDO',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'MindSET',
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Con mi programa mindSET, descubrí cómo desarrollar músculo, aumentar tu autoestima y alcanzar un nivel de confianza que nunca antes habías experimentado. Sentite bien con vos mismo y descubrí tu mejor versión, tal como lo hice yo.',
                style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 32),
              Text(
                '¿Qué incluye mindSET?',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              ...features.map((feature) => _FeatureListItem(text: feature)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureListItem extends StatelessWidget {
  const _FeatureListItem({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Theme.of(context).colorScheme.primary,
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