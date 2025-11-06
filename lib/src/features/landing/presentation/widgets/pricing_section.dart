import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/features/landing/domain/initiate_purchase_usecase.dart';
import 'package:mindset/src/core/widgets/buttons/animated_purchase_button.dart';

class PricingSection extends ConsumerWidget {
  const PricingSection({super.key});

  final List<String> _baseFeatures = const [
    'Acceso Inmediato al programa completo.',
    'Soporte directo vía Email o Plataforma.',
    'Entrenamientos actualizados mensualmente.',
    'Material de Nutrición Digital.',
  ];

  Widget _buildCard({
      required WidgetRef ref,
      required String productId,
      required String productName,
      String? offerTitle,
      required String planName,
      required String price,
      String? originalPrice,
      required List<String> features,
      bool isElite = false,
  }) {
      final initiatePurchase = ref.read(initiatePurchaseUseCaseProvider);

      return _PricingCard(
          planName: planName,
          price: price,
          originalPrice: originalPrice,
          isElite: isElite,
          offerTitle: offerTitle,
          features: features,
          onPressed: () {
              initiatePurchase.execute(
                  productId: productId,
                  productName: productName,
              );
          },
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    
    final List<String> monthlyFeatures = [..._baseFeatures, 'Acceso por 30 días.', 'Comunidad limitada.'];
    final List<String> quarterlyFeatures = [..._baseFeatures, 'Ahorro del 18% anual.', 'Prioridad media en soporte.'];
    final List<String> eliteFeatures = [
      'Mentoría 1:1 por Zoom.',
      'Soporte 24/7 vía WhatsApp.',
      'Acceso a material premium exclusivo.',
      'Entrevista introductoria (Google meet)',
      'Asistencia Nutricional',
      'Corrección de Técnicas',
      'Basado en tu situación actual',
      'Orientado a tus objetivos',
    ];

    final List<Widget> cards = [
        _buildCard(
            ref: ref,
            productId: 'mindset_monthly',
            productName: 'Plan Mensual mindSET',
            planName: 'PLAN MENSUAL mindSET',
            price: '50 u\$d',
            features: monthlyFeatures,
        ),
        _buildCard(
            ref: ref,
            productId: 'mindset_quarterly',
            productName: 'Plan Trimestral mindSET (Oferta)',
            offerTitle: 'OFERTA 3 MESES',
            planName: 'por tiempo limitado',
            price: '115 u\$d',
            originalPrice: '140 u\$d',
            features: quarterlyFeatures,
        ),
        _buildCard(
            ref: ref,
            productId: 'mindset_elite_monthly',
            productName: 'Plan Mensual mindSET ELITE',
            planName: 'PLAN MENSUAL mindSET ELITE',
            price: '200 u\$d',
            features: eliteFeatures,
            isElite: true,
        ),
    ];


    return Container(
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
      child: Column(
        children: [
          Text(
            'NUESTROS PLANES',
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: 32),

          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;

              if (isDesktop) {
                // CORRECCIÓN: Aumentamos el childAspectRatio de 0.70 a 0.80 para reducir la altura de la card.
                return GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 24.0,
                  crossAxisSpacing: 32.0,
                  childAspectRatio: 0.80,
                  children: cards,
                );
              } else {
                return Column(
                  children: cards.map((card) => Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: card,
                  )).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
// --- Widget reutilizable para la tarjeta de precios (modificado para hover y espaciado) ---
class _PricingCard extends StatefulWidget {
  const _PricingCard({
    required this.planName,
    required this.price,
    required this.onPressed,
    required this.features,
    this.offerTitle,
    this.originalPrice,
    this.isElite = false,
  });

  final String? offerTitle;
  final String planName;
  final String price;
  final String? originalPrice;
  final List<String> features;
  final bool isElite;
  final VoidCallback onPressed;

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final accentColor = widget.isElite ? const Color(0xFFFFD600) : Theme.of(context).colorScheme.primary;
    final cardBaseColor = Theme.of(context).cardTheme.color!;

    final buttonFillColor = accentColor;
    final buttonBaseColor = cardBaseColor;

    // Define el color del borde y de fondo basado en si se está haciendo hover o si es la tarjeta Elite
    final Color hoverBorderColor = widget.isElite ? const Color(0xFFFFD600) : const Color(0xFFE53935); // Rojo sutil para el hover
    final Color baseBorderColor = widget.isElite ? Colors.transparent : Colors.transparent;
    final Color borderColor = _isHovering ? hoverBorderColor : baseBorderColor;
    
    // Lógica de grosor de borde: 3.0 para Elite (siempre), 1.0 en hover para no Elite.
    final double borderWidth = _isHovering
        ? (widget.isElite ? 3.0 : 1.0) // Reducción a 1.0 para no Elite en hover
        : (widget.isElite ? 3.0 : 0.0);
        
    // Color de fondo para el hover (Aumentamos opacidad del amarillo Elite a 0.10)
    final Color hoverCardColor = widget.isElite
        ? const Color.fromRGBO(255, 214, 0, 0.10) // Amarillo más notorio (10% de opacidad)
        : const Color.fromRGBO(229, 57, 53, 0.05); // Rojo/Bordo sutil (5% de opacidad)
    final Color cardColor = _isHovering ? hoverCardColor : cardBaseColor;


    final defaultTextColor = Colors.white;
    final hoverTextColor = widget.isElite ? Colors.black : Colors.white;
    final bulletFontWeight = widget.isElite ? FontWeight.bold : FontWeight.normal;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Card(
        color: cardColor, // Usamos el color de fondo dinámico
        elevation: _isHovering ? 8 : 4, // Aumentamos la elevación al hacer hover
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor, width: borderWidth), // Usamos el borde dinámico
        ),
        // REDUCCIÓN DE ESPACIO: Reducimos el padding vertical de 32.0 a 24.0
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.offerTitle != null)
                Text(
                  widget.offerTitle!,
                  style: textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              Text(
                widget.planName,
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              // REDUCCIÓN DE ESPACIO: Reducimos de 16 a 12
              const SizedBox(height: 12), 
              if (widget.originalPrice != null)
                Text(
                  widget.originalPrice!,
                  style: textTheme.displayMedium?.copyWith(
                    color: Colors.grey[600],
                    decoration: TextDecoration.lineThrough,
                  ),
                  textAlign: TextAlign.center,
                ),
              Text(
                widget.price,
                style: textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              // REDUCCIÓN DE ESPACIO: Reducimos de 24 a 16
              const SizedBox(height: 16), 

              // Lista de Features (Bullets)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.features.map((feature) => _FeatureBullet(
                  text: feature,
                  color: accentColor,
                  fontWeight: bulletFontWeight,
                )).toList(),
              ),

              const Spacer(),

              // REDUCCIÓN DE ESPACIO: Reducimos de 24 a 16
              const SizedBox(height: 16), 

              // Botón Animado
              Center(
                child: AnimatedPurchaseButton(
                  onPressed: widget.onPressed,
                  text: 'TOMAR ACCION AHORA',
                  baseColor: buttonBaseColor,
                  hoverColor: buttonFillColor,
                  textColor: defaultTextColor,
                  hoverTextColor: hoverTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget privado para un bullet point (sin cambios)
class _FeatureBullet extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;

  const _FeatureBullet({
    required this.text,
    required this.color,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6.0, right: 8.0),
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}