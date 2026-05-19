import 'package:aprendiendo_riverpod/features/model/contador.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContadorNotifier extends Notifier<Contador> {
  @override
  Contador build() {
    return Contador(0);
  }

  void incrementar() {
    state = Contador(state.contadorClicks + 1);
  }

  void restar() {
    state = Contador(state.contadorClicks - 1);
  }

  void refescar() {
    state = Contador(0);
  }
}
final contadorProvider = NotifierProvider<ContadorNotifier, Contador>(() {
  return ContadorNotifier();
});
