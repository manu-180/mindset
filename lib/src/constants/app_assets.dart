class AppAssets {
  // Private constructor
  AppAssets._();

  // Base path
  static const String _basePath = 'assets/testimonios/';

  // --- Author Images ---
  // CORRECCIÓN: Cambiado a .JPG
  static const String simonGrid1 = '${_basePath}simon1.png';
  static const String simonGrid2 = '${_basePath}simon2.png';
  static const String simonGrid3 = '${_basePath}simon3.png';
  static const String simonGrid4 = '${_basePath}simon4.png';

  /// Lista ordenada para la grilla
  static const List<String> simonGridList = [
    simonGrid1,
    simonGrid2,
    simonGrid3,
    simonGrid4,
  ];

  // --- Testimonial Images ---
  // CORRECCIÓN: Cambiado a .JPG
  static const String testimonio1 = '${_basePath}testimonio1.JPG';
  static const String testimonio2 = '${_basePath}testimonio2.JPG';
  static const String testimonio3 = '${_basePath}testimonio3.JPG';

  /// Lista ordenada para el carrusel de testimonios
  static const List<String> testimonialList = [
    testimonio1,
    testimonio2,
    testimonio3,
  ];
}