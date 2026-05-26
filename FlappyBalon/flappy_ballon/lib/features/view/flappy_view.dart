import 'package:flappy_ballon/features/view_models/flappy_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class FlappyView extends ConsumerWidget {
  const FlappyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final juegoEstado = ref.watch(juegoProvider);
    return Scaffold(
      backgroundColor: Colors.black, //Pongo un fondo oscuro para que resalte la cancha 
      body: Center(
        child: GestureDetector(
            onTap: () {
              // Le avisamos al cerebro del juego que el usuario tocó la pantalla
              ref.read(juegoProvider.notifier).saltar();
            },
            child: Container(
            width: double.infinity,
            height: 600,
            color: Colors.green,
            child: Stack(
              children: [
                //Posicion de la pelota(el jugador)
                Positioned(
                  left: 100,
                  top: juegoEstado.posicionY,
                  child: Container(
                    width: 30, //ancho de la pelota,
                    height: 30, //Alto la pelota
                    decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle)
                  )
                ),
                //Posicion de los obstaculos arriba
                Positioned(
                  left: juegoEstado.movimientoObstaculoX,
                  top: 0,
                  child: Container(
                  width: 40,
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.rectangle
                  ),
                ),
                ),
                // Posicion de los obstaculos de abajo
                Positioned(
                  left: juegoEstado.movimientoObstaculoX,
                  top: 300,
                  child: Container(
                  width: 40,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.rectangle
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    }
}
