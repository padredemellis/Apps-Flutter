import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aprendiendo_riverpod/features/contador/view_models/contador_notifier.dart';

/// Vista principal del contador.
///
/// Widget que muestra la interfaz del contador permitiendo al usuario
/// incrementar, decrementar y reiniciar el valor. Utiliza [ConsumerWidget]
/// para acceder al estado reactivo de Riverpod.
class ContadorView extends ConsumerWidget {
  /// Constructor const para [ContadorView].
  const ContadorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Observa el estado actual del contador mediante el provider.
    final provider = ref.watch(contadorProvider);
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("Contador"))),
      body: Center(
        child: Text(
          provider.contadorClicks != 0
              ? 'Clicks: ${provider.contadorClicks}'
              : 'Click: ${provider.contadorClicks}',
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),

      /// Columna de botones de acción flotantes con las operaciones del contador.
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          /// Botón para incrementar el contador.
          FloatingActionButton(
            onPressed: () => ref.read(contadorProvider.notifier).incrementar(),
            child: const Icon(Icons.plus_one),
          ),
          const SizedBox(height: 10),

          /// Botón para decrementar el contador.
          FloatingActionButton(
            onPressed: () => ref.read(contadorProvider.notifier).restar(),
            child: const Icon(Icons.exposure_minus_1_sharp),
          ),
          const SizedBox(height: 10),

          /// Botón para reiniciar el contador a 0.
          FloatingActionButton(
            onPressed: () => ref.read(contadorProvider.notifier).refescar(),
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
