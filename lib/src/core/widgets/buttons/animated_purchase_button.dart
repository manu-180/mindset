import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AnimatedPurchaseButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color baseColor; 
  final Color hoverColor; 
  final Color textColor; // Color de texto en estado normal (Ej: Blanco)
  final Color hoverTextColor; // <-- NUEVO: Color de texto en estado hover (Ej: Negro)

  const AnimatedPurchaseButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.baseColor,
    required this.hoverColor,
    required this.textColor,
    required this.hoverTextColor, // <-- NUEVO
  });

  @override
  State<AnimatedPurchaseButton> createState() => _AnimatedPurchaseButtonState();
}

class _AnimatedPurchaseButtonState extends State<AnimatedPurchaseButton> {
  bool _isHovering = false;
  static const double _buttonHeight = 50.0;
  static const double _buttonWidth = 250.0; 

  @override
  Widget build(BuildContext context) {
    // Usamos Shortcuts/Actions para accesibilidad (Enter key)
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
      },
      child: Actions(
        actions: {
          ActivateIntent: CallbackAction<Intent>(
            onInvoke: (_) {
              widget.onPressed();
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovering = true),
            onExit: (_) => setState(() => _isHovering = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _buttonWidth,
              height: _buttonHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.baseColor,
              ),
              child: Stack(
                children: [
                  // 1. Capa de Llenado Animado 
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _isHovering ? _buttonWidth : 0, 
                    height: _buttonHeight,
                    decoration: BoxDecoration(
                      color: widget.hoverColor, 
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  
                  // 2. Botón Transparente (superpuesto para recibir clics)
                  SizedBox(
                    width: _buttonWidth,
                    height: _buttonHeight,
                    child: ElevatedButton(
                      onPressed: widget.onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, 
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: widget.hoverColor, 
                            width: 1.0
                          ),
                        ),
                      ),
                      child: AnimatedDefaultTextStyle( // <-- CAMBIO: Animación de texto
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          color: _isHovering ? widget.hoverTextColor : widget.textColor, // <-- Color dinámico
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oxanium',
                        ),
                        child: Text(
                          widget.text,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}