// lib/src/features/landing/data/purchase_repository_impl.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/core/utils/url_launcher_service.dart';
import 'package:mindset/src/features/landing/domain/purchase_repository.dart';

// El número de WhatsApp que está en la UI
const String _whatsAppNumber = '+541133307986';

// 1. Provider para inyectar esta implementación específica
final purchaseRepositoryProvider = Provider<PurchaseRepository>((ref) {
  final urlLauncher = ref.watch(urlLauncherServiceProvider);
  // Le pasamos el servicio que usaremos para la acción de "compra"
  return WhatsAppPurchaseRepository(urlLauncher);
});

// 2. Implementación del Repositorio para el Paso 1 (WhatsApp)
class WhatsAppPurchaseRepository implements PurchaseRepository {
  final UrlLauncherService _urlLauncher;

  WhatsAppPurchaseRepository(this._urlLauncher);

  @override
  Future<void> initiatePurchase({
    required String productId,
    required String productName,
  }) async {
    // 3. Lógica de "compra" para el Paso 1: Lanzar WhatsApp
    final message = 
        'Hola, estoy interesado en el plan $productName. ¿Podemos hablar? (ID: $productId)';
        
    await _urlLauncher.launchWhatsApp(_whatsAppNumber, message);
  }
}