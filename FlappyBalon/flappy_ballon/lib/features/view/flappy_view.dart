import 'package:flappy_ballon/features/view_models/flappy_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flappy_ballon/features/models/juego_estado_enum.dart';
import 'package:flutter/material.dart';

class FlappyView extends ConsumerWidget {
  const FlappyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final juegoEstado = ref.watch(juegoProvider);

    return Scaffold(
      backgroundColor: Colors.black, 
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Controlamos qué hace el toque según el momento del juego
            if (juegoEstado.stateGame == StateGame.menu) {
              ref.read(juegoProvider.notifier).iniciarJuego();
            } else if (juegoEstado.stateGame == StateGame.jugando) {
              ref.read(juegoProvider.notifier).saltar();
            } else if (juegoEstado.stateGame == StateGame.gameOver) {
              // Si perdió, llamamos al nuevo método de reinicio
              ref.read(juegoProvider.notifier).reiniciarJuego();
            }
          },
          child: Container(
            width: double.infinity,
            height: 600,
            color: Colors.green,
            child: Stack(
              children: [
                
                //1. PANTALLA DE MENÚ
                if (juegoEstado.stateGame == StateGame.menu)
                  const Center(
                    child: Text(
                      "Patea la pantalla para empezar",
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                //2. PANTALLA DE GAME OVER
                if (juegoEstado.stateGame == StateGame.gameOver)
                  const Center(
                    child: Text(
                      "Game Over\nToca para reiniciar el partido",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // PANTALLA DE VICTORIA
                if (juegoEstado.stateGame == StateGame.victoria)
                  const Center(
                    child: Text(
                      "¡GOOOL! \n¡Ganaste!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.yellow, 
                        fontSize: 26, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // PANTALLA DE JUEGO ACTIVO (Elementos físicos)
                if (juegoEstado.stateGame == StateGame.jugando) ...[
                  
                  // Posición de la pelota
                  Positioned(
                    left: 100,
                    top: juegoEstado.posicionY,
                    child: Container(
                      width: 30, 
                      height: 30, 
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // Posición de los obstáculos arriba
                  Positioned(
                    left: juegoEstado.movimientoObstaculoX,
                    top: 0,
                    child: Container(
                      width: 40,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),

                  // Posición de los obstáculos de abajo (Ajustado a 300)
                  Positioned(
                    left: juegoEstado.movimientoObstaculoX,
                    top: 300,
                    child: Container(
                      width: 40,
                      height: 300,
                      decoration: const BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}