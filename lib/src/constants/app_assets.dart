class AppAssets {
  // Private constructor
  AppAssets._();

  // Base path
  static const String _basePath = 'assets/testimonios/';

  // --- Author Images ---
  // Asumo que 'simon1' es la principal y las 4 son para la grilla.
  // Ajusta la extensión (.jpg, .png, etc.) si es necesario.
  static const String simonPrincipal = '${_basePath}simon1.jpg';
  static const String simonGrid1 = '${_basePath}simon1.jpg';
  static const String simonGrid2 = '${_basePath}simon2.jpg';
  static const String simonGrid3 = '${_basePath}simon3.jpg';
  static const String simonGrid4 = '${_basePath}simon4.jpg';

  /// Lista ordenada para la grilla
  static const List<String> simonGridList = [
    simonGrid1,
    simonGrid2,
    simonGrid3,
    simonGrid4,
  ];

  // --- Testimonial Images ---
  static const String testimonio1 = '${_basePath}testimonio1.jpg';
  static const String testimonio2 = '${_basePath}testimonio2.jpg';
  static const String testimonio3 = '${_basePath}testimonio3.jpg';

  /// Lista ordenada para el carrusel de testimonios
  static const List<String> testimonialList = [
    testimonio1,
    testimonio2,
    testimonio3,
  ];
}