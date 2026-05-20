import 'package:flutter/material.dart';
import 'package:aprendiendo_riverpod/features/juego_pelota/view/juego_view.dart';

/// Pantalla de inicio/menú principal de la aplicación.
///
/// Este widget actúa como el punto de entrada visual de la aplicación,
/// presentando una interfaz atractiva con el título, descripción y un botón
/// para navegar al juego de pelota.
///
/// Características:
/// - Fondo con gradiente (cielo azul → terreno verde)
/// - Icono de pelota de fútbol
/// - Título y descripción del juego
/// - Botón para iniciar el juego con navegación
class HomeView extends StatelessWidget {
  /// Constructor const para [HomeView].
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        /// Degradado que simula los colores de una cancha bajo el cielo.
        /// Azul claro en la parte superior (cielo) y verde en la inferior (terreno)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlueAccent, Colors.green],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Icono de pelota de fútbol gigante como elemento visual principal.
              const Icon(Icons.sports_soccer, size: 100, color: Colors.white),
              const SizedBox(height: 20),

              /// Título principal de la aplicación con estilo prominente.
              /// Incluye sombra para mejor legibilidad sobre el degradado.
              const Text(
                'Dominando el balon',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              /// Subtítulo descriptivo del desafío del juego.
              const Text(
                '¿Cuántas dominadas puedes hacer?',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 50),

              /// Botón principal para iniciar el juego.
              ///
              /// Navega a [JuegoView] usando MaterialPageRoute,
              /// permitiendo volver atrás con el botón de retroceso.
              ElevatedButton.icon(
                onPressed: () {
                  /// Navega a la pantalla del juego de pelota.
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const JuegoView()),
                  );
                },
                icon: const Icon(Icons.play_arrow, size: 28),
                label: const Text(
                  '¡JUGAR!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green.shade800,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
