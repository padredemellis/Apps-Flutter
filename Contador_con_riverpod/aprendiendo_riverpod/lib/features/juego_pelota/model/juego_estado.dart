///Modelo del estado del juego
/// posicionY: Altura inicial en la pantalla
/// velocidadBalon: Velocidad en que se mueve la pelota
/// toques: Toques del player al balón
class JuegoEstado {
  final double posicionY;
  final double velocidadBalon;
  final int toques;
  final String mensaje;

  JuegoEstado({
    this.posicionY = 100.0,
    this.velocidadBalon = 0.0,
    this.toques = 0,
    this.mensaje = 'Toca para empezar'
  });
  JuegoEstado copyWith({
    double? posicionY,
    double? velocidadBalon,
    int? toques,
    String? mensaje
  }) {
    return JuegoEstado(
      posicionY: posicionY ?? this.posicionY,
      velocidadBalon: velocidadBalon ?? this.velocidadBalon,
      toques: toques ?? this.toques,
      mensaje: mensaje ?? this.mensaje,
    );
  }
}
