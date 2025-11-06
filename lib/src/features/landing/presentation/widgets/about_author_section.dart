import 'package:flutter/material.dart';

class AboutAuthorSection extends StatelessWidget {
  const AboutAuthorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONOCE MEJOR A QUIEN HA CREADO EL CONTENIDO',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Simon Costa',
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: 24),

              // --- Placeholder para la imagen principal (Simon Costa) ---
              // TODO: Reemplazar con la imagen de Simon Costa (1000150268.jpg)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  color: Colors.grey[800],
                  child: Center(
                    child: Icon(Icons.fitness_center_outlined, size: 100, color: Colors.grey[600]),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- Texto biográfico (1ra parte) ---
              Text(
                'Descubrí cómo transformé mi vida y mi cuerpo de flaco, frustrado y con una pesima autoestima a musculoso, estando orgulloso de ver en quien me transforme y con un autoestima que nunca crei posible. Se cómo puedo ayudarte a hacer lo mismo. Con una década de experiencia, sé exactamente cómo te sientes y sé cómo superar el dolor y la frustración. Te garantizo que puedo ayudarte a cambiar tu vida, al igual que lo hice con la mia.',
                style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 32),

              // --- Placeholder para la grilla "Antes y Después" ---
              // TODO: Reemplazar con las 4 imágenes (1000150269.jpg)
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children: List.generate(
                  4,
                  (index) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 180,
                      color: Colors.grey[800],
                      child: Center(
                        child: Icon(Icons.photo_library_outlined, size: 50, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // --- Texto biográfico (2da parte) ---
              Text(
                'De estar perdido, a encontrarme en mí mismo.',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Antes de lograr este cambio físico, había algo que me pesaba mucho más que el cuerpo: la falta de confianza, el no sentirme cómodo conmigo mismo, el estar constantemente comparándome con los demás.\n\nProbé mil rutinas, dietas, suplementos, motivación de Instagram... pero siempre volvía al mismo lugar. Hasta que entendí que el cambio real no empieza en el cuerpo, empieza en la cabeza.\n\nAtrás nació mindSET. Primero fue para mí. Fue mi forma de salir del pozo, de aprender a entrenar con propósito, a comer sin castigarme, a dejar de buscar validación afuera y empezar a construirme desde adentro.\n\nEste cambio no es solo físico. Es mental, emocional, personal. Y ahora quiero ayudarte a que vos también lo logres',
                style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}