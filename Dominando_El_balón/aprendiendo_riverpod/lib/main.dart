/// Este es el punto de entrada principal de la aplicación.
///
/// La aplicación utiliza Riverpod como gestor de estado, permitiendo
/// una gestión eficiente y reactiva de los datos en la aplicación.
///
/// Características implementadas:
/// - HomeView: Pantalla de inicio con menú principal y botón para jugar
/// - Contador: Aplicación simple que incrementa, decrementa y reinicia un contador
/// - Juego de Pelota: Juego interactivo donde el usuario toca la pelota para ganar puntos

import 'package:aprendiendo_riverpod/features/contador/view/contador_view.dart';
import 'package:aprendiendo_riverpod/features/juego_pelota/view/home_view.dart';
import 'package:aprendiendo_riverpod/features/juego_pelota/view/juego_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Función principal que inicia la aplicación.
///
/// Envuelve la aplicación en [ProviderScope] para habilitar
/// la funcionalidad de Riverpod en toda la aplicación.
void main() {
  runApp(ProviderScope(child: CounterApp()));
}

/// Widget raíz de la aplicación.
///
/// Define la configuración principal de MaterialApp incluyendo
/// el tema material de Flutter y la pantalla inicial.
class CounterApp extends StatelessWidget {
  /// Constructor const para [CounterApp].
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aprendiendo Riverpod y Loop Game',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
