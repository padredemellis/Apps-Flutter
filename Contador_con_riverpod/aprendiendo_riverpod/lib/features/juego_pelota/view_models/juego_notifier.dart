import 'dart:async';
import 'package:aprendiendo_riverpod/features/juego_pelota/model/juego_estado.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JuegoNotifier extends Notifier<JuegoEstado> {
  Timer? _reloj;
  @override
  JuegoEstado build() {
    ref.onDispose(() => _reloj?.cancel());
    return JuegoEstado(posicionY: 100.0, velocidadBalon: 0.0, toques: 0);
  }

  void iniciarJuego() {
    _reloj?.cancel();
    _reloj = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      _actualizarFisica();
    });
  }
  void _actualizarFisica(){
    
  }
}
