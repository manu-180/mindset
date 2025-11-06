import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

/// Un widget que envuelve a su [child] con una animación
/// de FadeIn + Sutil SlideUp cuando aparece.
class FadeInOnScroll extends StatelessWidget {
  const FadeInOnScroll({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  });

  final Widget child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    // Usamos FadeInUp del paquete animate_do
    return FadeInUp(
      duration: duration,
      delay: const Duration(milliseconds: 100), // Un pequeño delay
      from: 30, // Empieza 30px más abajo
      child: child,
    );
  }
}