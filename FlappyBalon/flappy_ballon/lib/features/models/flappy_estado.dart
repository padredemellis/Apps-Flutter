import 'package:flappy_ballon/features/models/juego_estado_enum.dart';

///Esta clase representa el Estado del juego

class FlappyEstado {
  /// Posición vertical de la pelota en el eje Y.
  final double posicionY;

  /// Velocidad actual de la pelota en el eje Y (afectada por la gravedad).
  final double aceleracionBalonY;

  /// La altura central o el límite del hueco del obstáculo en el eje Y.
  final double alturaObstaculoY;

  /// La posición horizontal del obstáculo en el eje X (se reduce para moverlo a la izquierda).
  final double movimientoObstaculoX;

  /// El estado actual del flujo del juego (menu, jugando, gameOver).
  final StateGame stateGame;

  /// La cantidad de obstáculos que el jugador ha esquivado con éxito.
  final int marcador;

  FlappyEstado({
    this.posicionY = 100.0,
    this.aceleracionBalonY = 0.0,
    this.alturaObstaculoY = 0.0,
    this.movimientoObstaculoX = 0.0,
    this.stateGame = StateGame.menu,
    this.marcador = 0,
  });
  /// Crea una copia de un estado con los valores actualizados
  FlappyEstado copyWith({
    double? posicionY,
    double? aceleracionBalonY,
    double? alturaObstaculoY,
    double? movimientoObstaculoX,
    StateGame? stateGame,
    int? marcador,
  }) {
    return FlappyEstado(
      posicionY: posicionY ?? this.posicionY,
      aceleracionBalonY: aceleracionBalonY ?? this.aceleracionBalonY,
      alturaObstaculoY: alturaObstaculoY ?? this.alturaObstaculoY,
      movimientoObstaculoX: movimientoObstaculoX ?? this.movimientoObstaculoX,
      stateGame: stateGame ?? this.stateGame,
      marcador: marcador ?? this.marcador,
    );
  }
}
