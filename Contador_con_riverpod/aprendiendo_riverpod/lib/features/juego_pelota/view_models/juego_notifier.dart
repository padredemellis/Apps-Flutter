import 'dart:async';
import 'package:aprendiendo_riverpod/features/juego_pelota/model/juego_estado.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier que gestiona la lógica del juego de pelota.
///
/// Esta clase implementa la física y lógica del juego, incluyendo:
/// - Movimiento de la pelota con gravedad
/// - Detección de rebotes en el techo
/// - Detección de game over cuando la pelota cae al suelo
/// - Incremento de contador de toques
class JuegoNotifier extends Notifier<JuegoEstado> {
  /// Timer que ejecuta la actualización de física del juego.
  /// Se cancela cuando el juego termina o cuando el widget se desecha.
  Timer? _reloj;

  /// Inicializa el estado del juego.
  ///
  /// Configura el listener para cancelar el timer al descartar el notifier.
  /// Retorna:
  /// - [JuegoEstado]: Estado inicial con la pelota en el centro de la pantalla
  @override
  JuegoEstado build() {
    ref.onDispose(() => _reloj?.cancel());
    return JuegoEstado(posicionY: 350.0, velocidadBalon: 0.0, toques: 0);
  }

  /// Inicia el juego creando un timer periódico que actualiza la física.
  ///
  /// Cancela cualquier timer previo y limpia el mensaje de la pantalla.
  /// La actualización ocurre cada 16 milisegundos (aproximadamente 60 FPS).
  void iniciarJuego() {
    _reloj?.cancel();
    state = state.copyWith(mensaje: '');
    _reloj = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _actualizarFisica();
    });
  }

  /// Actualiza la física de la pelota en cada frame.
  ///
  /// Aplica gravedad (0.4 píxeles/frame²) y detecta:
  /// - Colisión con el techo (rebote)
  /// - Colisión con el suelo (game over)
  /// - Movimiento normal
  void _actualizarFisica() {
    /// Aumenta la velocidad por efecto de la gravedad.
    final nuevaVelocidad = state.velocidadBalon + 0.4;

    /// Calcula la nueva posición aplicando la velocidad.
    var nuevaPosicion = state.posicionY + nuevaVelocidad;

    /// Verifica si la pelota ha caído al suelo (game over).
    if (nuevaPosicion >= 350.0) {
      _reloj?.cancel();
      state = JuegoEstado(
        posicionY: 350.0,
        velocidadBalon: 0.0,
        toques: 0,
        mensaje: '¡Game Over! \nToca para reiniciar',
      );
      return;
    }

    /// Verifica si la pelota ha chocado con el techo y rebota.
    if (nuevaPosicion <= 56.0) {
      nuevaPosicion = 56.0;

      /// La velocidad de rebote se reduce al 70% (rebote elástico).
      final velocidadRebote = nuevaVelocidad * -0.7;

      state = state.copyWith(
        velocidadBalon: velocidadRebote,
        posicionY: nuevaPosicion,
      );
      return;
    }

    /// Actualización normal del estado durante el juego.
    state = state.copyWith(
      velocidadBalon: nuevaVelocidad,
      posicionY: nuevaPosicion,
    );
  }

  /// Registra un toque/dominada del jugador sobre la pelota.
  ///
  /// Impulsa la pelota hacia arriba con una velocidad inicial de -10.0
  /// e incrementa el contador de toques.
  void darToque() {
    state = state.copyWith(velocidadBalon: -10.0, toques: state.toques + 1);
  }
}

/// Provider que instancia y gestiona el estado del juego.
///
/// Este provider permite a cualquier widget acceder y observar
/// los cambios del juego a través del estado reactivo de Riverpod.
final juegoProvider = NotifierProvider<JuegoNotifier, JuegoEstado>(
  () => JuegoNotifier(),
);
