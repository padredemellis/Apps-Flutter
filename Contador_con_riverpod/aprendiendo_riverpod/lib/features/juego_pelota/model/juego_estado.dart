///Modelo del estado del juego
/// posicionY: Altura inicial en la pantalla
/// velocidadBalon: Velocidad en que se mueve la pelota
/// toques: Toques del player al balón
class JuegoEstado {
  final double posicionY;
  final double velocidadBalon;
  final int toques;

  JuegoEstado({
    this.posicionY = 100.0,
    this.velocidadBalon = 0.0,
    this.toques = 0,
  });
  JuegoEstado copyWith({
    double? posicionY,
    double? velocidadBalon,
    int? toques,
  }) {
    return JuegoEstado(
      posicionY: posicionY ?? this.posicionY,
      velocidadBalon: velocidadBalon ?? this.velocidadBalon,
      toques: toques ?? this.toques,
    );
  }
}
