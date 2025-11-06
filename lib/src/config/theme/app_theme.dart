import 'package:flutter/material.dart';

class AppTheme {
  // --- Colores ---
  static const Color _primary = Color(0xFFD50000); // Rojo intenso
  static const Color _background = Color(0xFF101010); // Negro/Gris muy oscuro
  static const Color _cardBackground = Color(0xFF1A1A1A); // Gris oscuro para tarjetas
  static const Color _onText = Colors.white;

  // --- Tema Oscuro ---
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Oxanium', // Fuente definida en pubspec.yaml

      // --- Colores ---
      scaffoldBackgroundColor: _background,
      primaryColor: _primary,
      colorScheme: const ColorScheme.dark(
        primary: _primary,
        onPrimary: _onText,
        secondary: _primary, // Usamos el mismo para secundario por ahora
        onSecondary: _onText,
        background: _background,
        onBackground: _onText,
        surface: _cardBackground, // Color de superficie para Cards, Dialogs, etc.
        onSurface: _onText,
        error: Colors.redAccent,
        onError: _onText,
      ),

      // --- Estilos de Componentes ---

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: _background,
        elevation: 0,
        centerTitle: true,
      ),

      // Botones
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: _onText,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Oxanium',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      // Tarjetas (Cards)
      // CORRECCIÓN FINAL: Usamos el constructor CardThemeData()
      cardTheme: CardThemeData( // <-- ¡Esta es la corrección canónica!
        color: _cardBackground,
        elevation: 4,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Campos de Texto
      inputDecorationTheme:  InputDecorationTheme(
        filled: true,
        fillColor: _cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: Colors.grey),
      ),

      // Textos
      textTheme: const TextTheme(
        // Títulos grandes (Ej: "mindSET")
        displayLarge: TextStyle(
            fontSize: 48, fontWeight: FontWeight.bold, color: _onText),
        displayMedium: TextStyle(
            fontSize: 40, fontWeight: FontWeight.bold, color: _onText),
        
        // Títulos de sección (Ej: "SOBRE EL CONTENIDO")
        headlineLarge: TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: _onText),
        headlineMedium: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: _onText),
        
        // Títulos de tarjeta (Ej: "MindSET ELITE")
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: _onText),
        
        // Cuerpo de texto
        bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: _onText),
        bodyMedium: TextStyle(fontSize: 14, height: 1.5, color: Colors.white70),
      ).apply(
        bodyColor: _onText,
        displayColor: _onText,
      ),
    );
  }
}