// lib/src/features/landing/domain/purchase_repository.dart

/// Contrato (Abstract Class) de lo que debe hacer cualquier
/// implementación de un Repositorio de Compras.
abstract class PurchaseRepository {
  /// Inicia el flujo de compra para un producto específico.
  ///
  /// La implementación puede ser:
  /// 1. Lanzar WhatsApp (Paso 1)
  /// 2. Lanzar Stripe Checkout (Paso 2)
  Future<void> initiatePurchase({
    required String productId,
    required String productName,
  });
}