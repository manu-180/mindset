import 'package:flutter/material.dart';

class GuaranteeSection extends StatelessWidget {
  const GuaranteeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // 1. Padding exterior para el margen
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      
      // 2. Card para contener la sección
      child: Card(
        child: Padding(
          // 3. Padding interior para el contenido
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- 3 Estrellas ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: colorScheme.primary, size: 40),
                  const SizedBox(width: 8),
                  Icon(Icons.star, color: colorScheme.primary, size: 48),
                  const SizedBox(width: 8),
                  Icon(Icons.star, color: colorScheme.primary, size: 40),
                ],
              ),
              const SizedBox(height: 16),
          
              // --- Título ---
              Text(
                'GARANTÍA', //
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
          
              // --- Subtítulo ---
              Text(
                'Garantía incondicional de 7 días', //
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
          
              // --- Descripción ---
              Text(
                'Tendrás tu dinero de vuelta sin preguntas hasta 7 días después de la compra.', //
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}