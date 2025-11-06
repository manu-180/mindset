import 'package:flutter/material.dart';

// Modelo simple para una pregunta frecuente
class _FaqItem {
  _FaqItem({required this.question, required this.answer});
  final String question;
  final String answer;
}

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  static final List<_FaqItem> _faqData = [
    _FaqItem(
      question: '¿Para quién es este producto?', //
      answer:
          'Dirigido a chicos con dificultades para ganar musculo y con baja autoestima.', //
    ),
    _FaqItem(
      question: '¿Cómo funciona el \'Plazo de Garantía\'?', //
      answer:
          'El Plazo de Garantía es el periodo que tienes para pedir el reembolso integral del valor de tu compra, en caso de que el producto no sea satisfactorio.', //
    ),
    _FaqItem(
      question: '¿Qué es y cómo funciona el Certificado de Conclusión digital?', //
      answer:
      // CORRECCIÓN DE TIPO: Usamos comillas triples para textos largos
          '''Algunos cursos online ofrecen un certificado digital de conclusión. Los alumnos pueden emitir este certificado dentro del curso o ponerse en contacto con el Autor o Autora. Estos certificados pueden compartirse en redes sociales como LinkedIn e incluirse en informaciones curriculares.''',
    ),
    _FaqItem(
      question: '¿Cómo acceder al producto?', //
      answer:
          'Recibirás el acceso por email. Podrás acceder al contenido o descargarlo en una computadora, smartphone, tablet u otro dispositivo digital.', //
    ),
    _FaqItem(
      question: '¿Cómo hago para comprar?', //
      answer:
          'Para comprar este curso, haz clic en el botón "Tomar accion ahora". Recuerda que no todos los productos estarán siempre disponibles para su compra. Es posible que haya ofertas por tiempo limitado.', //
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cardColor = Theme.of(context).cardTheme.color;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final borderRadius = BorderRadius.circular(8); // Radio para las tiles

    // 1. Padding exterior para el margen
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      
      // 2. Card para contener la sección
      child: Card(
        child: Padding(
          // 3. Padding interior para el contenido
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            // CORRECCIÓN: Alineamos los elementos a la izquierda para que el ExpansionTile
            // ocupe todo el ancho y no se centre por CrossAxisAlignment.center
            crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: [
              // --- Título ---
              Text(
                'PREGUNTAS FRECUENTES', //
                style: textTheme.headlineMedium,
                textAlign: TextAlign.center, // Mantener título centrado
              ),
              const SizedBox(height: 32),

              // --- Lista de Preguntas ---
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: Column(
                  children: _faqData.map((item) {
                    final index = _faqData.indexOf(item);
                    final isLast = index == _faqData.length - 1;

                    return Column(
                      children: [
                        
                        // CORRECCIÓN: Usamos un Material para forzar el recorte del splash
                        Material(
                          color: cardColor,
                          borderRadius: borderRadius,
                          clipBehavior: Clip.antiAlias, // ESTO ES CLAVE para cortar el ripple/splash
                          child: ExpansionTile(
                            // Eliminamos los colores aquí para que el Material se encargue
                            backgroundColor: cardColor, // Requerido por ExpansionTile
                            collapsedBackgroundColor: cardColor,
                            iconColor: primaryColor,
                            collapsedIconColor: primaryColor,
                            
                            // Quitamos ClipRRect aquí, Material ya lo hace
                            title: Text(
                              item.question,
                              style: textTheme.titleMedium,
                            ),
                            children: [
                              
                              Padding(
                                // CORRECCIÓN CLAVE: Ajuste el padding izquierdo de 16 a 24
                                // para alinear la respuesta con el texto de la pregunta.
                                padding: const EdgeInsets.fromLTRB(24, 0, 16, 20),
                                child: Align(
                                  alignment: Alignment.centerLeft, // Forzar la alineación a la izquierda
                                  child: Text(
                                    item.answer,
                                    style: textTheme.bodyLarge
                                        ?.copyWith(color: Colors.white70),
                                    textAlign: TextAlign.start, // Asegurar que el texto dentro del Align no se centre
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // 4. Añade espacio entre items, pero no después del último
                        if (!isLast) const SizedBox(height: 12.0),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}