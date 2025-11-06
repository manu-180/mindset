import 'package:flutter/material.dart';

// Definimos una altura mayor para el AppBar
const double _kCustomToolbarHeight = 100.0; // Altura base en 100.0

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: _kCustomToolbarHeight, // Aplicamos la nueva altura
      
      // Logo a la izquierda (CORRECCIÓN: Usamos un widget más grande en leading)
      leadingWidth: 110.0, // <-- AUMENTAMOS EL ANCHO PERMITIDO PARA EL LOGO
      leading: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0), 
        // 1. Envolvemos en un SizedBox para controlar el tamaño de la imagen
        child: SizedBox(
          width: 150.0, // Misma medida que leadingWidth
          height: _kCustomToolbarHeight,
          child: Image.asset(
            'assets/images/mindsetappbar.png',  
            fit: BoxFit.contain, // Mantiene la proporción
          ),
        ),
      ),
      
      // Botón de Menú a la derecha (Ajustamos el tamaño)
      actions: [
        IconButton(
          icon: const Icon(Icons.menu, size: 40), // Ícono un poco más grande
          onPressed: () {
            // Abre el Drawer (menú lateral)
            Scaffold.of(context).openEndDrawer();
          },
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  @override
  // 3. La altura preferida debe coincidir con la altura de la barra
  Size get preferredSize => const Size.fromHeight(_kCustomToolbarHeight);
}