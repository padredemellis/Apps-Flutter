/// Modelo que representa el estado de un contador.
///
/// Esta clase encapsula el número de clicks/toques realizados,
/// proporcionando acceso controlado a través de getter.
///
/// Atributos:
/// - [_contadorClicks]: Número de clicks registrados, por defecto es 0
class Contador {
  /// Almacena el número total de clicks realizados.
  /// Es privado para encapsular el estado.
  final int _contadorClicks;

  /// Constructor que inicializa el contador con un valor.
  ///
  /// El parámetro [_contadorClicks] es opcional y por defecto es 0.
  Contador([this._contadorClicks = 0]);

  /// Getter que devuelve el número actual de clicks.
  ///
  /// Retorna:
  /// - [int]: El valor actual del contador de clicks
  int get contadorClicks => _contadorClicks;
}
