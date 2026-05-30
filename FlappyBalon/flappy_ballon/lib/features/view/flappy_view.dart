import 'package:flappy_ballon/features/view_models/flappy_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flappy_ballon/features/models/juego_estado_enum.dart';
import 'package:flutter/material.dart';

class FlappyView extends ConsumerWidget {
  const FlappyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final juegoEstado = ref.watch(juegoProvider);
    final bool enMenu = juegoEstado.stateGame == StateGame.menu;

    return Scaffold(
      backgroundColor: const Color(0xFF0C0C0E),
      body: Center(
        child: GestureDetector(
          onTap: () {
            if (enMenu) {
              ref.read(juegoProvider.notifier).iniciarJuego();
            } else if (juegoEstado.stateGame == StateGame.jugando) {
              ref.read(juegoProvider.notifier).saltar();
            } else if (juegoEstado.stateGame == StateGame.gameOver) {
              ref.read(juegoProvider.notifier).reiniciarJuego();
            }
          },
          child: Container(
            width: double.infinity,
            height: 600,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 4,
              ), 
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green[400]!,
                  Colors.green[800]!,
                ],
              ),
            ),
            child: Stack(
              children: [
                if (enMenu)
                  Positioned(
                    top: 150,
                    left: 20,
                    right: 20,
                    child: Center(
                      child: Stack(
                        children: [
                          Text(
                            "🔥 PATEA PARA EMPEZAR 🔥",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.black,
                            ),
                          ),
                          const Text(
                            "🔥 PATEA PARA EMPEZAR 🔥",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                              color: Colors.yellow, 
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (juegoEstado.stateGame == StateGame.gameOver)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.redAccent, width: 4),
                      ),
                      child: const Text(
                        "💥 FIN DEL PARTIDO 💥\nToca para la revancha",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),

                if (juegoEstado.stateGame == StateGame.victoria)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.amber, width: 5),
                      ),
                      child: const Text(
                        "⚡ ¡GOOOOOOL! ⚡\n🏆 ¡CAMPEÓN DEL MUNDO! 🏆",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),

                if (juegoEstado.stateGame == StateGame.jugando) ...[
                  if (juegoEstado.marcador < 4) ...[
                    Positioned(
                      left: juegoEstado.movimientoObstaculoX,
                      top: 0,
                      child: Container(
                        width: 40,
                        height: 200,
                        color: Colors.transparent, // Contenedor estructural
                        child: Image.asset(
                          'assets/images/enemigo.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      left: juegoEstado.movimientoObstaculoX,
                      top: 300,
                      child: Container(
                        width: 40,
                        height: 300,
                        color: Colors.transparent,
                        child: Image.asset(
                          'assets/images/enemigo.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],

                  if (juegoEstado.marcador >= 4)
                    Positioned(
                      left: juegoEstado.movimientoObstaculoX,
                      top: 0,
                      child: Container(
                        width: 80,
                        height: 600,
                        color: Colors.transparent,
                        child: Image.asset(
                          'assets/images/arco.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                ],

                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOutBack,
                  left: enMenu ? 20 : 120,
                  top: enMenu ? 260 : 250,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: enMenu ? 1.0 : 0.0,
                    child: SizedBox(
                      width: 75,
                      height: 75,
                      child: Image.asset(
                        'assets/images/pie.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                if (juegoEstado.stateGame == StateGame.menu ||
                    juegoEstado.stateGame == StateGame.jugando)
                  Positioned(
                    left: 100,
                    top: enMenu ? 250 : juegoEstado.posicionY,
                    child: Transform.rotate(
                      angle: juegoEstado.rotacionBalon,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 4,
                              offset: Offset(2, 4),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/balon.png',
                          fit: BoxFit.contain,
                        ),
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
