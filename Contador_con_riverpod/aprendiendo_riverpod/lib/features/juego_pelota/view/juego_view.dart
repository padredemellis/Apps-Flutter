import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aprendiendo_riverpod/features/juego_pelota/view_models/juego_notifier.dart';

class JuegoView extends ConsumerWidget {
  const JuegoView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final estado = ref.watch(juegoProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dominadas: ${estado.toques}"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          if (estado.toques == 0 && estado.velocidadBalon == 0.0) {
            ref.read(juegoProvider.notifier).iniciarJuego();
          }
          ref.read(juegoProvider.notifier).darToque();
        },
        child: Container(
          color: Colors.lightBlueAccent,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
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
              Positioned(
                top: estado.posicionY,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: const Icon(
                  Icons.sports_soccer,
                  size: 50,
                  color: Colors.black87,
                ),
              ),
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
