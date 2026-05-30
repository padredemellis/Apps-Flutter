import 'dart:async';
import "package:flappy_ballon/features/models/flappy_estado.dart";
import 'package:flappy_ballon/features/models/juego_estado_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlappyNotifier extends Notifier<FlappyEstado> {
  Timer? _reloj;

  @override
  FlappyEstado build() {
    ref.onDispose(() => _reloj?.cancel());
    return FlappyEstado(
      posicionY: 100.0,
      velocidadBalonY: 0.0,
      alturaObstaculoY: 0.0,
      movimientoObstaculoX: 450.0,
      stateGame: StateGame.menu,
      marcador: 0,
    );
  }

  void iniciarJuego() {
    _reloj?.cancel();
    state = state.copyWith(stateGame: StateGame.jugando);
    _reloj = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _actualizarFisica();
    });
  }

  void _actualizarFisica() {
    final nuevaVelocidadBalon = state.velocidadBalonY + 0.4;
    final nuevaPosicionY = state.posicionY + nuevaVelocidadBalon;
    var nuevaPosicionObstaculo = state.movimientoObstaculoX - 1;
    var nuevoMarcador = state.marcador;
    final nuevaRotacion = state.rotacionBalon + 0.5;

    if (nuevaPosicionObstaculo <= 0) {
      nuevaPosicionObstaculo = 450.0;
      nuevoMarcador++;
    }
    if ((nuevaPosicionY <= 0) ||
        (nuevaPosicionY >= 600) ||
        (nuevaPosicionObstaculo <= 100 && nuevaPosicionObstaculo >= 60) &&
            (nuevaPosicionY <= 200 || nuevaPosicionY >= 300)) {
      gameOver();
      return;
    }
    if (nuevoMarcador == 5 && nuevaPosicionObstaculo <= 100){
      victoria();
      return;
    }
    state = state.copyWith(
      posicionY: nuevaPosicionY,
      velocidadBalonY: nuevaVelocidadBalon,
      movimientoObstaculoX: nuevaPosicionObstaculo,
      marcador: nuevoMarcador,
      rotacionBalon: nuevaRotacion,
    );
  }

  void saltar() {
    state = state.copyWith(velocidadBalonY: -10.0);
  }

  void gameOver() {
    state = state.copyWith(stateGame: StateGame.gameOver);
    _reloj?.cancel();
  }

  void victoria() {
    state = state.copyWith(stateGame: StateGame.victoria);
    _reloj?.cancel();
  }

  void reiniciarJuego(){
    _reloj?.cancel();
  // Devolvemos el estado a los valores del inicio, pero ya en modo jugando
    state = FlappyEstado(
      posicionY: 100.0,
      velocidadBalonY: 0.0,
      alturaObstaculoY: 0.0,
      movimientoObstaculoX: 450.0,
      stateGame: StateGame.jugando,
      marcador: 0,
      rotacionBalon: 0.0,
    );
  
  // Volvemos a arrancar el loop del motor
    _reloj = Timer.periodic(const Duration(milliseconds: 16), (timer) {
    _actualizarFisica();
    });
  }
}

final juegoProvider = NotifierProvider<FlappyNotifier, FlappyEstado>(
  () => FlappyNotifier(),
);
