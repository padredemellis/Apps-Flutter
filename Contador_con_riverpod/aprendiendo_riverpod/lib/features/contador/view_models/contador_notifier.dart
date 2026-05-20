import 'package:aprendiendo_riverpod/features/contador/model/contador.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que gestiona la lógica del contador utilizando Riverpod.
///
/// Esta clase extiende [Notifier<Contador>] permitiendo notificar cambios
/// de estado a los widgets que escuchan el provider. Implementa las operaciones
/// básicas: incrementar, decrementar y reiniciar el contador.
class ContadorNotifier extends Notifier<Contador> {
  /// Inicializa el estado del contador.
  ///
  /// Retorna:
  /// - [Contador]: Una nueva instancia del contador iniciada en 0
  @override
  Contador build() {
    return Contador(0);
  }

  /// Incrementa el valor del contador en 1.
  ///
  /// Emite un nuevo estado con el valor aumentado, notificando
  /// a todos los widgets observadores del cambio.
  void incrementar() {
    state = Contador(state.contadorClicks + 1);
  }

  /// Decrementa el valor del contador en 1.
  ///
  /// Solo decrementa si el valor actual es mayor que 0,
  /// evitando que el contador sea negativo.
  void restar() {
    if (state.contadorClicks > 0) {
      state = Contador(state.contadorClicks - 1);
    }
  }

  /// Reinicia el contador a 0.
  ///
  /// Emite un nuevo estado con el valor resetado.
  void refescar() {
    state = Contador(0);
  }
}

/// Provider que instancia y gestiona el estado del contador.
///
/// Este provider permite a cualquier widget acceder y observar
/// los cambios del contador a través del estado reactivo de Riverpod.
final contadorProvider = NotifierProvider<ContadorNotifier, Contador>(
  () => ContadorNotifier(),
);
