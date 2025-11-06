import 'package:flutter/material.dart';

/// Un botón envoltorio que añade un efecto de escalado (scale) y cambio
/// de color sutil al pasar el mouse por encima (hover).
class HoverButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double scaleFactor;

  const HoverButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.scaleFactor = 1.05, // 5% de escalado
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final originalStyle = Theme.of(context).filledButtonTheme.style;
    
    // Obtener el color base (ya no calculamos hoverColor)
    final Color buttonColor = widget.backgroundColor 
      ?? originalStyle?.backgroundColor?.resolve({}) 
      ?? Theme.of(context).colorScheme.primary;
    
    // El color de hover será el mismo color base, anulando el cambio
    final Color hoverColor = buttonColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedScale( // Animación de escalado (CONSERVAMOS ESTO)
        scale: _isHovering ? widget.scaleFactor : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: FilledButton(
          onPressed: widget.onPressed,
          // 1. Usamos el estilo original
          style: originalStyle?.copyWith(
            // 2. FORZAMOS A QUE AMBOS ESTADOS (HOVER Y NORMAL) USEN EL MISMO COLOR
            backgroundColor: MaterialStateProperty.all<Color>(
              buttonColor,
            ),
          ) ?? FilledButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}