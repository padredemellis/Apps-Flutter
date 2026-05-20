import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aprendiendo_riverpod/features/juego_pelota/view_models/juego_notifier.dart';

/// Vista principal del juego de pelota.
///
/// Widget que renderiza la interfaz del juego, incluyendo:
/// - Área de juego (cielo) en color azul claro
/// - Área de terreno en color verde
/// - Pelota (icono de fútbol) que se mueve con física
/// - Detección de toques para impulsar la pelota
/// - Mostrador de dominadas en la barra superior
///
/// El juego finaliza cuando la pelota cae al suelo.
class JuegoView extends ConsumerWidget {
  /// Constructor const para [JuegoView].
  const JuegoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Observa el estado actual del juego.
    final estado = ref.watch(juegoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dominadas: ${estado.toques}"),
        centerTitle: true,
      ),

      /// Área interactiva que detecta toques del usuario.
      body: GestureDetector(
        onTap: () {
          /// Inicia el juego en el primer toque (cuando toques == 0 y velocidad == 0).
          if (estado.toques == 0 && estado.velocidadBalon == 0.0) {
            ref.read(juegoProvider.notifier).iniciarJuego();
          }

          /// Registra cada toque en la pelota.
          ref.read(juegoProvider.notifier).darToque();
        },
        child: Container(
          color: Colors.lightBlueAccent,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              /// Área de terreno (suelo) en la parte inferior.
              Positioned(
                top: 400.0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    border: Border(
                      top: BorderSide(color: Colors.white, width: 4),
                    ),
                  ),
                ),
              ),

              /// Pelota animada que se mueve según la física del juego.
              Positioned(
                top: estado.posicionY,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: const Icon(
                  Icons.sports_soccer,
                  size: 50,
                  color: Colors.black87,
                ),
              ),

              /// Mensaje del juego (instrucciones iniciales o game over).
              if (estado.mensaje.isNotEmpty)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      estado.mensaje,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
