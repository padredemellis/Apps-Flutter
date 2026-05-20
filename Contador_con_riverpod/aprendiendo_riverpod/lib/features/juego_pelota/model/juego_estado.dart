/// Modelo que representa el estado completo del juego de pelota.
///
/// Encapsula toda la información necesaria para representar el estado
/// actual del juego, incluyendo la posición de la pelota, velocidad,
/// cantidad de toques y mensajes para el usuario.
class JuegoEstado {
  /// Posición vertical (Y) de la pelota en la pantalla.
  /// Valores más altos indican posiciones más bajas en la pantalla.
  final double posicionY;

  /// Velocidad actual de la pelota (en píxeles por frame).
  /// Valores positivos significan movimiento hacia abajo,
  /// valores negativos hacia arriba.
  final double velocidadBalon;

  /// Número total de toques/dominadas realizadas por el jugador.
  final int toques;

  /// Mensaje a mostrar al usuario (ej: instrucciones iniciales, game over).
  final String mensaje;

  /// Constructor que inicializa el estado del juego.
  ///
  /// Parámetros:
  /// - [posicionY]: Altura inicial (por defecto 100.0)
  /// - [velocidadBalon]: Velocidad inicial (por defecto 0.0)
  /// - [toques]: Toques iniciales (por defecto 0)
  /// - [mensaje]: Mensaje inicial (por defecto 'Toca para empezar')
  JuegoEstado({
    this.posicionY = 100.0,
    this.velocidadBalon = 0.0,
    this.toques = 0,
    this.mensaje = 'Toca para empezar',
  });

  /// Crea una copia de este estado con los valores actualizados.
  ///
  /// Permite crear un nuevo estado preservando los valores no especificados.
  /// Útil para actualizar solo ciertos campos del estado.
  ///
  /// Parámetros:
  /// - [posicionY]: Nueva posición Y (opcional)
  /// - [velocidadBalon]: Nueva velocidad (opcional)
  /// - [toques]: Nuevo conteo de toques (opcional)
  /// - [mensaje]: Nuevo mensaje (opcional)
  ///
  /// Retorna:
  /// - [JuegoEstado]: Nueva instancia con los valores actualizados
  JuegoEstado copyWith({
    double? posicionY,
    double? velocidadBalon,
    int? toques,
    String? mensaje,
  }) {
    return JuegoEstado(
      posicionY: posicionY ?? this.posicionY,
      velocidadBalon: velocidadBalon ?? this.velocidadBalon,
      toques: toques ?? this.toques,
      mensaje: mensaje ?? this.mensaje,
    );
  }
}
