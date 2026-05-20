# 🏗️ Documentación Detallada de Arquitectura

Este documento proporciona una visión profunda de la arquitectura implementada en el proyecto "Aprendiendo Riverpod".

## Tabla de Contenidos

1. [Visión General](#visión-general)
2. [Patrones de Arquitectura](#patrones-de-arquitectura)
3. [Gestión de Estado](#gestión-de-estado)
4. [Ciclo de Vida de un Widget](#ciclo-de-vida-de-un-widget)
5. [Física del Juego](#física-del-juego)
6. [Buenas Prácticas](#buenas-prácticas)

## Visión General

### Estructura de Capas

La arquitectura del proyecto está dividida en **3 capas principales**:

```
┌─────────────────────────────────┐
│     PRESENTACIÓN (View)         │  ← Widgets visuales
├─────────────────────────────────┤
│   GESTIÓN DE ESTADO (Notifier)  │  ← Lógica de negocio
├─────────────────────────────────┤
│      DATOS (Model)              │  ← Estado inmutable
└─────────────────────────────────┘
```

### Ventajas de esta Arquitectura

✅ **Separación de responsabilidades**: Cada capa tiene un propósito claro  
✅ **Testeable**: La lógica está separada de la UI  
✅ **Reutilizable**: Los Notifiers pueden usarse en múltiples vistas  
✅ **Mantenible**: Cambios en la UI no afectan la lógica  
✅ **Escalable**: Fácil agregar nuevas features  

## Patrones de Arquitectura

### 1. Clean Architecture (Hexagonal)

El proyecto implementa Clean Architecture adaptada para Flutter:

```
Exterior → Riverpod Providers → Notifiers → Models ← Exterior
```

**Dependencias**: Las dependencias siempre apuntan hacia adentro. 
- View depende de Notifier
- Notifier depende de Model
- Model no depende de nada

### 2. Repository Pattern (Simplificado)

En un proyecto más grande, el Notifier actuaría como Repository que se comunica con:
- Servicios de datos
- APIs
- Bases de datos

En este caso simplificado:

```
View → Notifier (también es Repository) → Model
```

### 3. State Management Pattern

**Riverpod** proporciona:

```dart
// Provider: Define cómo crear/acceder al estado
final contadorProvider = NotifierProvider<ContadorNotifier, Contador>(
  () => ContadorNotifier(),
);

// En el Widget:
ref.watch(contadorProvider)  // Observa cambios
ref.read(contadorProvider)   // Lee valor actual
ref.read(contadorProvider.notifier)  // Accede a métodos
```

## Gestión de Estado

### Flujo Unidireccional de Datos

```
        ┌─────────────────┐
        │  UI Event       │
        │  (Tap, etc)     │
        └────────┬────────┘
                 │
                 ▼
        ┌─────────────────────────┐
        │  Notifier.método()      │
        │  (incrementar, etc)     │
        └────────┬────────────────┘
                 │
                 ▼
        ┌──────────────────────────┐
        │  state = Model(nuevo)    │
        │  Emite cambio a Riverpod │
        └────────┬─────────────────┘
                 │
                 ▼
        ┌──────────────────────────┐
        │  ref.watch() detecta     │
        │  cambio de estado        │
        └────────┬─────────────────┘
                 │
                 ▼
        ┌──────────────────────────┐
        │  Widget se reconstruye   │
        │  Muestra nuevo estado    │
        └──────────────────────────┘
```

### Inmutabilidad del Estado

```dart
// ❌ MAL - Modifica directamente
state.contadorClicks = 5;

// ✅ BIEN - Crea una nueva instancia
state = Contador(5);

// ✅ TAMBIÉN BIEN - Usando copyWith
state = state.copyWith(posicionY: 100.0, toques: 5);
```

**Ventajas**:
- Comparación eficiente: `oldState != newState`
- Debugging: Puedes ver el historial de cambios
- Eficiencia: Riverpod solo reconstruye widgets que realmente cambiaron

## Ciclo de Vida de un Widget

### ContadorView

```
1. Widget Creado (ConsumerWidget)
   ↓
2. build() llamado
   ↓
3. ref.watch(contadorProvider) suscrito
   ↓
4. Cambios en estado → Widget reconstruido
   ↓
5. Usuario presiona botón → ref.read(contadorProvider.notifier).incrementar()
   ↓
6. Notifier modifica state → state = Contador(state.contadorClicks + 1)
   ↓
7. Riverpod notifica suscriptores
   ↓
8. Widget reconstruido con nuevo estado
   ↓
9. Ciclo continúa
```

### JuegoView (Más Complejo)

```
1. JuegoView creado
   ↓
2. ref.watch(juegoProvider) observa estado
   ↓
3. GestureDetector detecta primer tap
   ↓
4. iniciarJuego() crea Timer periódico (16ms = ~60 FPS)
   ↓
5. Timer ejecuta _actualizarFisica() cada frame
   ↓
6. Nuevas posiciones/velocidades actualizan state
   ↓
7. Widget reconstruido con nueva posición (pelota se anima)
   ↓
8. Tap en pelota → darToque() → velocidad = -10.0
   ↓
9. Colisión con suelo → cancelar Timer, mostrar "Game Over"
   ↓
10. Nuevo tap en "Game Over" → Reinicia el juego
```

### HomeView (StatelessWidget Simple)

```
1. HomeView renderizado como pantalla inicial
   ↓
2. build() genera UI estática (sin providers)
   ↓
3. Componentes:
   - Gradiente de fondo (azul → verde)
   - Icono de pelota
   - Título y descripción
   - Botón de navegación
   ↓
4. Usuario toca botón "¡JUGAR!"
   ↓
5. Navigator.push() navega a JuegoView
   ↓
6. JuegoView se muestra en stack
   ↓
7. Usuario puede volver con Navigator.pop()
```

**Diferencia con ConsumerWidget**: HomeView no observa providers, solo muestra UI estática y maneja navegación.

## Flujo de Navegación

La aplicación utiliza una estructura de navegación basada en Navigator de Flutter:

```
┌─────────────────────────────────────────┐
│   main() - ProviderScope                │
│   ↓                                      │
│   CounterApp (StatelessWidget)          │
│   ├─ MaterialApp                        │
│   └─ home: HomeView                     │
│      ↓                                  │
│      ┌──────────────────────────────┐   │
│      │  HomeView (pantalla inicial) │   │
│      │  - UI estática con menú      │   │
│      │  - Botón "¡JUGAR!"           │   │
│      │  └─ Navigator.push()         │   │
│      │     ↓                         │   │
│      │     ┌────────────────────┐   │   │
│      │     │ JuegoView          │   │   │
│      │     │ (ConsumerWidget)   │   │   │
│      │     │ - Observa provider │   │   │
│      │     │ - Física del juego │   │   │
│      │     │ └─ Navigator.pop() │   │   │
│      │     │    ↓ vuelve a Home│   │   │
│      └──────────────────────────┘   │   │
│      │                              │   │
│      └─ (En futuro) ContadorView    │   │
│                                      │   │
└─────────────────────────────────────────┘
```

**Stack de Navegación**:
1. HomeView (raíz/inicio)
2. JuegoView (pushed sobre HomeView)
3. Navigator.pop() vuelve a HomeView

**Código de Navegación**:
```dart
// En HomeView: Navegar a JuegoView
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => const JuegoView()),
);

// En JuegoView: Volver a HomeView
Navigator.pop(context);
```

## Física del Juego

### Ecuaciones de Movimiento

```dart
// Cada frame (16ms):
nuevaVelocidad = velocidadActual + GRAVEDAD;  // +0.4
nuevaPosicion = posicionY + nuevaVelocidad;
```

### Detección de Colisiones

#### Techo (Y ≤ 56.0):
```dart
if (nuevaPosicion <= 56.0) {
  nuevaPosicion = 56.0;
  velocidadRebote = nuevaVelocidad * -0.7;  // 70% inversa
}
```
- La pelota rebota pero pierde energía
- Coeficiente de restitución: 0.7

#### Suelo (Y ≥ 350.0):
```dart
if (nuevaPosicion >= 350.0) {
  // Game Over
  state = JuegoEstado(
    posicionY: 350.0,
    velocidadBalon: 0.0,
    toques: 0,
    mensaje: '¡Game Over!'
  );
}
```

### Toque del Jugador

```dart
void darToque() {
  state = state.copyWith(
    velocidadBalon: -10.0,  // Impulso hacia arriba
    toques: state.toques + 1  // Incrementa contador
  );
}
```

## Buenas Prácticas

### 1. ConsumerWidget vs ConsumerStatefulWidget vs StatelessWidget

```dart
// ✅ Use ConsumerWidget (sin estado local, observa providers)
class ContadorView extends ConsumerWidget {
  const ContadorView({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Solo observa providers
    final contador = ref.watch(contadorProvider);
    return Text('${contador.contadorClicks}');
  }
}

// ✅ Use StatelessWidget (sin providers, solo presentación)
class HomeView extends StatelessWidget {
  const HomeView({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Solo widgets estáticos, sin observar estado
    return Text('Bienvenido');
  }
}

// ❌ Evite ConsumerStatefulWidget si no es necesario
// Úselo solo si necesita setState() para estado local
```

**Regla Simple**:
- `StatelessWidget`: Presentación pura, sin lógica de estado
- `ConsumerWidget`: Observa y consume providers
- `ConsumerStatefulWidget`: Solo si necesita state local además de providers

### 2. ref.watch vs ref.read

```dart
// ✅ watch: Para observar cambios (reconstruye widget)
final contador = ref.watch(contadorProvider);

// ✅ read: Para acceder una sola vez (en callbacks)
ref.read(contadorProvider.notifier).incrementar();

// ❌ Evite:
ref.read(contadorProvider);  // En build(), no detecta cambios
ref.watch(contadorProvider.notifier);  // Innecesario
```

### 3. Nombres Convencionales

```dart
// Providers
final contadorProvider = NotifierProvider<ContadorNotifier, Contador>(...);

// Notifiers
class ContadorNotifier extends Notifier<Contador> { }

// Models
class Contador { }

// Views
class ContadorView extends ConsumerWidget { }
```

### 4. Documentación con ///

```dart
/// Descripción breve de la clase/método
/// 
/// Descripción detallada si es necesario.
/// Incluye parámetros, retorno y ejemplos.
///
/// Parámetros:
/// - [parametro]: Descripción
///
/// Retorna:
/// - [Tipo]: Descripción
///
/// Ejemplo:
/// ```dart
/// final contador = Contador(5);
/// ```
class Contador {
  // ...
}
```

### 5. Manejo de Recursos

```dart
@override
JuegoEstado build() {
  // Cleanup cuando el provider se desecha
  ref.onDispose(() {
    _reloj?.cancel();  // Cancela el Timer
  });
  return JuegoEstado(...);
}
```

## Extensibilidad

### Agregar una Nueva Feature

1. **Crear estructura**:
```
features/
└── nueva_feature/
    ├── model/
    │   └── nueva_model.dart
    ├── view_models/
    │   └── nueva_notifier.dart
    └── view/
        └── nueva_view.dart
```

2. **Implementar modelo**:
```dart
class NuevaModel {
  final String datos;
  NuevaModel(this.datos);
}
```

3. **Crear Notifier**:
```dart
class NuevaNotifier extends Notifier<NuevaModel> {
  @override
  NuevaModel build() => NuevaModel('inicial');
  
  void cambiar(String nuevosDatos) {
    state = NuevaModel(nuevosDatos);
  }
}

final nuevaProvider = NotifierProvider<NuevaNotifier, NuevaModel>(
  () => NuevaNotifier(),
);
```

4. **Crear View**:
```dart
class NuevaView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelo = ref.watch(nuevaProvider);
    return Text(modelo.datos);
  }
}
```

5. **Agregar a main.dart**:
```dart
home: NuevaView()  // o selector con TabBar
```

## Conclusión

Esta arquitectura proporciona:
- ✅ Código limpio y mantenible
- ✅ Fácil de testear
- ✅ Reutilizable
- ✅ Escalable
- ✅ Reactive a cambios de estado

Para proyectos más grandes, se puede extender agregando:
- Services (API calls, LocalStorage)
- Repositories (abstracción de fuentes de datos)
- UseCases (lógica de negocio compleja)
- DTOs (Data Transfer Objects)
