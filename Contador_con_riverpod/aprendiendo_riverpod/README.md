# 📱 Aprendiendo Riverpod

Una aplicación Flutter que demuestra el uso de **Riverpod** como gestor de estado reactivo. El proyecto contiene dos características implementadas: un contador simple y un juego interactivo de pelota.

## 🎯 Características

- **HomeView**: Pantalla de inicio/menú principal con introducción al juego
- **Contador**: Aplicación que permite incrementar, decrementar y reiniciar un contador de clicks
- **Juego de Pelota**: Juego interactivo donde el usuario toca la pantalla para impulsar una pelota hacia arriba, implementando física con gravedad y rebotes

## 🏗️ Arquitectura

El proyecto sigue la arquitectura **clean architecture** dividida en capas:

```
lib/
├── main.dart                           # Punto de entrada de la aplicación
└── features/                           # Características del proyecto
    ├── contador/                       # Feature: Contador
    │   ├── model/
    │   │   └── contador.dart          # Modelo de datos del contador
    │   ├── view_models/
    │   │   └── contador_notifier.dart # Lógica de estado con Riverpod
    │   └── view/
    │       └── contador_view.dart     # UI del contador
    │
    └── juego_pelota/                   # Feature: Juego de Pelota
        ├── model/
        │   └── juego_estado.dart      # Modelo de estado del juego
        ├── view_models/
        │   └── juego_notifier.dart    # Lógica del juego con Riverpod
        └── view/
            ├── home_view.dart         # UI: Pantalla de inicio
            ├── juego_view.dart        # UI: Pantalla del juego
            └── juego_estado.dart      # Modelo de estado
```

### Patrones Utilizados

#### 1. **Model** 
Representa el estado/datos del feature. Son clases simples e inmutables que encapsulan la información necesaria.

- [contador.dart](lib/features/contador/model/contador.dart): Encapsula el valor del contador
- [juego_estado.dart](lib/features/juego_pelota/model/juego_estado.dart): Encapsula posición, velocidad, toques y mensajes del juego

#### 2. **View Models (Notifiers)**
Extienden `Notifier<T>` de Riverpod y contienen toda la lógica de negocio. Permiten modificar el estado de forma reactiva.

- [contador_notifier.dart](lib/features/contador/view_models/contador_notifier.dart): Métodos `incrementar()`, `restar()`, `refescar()`
- [juego_notifier.dart](lib/features/juego_pelota/view_models/juego_notifier.dart): Implementa física con gravedad, rebotes y detección de game over

#### 3. **View (Presentación)**
Widgets que consumen el estado del provider y lo muestran al usuario.

- [contador_view.dart](lib/features/contador/view/contador_view.dart): Interfaz con botones flotantes
- [juego_view.dart](lib/features/juego_pelota/view/juego_view.dart): Renderiza la pelota animada y detecta toques

### Flujo de Datos

```
View (ConsumerWidget)
    ↓ (ref.watch)
Provider (NotifierProvider)
    ↓ (emite cambios)
Notifier (Notifier<T>)
    ↓ (modifica state)
Model (Estado inmutable)
    ↓ (vuelve a View)
Widget Reconstruido
```

## 🛠️ Tecnologías

- **Flutter**: Framework UI
- **Riverpod**: Gestor de estado reactivo y dependency injection
- **Dart**: Lenguaje de programación

## 📚 Documentación de Clases

### Contador Feature

#### [Contador](lib/features/contador/model/contador.dart)
```dart
class Contador {
  final int _contadorClicks;
  Contador([this._contadorClicks = 0]);
  int get contadorClicks => _contadorClicks;
}
```
- **Responsabilidad**: Encapsular el número de clicks
- **Métodos**: `contadorClicks` (getter)

#### [ContadorNotifier](lib/features/contador/view_models/contador_notifier.dart)
```dart
class ContadorNotifier extends Notifier<Contador> {
  Contador build() // Inicializa el estado
  void incrementar() // Suma 1 al contador
  void restar() // Resta 1 si es > 0
  void refescar() // Reinicia a 0
}
```
- **Provider**: `contadorProvider` - NotifierProvider<ContadorNotifier, Contador>

#### [ContadorView](lib/features/contador/view/contador_view.dart)
- Widget: `ConsumerWidget`
- Muestra el contador y 3 botones flotantes para las operaciones
- Observa cambios mediante `ref.watch(contadorProvider)`

### Juego de Pelota Feature

#### [JuegoEstado](lib/features/juego_pelota/model/juego_estado.dart)
```dart
class JuegoEstado {
  final double posicionY; // Altura de la pelota
  final double velocidadBalon; // Velocidad actual
  final int toques; // Contador de dominadas
  final String mensaje; // Mensajes al usuario
  
  JuegoEstado copyWith(...) // Crea una copia modificada
}
```

#### [JuegoNotifier](lib/features/juego_pelota/view_models/juego_notifier.dart)
```dart
class JuegoNotifier extends Notifier<JuegoEstado> {
  Timer? _reloj; // Actualiza física a ~60 FPS
  
  JuegoEstado build() // Inicializa el estado
  void iniciarJuego() // Comienza la física
  void _actualizarFisica() // Aplica gravedad y detecta colisiones
  void darToque() // Impulsa la pelota hacia arriba
}
```

**Física del Juego**:
- Gravedad: 0.4 píxeles/frame²
- Rebote elástico: 70% de velocidad inversa
- Límites: techo en Y=56.0, suelo en Y=350.0

#### [JuegoView](lib/features/juego_pelota/view/juego_view.dart)
- Widget: `ConsumerWidget`
- Renderiza: cielo azul, terreno verde, pelota animada
- Interacción: detecta toques con `GestureDetector`
- Usa `Stack` y `Positioned` para la animación

#### [HomeView](lib/features/juego_pelota/view/home_view.dart)
- Widget: `StatelessWidget`
- Pantalla de inicio/menú principal
- Componentes: Icono de pelota, título, descripción y botón para jugar
- Navegación: Lleva a [JuegoView] usando `Navigator.push()`
- Diseño: Gradiente de fondo (cielo → terreno)

```bash
# Obtener dependencias
flutter pub get

# Ejecutar la aplicación
flutter run
```

## 📝 Notas de Desarrollo

### Principios SOLID
- **S**ingle Responsibility: Cada clase tiene una única responsabilidad
- **O**pen/Closed: Las features se pueden extender sin modificar el código existente
- **L**iskov Substitution: Los Notifiers siguen el contrato de Riverpod
- **I**nterface Segregation: Las vistas solo dependen de lo que necesitan
- **D**ependency Inversion: Riverpod inyecta las dependencias

### Immutabilidad
Los modelos (Contador, JuegoEstado) son inmutables, lo que permite:
- Comparación eficiente de cambios
- Debugging más fácil
- Thread-safety

### Reactividad
Riverpod permite:
- Reconstrucción automática cuando cambia el estado
- Caching inteligente de providers
- Manejo automático del ciclo de vida

## 🐛 Debugging

Para ver los cambios de estado en tiempo real, puedes usar:
```dart
// En main.dart
ProviderContainer container = ProviderContainer();
container.listen(
  contadorProvider,
  (prev, next) => print('Contador: $next'),
);
```

## 📖 Recursos

- [Documentación oficial de Riverpod](https://riverpod.dev)
- [Documentación de Flutter](https://flutter.dev)
- [Clean Architecture en Flutter](https://resocoder.com/clean-architecture)

---

**Última actualización**: Mayo 2026  
**Versión**: 1.0  
**Autor**: Estudiante de Flutter
