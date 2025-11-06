import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart'; // Asegúrate de que este import está correcto

// 1. Provider para exponer el servicio a la UI
final urlLauncherServiceProvider = Provider((ref) {
  return UrlLauncherService();
});

// 2. Clase del servicio
class UrlLauncherService {
  /// Lanza una URL genérica (web, mail, etc.)
  Future<void> launch(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      // Manejar el error, ej: mostrar un SnackBar
      debugPrint('No se pudo lanzar $url');
    }
  }

  /// Lanza un chat de WhatsApp al número especificado
  Future<void> launchWhatsApp(String phoneNumber, [String? message]) async {
    // El número de teléfono constante (usamos el parámetro para el mensaje)
    const String number = '+541133307986'; 
    
    // Construye el link usando la clase correcta: WhatsAppUnilink
    final link = WhatsAppUnilink( // <-- CORRECCIÓN: Usar WhatsAppUnilink
      phoneNumber: number,
      // Usamos el 'message' que nos pasa el Caso de Uso, si existe.
      text: message ?? 'Hola, quiero más información sobre los programas mindSET.', 
    );

    // Lanza la URL
    await launch(link.toString());
  }
}