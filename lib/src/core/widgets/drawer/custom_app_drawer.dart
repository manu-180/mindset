import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/features/landing/presentation/providers/landing_scroll_provider.dart';

// Cambiamos a ConsumerWidget
class CustomAppDrawer extends ConsumerWidget {
  const CustomAppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Leemos el Notifier para llamar a los métodos de scroll
    final notifier = ref.read(landingScrollProvider.notifier);
    // Leemos el estado para obtener las Keys
    final keys = ref.watch(landingScrollProvider);
    final textTheme = Theme.of(context).textTheme;

    // Función para manejar el tap: scrollear y cerrar el drawer
    void handleTap(GlobalKey key) {
      Navigator.of(context).pop(); // Cierra el drawer
      notifier.scrollToKey(key); // Llama al método de scroll
    }

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Menú',
                style: textTheme.headlineMedium,
              ),
            ),
          ),
          
          // --- Items de Navegación ---
          _DrawerItem(
            title: 'Inicio',
            icon: Icons.home_outlined,
            onTap: () => handleTap(keys.heroKey), // Conectado
          ),
          _DrawerItem(
            title: 'Sobre Mí',
            icon: Icons.person_outline,
            onTap: () => handleTap(keys.authorKey), // Conectado (Va a AboutAuthor)
          ),
          _DrawerItem(
            title: 'Planes',
            icon: Icons.fitness_center_outlined,
            onTap: () => handleTap(keys.plansKey), // Conectado
          ),
          _DrawerItem(
            title: 'Testimonios',
            icon: Icons.star_outline,
            onTap: () => handleTap(keys.testimonialsKey), // Conectado
          ),
        ],
      ),
    );
  }
}

// Widget privado para un item del drawer (modificado)
class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), // Añade espacio vertical
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: onTap,
        horizontalTitleGap: 20, // <-- AUMENTAMOS EL ESPACIO HORIZONTAL (ej: de 0 a 24)
      ),
    );
  }
}