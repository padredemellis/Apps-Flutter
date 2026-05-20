import 'package:aprendiendo_riverpod/features/contador/model/contador.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
///ContadorNotifier hereda de Notifier<Contador> para poder emitir 
///en pantalla la logicas de contador
class ContadorNotifier extends Notifier<Contador> {
  @override
  Contador build() {
    return Contador(0);
  }

  void incrementar() {
    state = Contador(state.contadorClicks + 1);
  }

  void restar() {
    if (state.contadorClicks > 0){
      state = Contador(state.contadorClicks - 1);
    }
  }

  void refescar() {
    state = Contador(0);
  }
}
final contadorProvider = NotifierProvider<ContadorNotifier, Contador>(() {
  return ContadorNotifier();
});
