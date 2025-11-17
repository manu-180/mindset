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
    required bool isDesktop, // <--- 1. Recibe el flag
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
      isDesktop: isDesktop, // <--- 2. Lo pasa a la tarjeta
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final List<String> monthlyFeatures = [
      ..._baseFeatures,
      'Acceso por 30 días.',
      'Comunidad limitada.'
    ];
    final List<String> quarterlyFeatures = [
      ..._baseFeatures,
      'Ahorro del 18% anual.',
      'Prioridad media en soporte.'
    ];
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

              // Definimos la lista de tarjetas aquí, pasando el flag
              final List<Widget> cards = [
                _buildCard(
                  ref: ref,
                  productId: 'mindset_monthly',
                  productName: 'Plan Mensual mindSET',
                  planName: 'PLAN MENSUAL mindSET',
                  price: '50 u\$d',
                  features: monthlyFeatures,
                  isDesktop: isDesktop,
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
                  isDesktop: isDesktop,
                ),
                _buildCard(
                  ref: ref,
                  productId: 'mindset_elite_monthly',
                  productName: 'Plan Mensual mindSET ELITE',
                  planName: 'PLAN MENSUAL mindSET ELITE',
                  price: '200 u\$d',
                  features: eliteFeatures,
                  isElite: true,
                  isDesktop: isDesktop,
                ),
              ];

              if (isDesktop) {
                // --- 3. SOLUCIÓN: IntrinsicHeight + Row + Stretch ---
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: cards[0],
                      ),
                      const SizedBox(width: 32.0),
                      Expanded(
                        flex: 1,
                        child: cards[1],
                      ),
                      const SizedBox(width: 32.0),
                      Expanded(
                        flex: 1,
                        child: cards[2],
                      ),
                    ],
                  ),
                );
              } else {
                // Layout Mobile (no necesita stretch)
                return Column(
                  children: cards
                      .map((card) => Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: card,
                          ))
                      .toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

// --- Widget reutilizable para la tarjeta de precios ---
class _PricingCard extends StatefulWidget {
  const _PricingCard({
    required this.planName,
    required this.price,
    required this.onPressed,
    required this.features,
    this.offerTitle,
    this.originalPrice,
    this.isElite = false,
    required this.isDesktop, // <--- Recibe el flag
  });

  final String? offerTitle;
  final String planName;
  final String price;
  final String? originalPrice;
  final List<String> features;
  final bool isElite;
  final VoidCallback onPressed;
  final bool isDesktop; // <--- Propiedad

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final accentColor =
        widget.isElite ? const Color(0xFFFFD600) : Theme.of(context).colorScheme.primary;
    final cardBaseColor = Theme.of(context).cardTheme.color!;

    final buttonFillColor = accentColor;
    final buttonBaseColor = cardBaseColor;

    final Color hoverBorderColor = widget.isElite
        ? const Color(0xFFFFD600)
        : const Color(0xFFE53935);
    final Color baseBorderColor =
        widget.isElite ? Colors.transparent : Colors.transparent;
    final Color borderColor = _isHovering ? hoverBorderColor : baseBorderColor;

    final double borderWidth = _isHovering
        ? (widget.isElite ? 3.0 : 1.0)
        : (widget.isElite ? 3.0 : 0.0);

    final Color hoverCardColor = widget.isElite
        ? const Color.fromRGBO(255, 214, 0, 0.10)
        : const Color.fromRGBO(229, 57, 53, 0.05);
    final Color cardColor = _isHovering ? hoverCardColor : cardBaseColor;

    final defaultTextColor = Colors.white;
    final hoverTextColor = widget.isElite ? Colors.black : Colors.white;
    final bulletFontWeight = widget.isElite ? FontWeight.bold : FontWeight.normal;

    // --- INICIO DE LA CORRECCIÓN ---
    // Envolvemos el MouseRegion en un GestureDetector
    // para capturar los eventos de toque (móvil)
    return GestureDetector(
      // Detecta el inicio del toque
      onTapDown: (_) {
        if (!_isHovering) {
          setState(() => _isHovering = true);
        }
      },
      // Detecta el fin del toque
      onTapUp: (_) {
        if (_isHovering) {
          setState(() => _isHovering = false);
        }
      },
      // Detecta si el toque se cancela (ej. al scrollear)
      onTapCancel: () {
        if (_isHovering) {
          setState(() => _isHovering = false);
        }
      },
      child: MouseRegion(
        // onEnter/onExit para el mouse (desktop)
        onEnter: (_) {
          if (!_isHovering) {
            setState(() => _isHovering = true);
          }
        },
        onExit: (_) {
          if (_isHovering) {
            setState(() => _isHovering = false);
          }
        },
        child: Card(
          color: cardColor,
          elevation: _isHovering ? 8 : 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: borderColor, width: borderWidth),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // 4. Quitamos 'mainAxisSize: MainAxisSize.min' para que el Spacer funcione
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
                const SizedBox(height: 16),

                // Lista de Features (Bullets)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.features
                      .map((feature) => _FeatureBullet(
                            text: feature,
                            color: accentColor,
                            fontWeight: bulletFontWeight,
                          ))
                      .toList(),
                ),

                // --- 5. Spacer condicional para alinear botones ---
                // Solo se añade en desktop (donde las alturas son iguales)
                if (widget.isDesktop) const Spacer(),

                // Espacio fijo para mobile (y padding inferior en desktop)
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
      ),
    );
    // --- FIN DE LA CORRECCIÓN ---
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