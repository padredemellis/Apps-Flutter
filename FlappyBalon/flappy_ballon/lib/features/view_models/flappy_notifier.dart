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
      aceleracionBalonY: 0.0,
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
    final nuevaVelocidadBalon = state.aceleracionBalonY + 0.4;
    final nuevaPosicionY = state.posicionY + nuevaVelocidadBalon;
    var nuevaPosicionObstaculo = state.movimientoObstaculoX - 1;
    var nuevoMarcador = state.marcador;

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
    state = state.copyWith(
      posicionY: nuevaPosicionY,
      aceleracionBalonY: nuevaVelocidadBalon,
      movimientoObstaculoX: nuevaPosicionObstaculo,
      marcador: nuevoMarcador,
    );
  }

  void saltar() {
    state = state.copyWith(aceleracionBalonY: -10.0);
  }

  void gameOver() {
    state = state.copyWith(stateGame: StateGame.gameOver);
    _reloj?.cancel();
  }
}
final juegoProvider = NotifierProvider<FlappyNotifier,FlappyEstado>(()=> FlappyNotifier());
