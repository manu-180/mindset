// lib/src/features/landing/domain/initiate_purchase_usecase.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindset/src/features/landing/domain/purchase_repository.dart';
import 'package:mindset/src/features/landing/data/purchase_repository_impl.dart'; // Aún no existe, la crearemos en el siguiente paso

// Provider del Caso de Uso. Expone el método de negocio a la UI.
final initiatePurchaseUseCaseProvider = Provider<InitiatePurchaseUseCase>((ref) {
  // Aquí es donde inyectamos la implementación del Repositorio (la versión WhatsApp)
  final repository = ref.watch(purchaseRepositoryProvider);
  return InitiatePurchaseUseCase(repository);
});


/// [Use Case] Define la interacción del usuario con la lógica de negocio.
class InitiatePurchaseUseCase {
  final PurchaseRepository _repository;

  InitiatePurchaseUseCase(this._repository);

  /// Lógica de Negocio: Inicia el flujo de compra, delegando al Repositorio.
  Future<void> execute({
    required String productId,
    required String productName,
  }) async {
    // Aquí podrías agregar lógica pre-compra si fuera necesario (ej. registrar evento)
    await _repository.initiatePurchase(
      productId: productId,
      productName: productName,
    );
    // Aquí podrías agregar lógica post-compra (ej. mostrar un mensaje de éxito)
  }
}