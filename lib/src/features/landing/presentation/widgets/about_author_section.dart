import 'package:flutter/material.dart';
// Asegúrate que la importación de app_assets sea la correcta
import 'package:mindset/src/constants/app_assets.dart'; 

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
              const SizedBox(height: 20),

              Text(
                'Descubrí cómo transformé mi vida y mi cuerpo de flaco, frustrado y con una pesima autoestima a musculoso, estando orgulloso de ver en quien me transforme y con un autoestima que nunca crei posible. Se cómo puedo ayudarte a hacer lo mismi. Con una década de experiencia, sé exactamente cómo te sientes y sé cómo superar el dolor y la frustración. Te garantizo que puedo ayudarte a cambiar tu vida, al igual que lo hice con la mia.',
                style: textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
              const SizedBox(height: 32),

              // --- Grilla "Antes y Después" ---
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Mantiene 2 columnas
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  // --- INICIO DE LA CORRECCIÓN ---
                  // Asumimos que las imágenes son más altas que anchas (ej: ratio 3:4)
                  // (Ancho / Alto = 3 / 4 = 0.75). Ajusta este valor si es necesario.
                  childAspectRatio: 0.8, 
                  // --- FIN DE LA CORRECCIÓN ---
                ),
                itemCount: AppAssets.simonGridList.length, 
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      AppAssets.simonGridList[index], 
                      // --- INICIO DE LA CORRECCIÓN ---
                      // Quitamos la altura fija (height: 180) que causaba el overflow
                      fit: BoxFit.cover, 
                      // --- FIN DE LA CORRECCIÓN ---
                    ),
                  );
                },
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