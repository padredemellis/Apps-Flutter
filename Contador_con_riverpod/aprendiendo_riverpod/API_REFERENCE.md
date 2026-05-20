# 📖 Referencia Rápida de APIs

Documentación de referencia rápida de todas las clases y métodos implementados en el proyecto.

## Tabla de Contenidos

- [Contador Feature](#contador-feature)
- [Juego de Pelota Feature](#juego-de-pelota-feature)
  - [Modelos](#modelos)
  - [Vistas](#vistas)
- [Main](#main)

---

## Contador Feature

### `Contador` (Model)
**Ubicación**: [lib/features/contador/model/contador.dart](lib/features/contador/model/contador.dart)

Modelo que encapsula el estado de un contador de clicks.

#### Constructor
```dart
Contador([int contadorClicks = 0])
```

| Parámetro | Tipo | Descripción | Defecto |
|-----------|------|-------------|---------|
| `contadorClicks` | `int` | Número inicial de clicks | `0` |

#### Propiedades

| Propiedad | Tipo | Acceso | Descripción |
|-----------|------|--------|-------------|
| `contadorClicks` | `int` | Getter | Obtiene el número actual de clicks |

#### Ejemplo
```dart
final contador = Contador(5);
print(contador.contadorClicks);  // Output: 5

final contador2 = Contador();
print(contador2.contadorClicks); // Output: 0
```

---

### `ContadorNotifier` (ViewModel)
**Ubicación**: [lib/features/contador/view_models/contador_notifier.dart](lib/features/contador/view_models/contador_notifier.dart)

Notifier que gestiona la lógica del contador usando Riverpod.

**Tipo**: `Notifier<Contador>`

#### Métodos Públicos

##### `Contador build()`
Inicializa el estado del contador.

**Retorna**: `Contador` - Nueva instancia iniciada en 0

```dart
@override
Contador build() {
  return Contador(0);
}
```

---

##### `void incrementar()`
Incrementa el contador en 1.

**Efecto**: Emite un nuevo estado con el valor aumentado

```dart
ref.read(contadorProvider.notifier).incrementar();
// Contador: 5 → Contador: 6
```

---

##### `void restar()`
Decrementa el contador en 1 (solo si es mayor que 0).

**Efecto**: Emite un nuevo estado con el valor reducido o sin cambios

```dart
ref.read(contadorProvider.notifier).restar();
// Contador: 3 → Contador: 2
// Contador: 0 → Contador: 0 (no cambia)
```

---

##### `void refescar()`
Reinicia el contador a 0.

**Efecto**: Emite un nuevo estado con valor 0

```dart
ref.read(contadorProvider.notifier).refescar();
// Contador: 99 → Contador: 0
```

---

### `contadorProvider` (Provider)
**Ubicación**: [lib/features/contador/view_models/contador_notifier.dart](lib/features/contador/view_models/contador_notifier.dart)

Provider que instancia y gestiona el estado del contador.

**Tipo**: `NotifierProvider<ContadorNotifier, Contador>`

```dart
final contadorProvider = NotifierProvider<ContadorNotifier, Contador>(
  () => ContadorNotifier(),
);
```

#### Uso en Widgets

```dart
// Observar estado
final contador = ref.watch(contadorProvider);

// Leer estado una sola vez
final contador = ref.read(contadorProvider);

// Acceder a métodos
ref.read(contadorProvider.notifier).incrementar();
```

---

### `ContadorView` (View)
**Ubicación**: [lib/features/contador/view/contador_view.dart](lib/features/contador/view/contador_view.dart)

Widget que muestra la interfaz del contador.

**Tipo**: `ConsumerWidget`

#### Constructor
```dart
const ContadorView({super.key})
```

#### Descripción
- Muestra el número de clicks en el centro de la pantalla
- Presenta 3 botones flotantes: incrementar, decrementar, reiniciar
- Reconstruye automáticamente cuando cambia el estado

#### Ejemplo de Uso
```dart
MaterialApp(
  home: ContadorView(),
)
```

---

## Juego de Pelota Feature

### `JuegoEstado` (Model)
**Ubicación**: [lib/features/juego_pelota/model/juego_estado.dart](lib/features/juego_pelota/model/juego_estado.dart)

Modelo que encapsula el estado completo del juego.

#### Constructor
```dart
JuegoEstado({
  double posicionY = 100.0,
  double velocidadBalon = 0.0,
  int toques = 0,
  String mensaje = 'Toca para empezar'
})
```

| Parámetro | Tipo | Descripción | Defecto |
|-----------|------|-------------|---------|
| `posicionY` | `double` | Posición vertical de la pelota (píxeles desde arriba) | `100.0` |
| `velocidadBalon` | `double` | Velocidad actual (píxeles/frame). Positivo = hacia abajo, negativo = hacia arriba | `0.0` |
| `toques` | `int` | Número total de dominadas/toques | `0` |
| `mensaje` | `String` | Mensaje para mostrar al usuario | `'Toca para empezar'` |

#### Propiedades

| Propiedad | Tipo | Acceso | Descripción |
|-----------|------|--------|-------------|
| `posicionY` | `double` | Lectura | Posición vertical de la pelota |
| `velocidadBalon` | `double` | Lectura | Velocidad actual |
| `toques` | `int` | Lectura | Contador de dominadas |
| `mensaje` | `String` | Lectura | Mensaje mostrado |

#### Métodos

##### `JuegoEstado copyWith({...})`
Crea una copia del estado con valores actualizados.

**Parámetros**:
- `posicionY` (opcional): Nueva posición Y
- `velocidadBalon` (opcional): Nueva velocidad
- `toques` (opcional): Nuevo contador de toques
- `mensaje` (opcional): Nuevo mensaje

**Retorna**: `JuegoEstado` - Nueva instancia con valores actualizados

```dart
final estado = JuegoEstado(toques: 5);
final nuevoEstado = estado.copyWith(toques: 6, posicionY: 200.0);
// JuegoEstado(posicionY: 200.0, velocidadBalon: 0.0, toques: 6, mensaje: 'Toca para empezar')
```

#### Ejemplo Completo
```dart
// Crear estado inicial
final estado1 = JuegoEstado();
// JuegoEstado(posicionY: 100.0, velocidadBalon: 0.0, toques: 0, mensaje: 'Toca para empezar')

// Crear estado personalizado
final estado2 = JuegoEstado(
  posicionY: 250.0,
  velocidadBalon: 5.2,
  toques: 10,
  mensaje: 'Dominando!'
);

// Copiar con modificaciones
final estado3 = estado2.copyWith(toques: 11);
// JuegoEstado(posicionY: 250.0, velocidadBalon: 5.2, toques: 11, mensaje: 'Dominando!')
```

---

### `JuegoNotifier` (ViewModel)
**Ubicación**: [lib/features/juego_pelota/view_models/juego_notifier.dart](lib/features/juego_pelota/view_models/juego_notifier.dart)

Notifier que gestiona la física y lógica del juego.

**Tipo**: `Notifier<JuegoEstado>`

#### Propiedades Privadas

| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `_reloj` | `Timer?` | Timer periódico que actualiza la física (16ms = ~60 FPS) |

#### Métodos Públicos

##### `JuegoEstado build()`
Inicializa el estado del juego.

**Configuración**:
- Configura listener `onDispose()` para cancelar el timer
- Inicia la pelota en el centro de la pantalla (Y=350.0)

**Retorna**: `JuegoEstado` - Estado inicial

```dart
@override
JuegoEstado build() {
  ref.onDispose(() => _reloj?.cancel());
  return JuegoEstado(posicionY: 350.0, velocidadBalon: 0.0, toques: 0);
}
```

---

##### `void iniciarJuego()`
Inicia el juego creando un timer que actualiza la física periódicamente.

**Acciones**:
1. Cancela cualquier timer previo
2. Limpia el mensaje (`mensaje = ''`)
3. Crea nuevo Timer con intervalo de 16ms
4. Llama a `_actualizarFisica()` cada frame

```dart
ref.read(juegoProvider.notifier).iniciarJuego();
// El juego comienza a ejecutarse
```

---

##### `void _actualizarFisica()` (Privado)
Actualiza la física de la pelota en cada frame.

**Proceso**:
1. Aplica gravedad: `nuevaVelocidad = velocidadActual + 0.4`
2. Calcula nueva posición: `nuevaPosicion = posicionY + nuevaVelocidad`
3. Verifica colisiones:
   - **Suelo (Y ≥ 350.0)**: Game Over
   - **Techo (Y ≤ 56.0)**: Rebota (70% velocidad inversa)
   - **Normal**: Continúa

```dart
// Ejemplo de valores durante el juego:
// Frame 1: velocidad=0, posicion=350 (inicio)
// Frame 2: velocidad=0.4, posicion=350.4
// Frame 3: velocidad=0.8, posicion=351.2
// ... (cae hasta game over)
```

---

##### `void darToque()`
Registra un toque del jugador en la pelota.

**Acciones**:
- Impulsa la pelota hacia arriba: `velocidadBalon = -10.0`
- Incrementa contador de toques: `toques += 1`

```dart
ref.read(juegoProvider.notifier).darToque();
// La pelota sube y el contador aumenta
```

---

### `juegoProvider` (Provider)
**Ubicación**: [lib/features/juego_pelota/view_models/juego_notifier.dart](lib/features/juego_pelota/view_models/juego_notifier.dart)

Provider que instancia y gestiona el estado del juego.

**Tipo**: `NotifierProvider<JuegoNotifier, JuegoEstado>`

```dart
final juegoProvider = NotifierProvider<JuegoNotifier, JuegoEstado>(
  () => JuegoNotifier(),
);
```

#### Uso en Widgets

```dart
// Observar estado del juego
final estado = ref.watch(juegoProvider);
print('Toques: ${estado.toques}');

// Iniciar juego
ref.read(juegoProvider.notifier).iniciarJuego();

// Dar toque
ref.read(juegoProvider.notifier).darToque();
```

---

### `JuegoView` (View)
**Ubicación**: [lib/features/juego_pelota/view/juego_view.dart](lib/features/juego_pelota/view/juego_view.dart)

Widget que muestra la interfaz del juego.

**Tipo**: `ConsumerWidget`

#### Constructor
```dart
const JuegoView({super.key})
```

#### Descripción

**Componentes**:
- **AppBar**: Muestra contador de dominadas
- **Cielo (azul claro)**: Área de juego
- **Terreno (verde)**: Línea divisoria a Y=400.0
- **Pelota (icono de fútbol)**: Se anima según física
- **Mensaje**: Texto flotante para instrucciones y game over

**Interacción**:
- Detecta toques con `GestureDetector`
- Primer toque inicia el juego
- Toques posteriores impulsan la pelota

#### Ejemplo de Uso
```dart
MaterialApp(
  home: JuegoView(),
)
```

#### Coordenadas del Juego
| Elemento | Y Inicial | Y Límite |
|----------|-----------|---------|
| Techo | - | 56.0 |
| Terreno | - | 400.0 |
| Suelo (Game Over) | - | 350.0 |

---

### `HomeView` (View)
**Ubicación**: [lib/features/juego_pelota/view/home_view.dart](lib/features/juego_pelota/view/home_view.dart)

Pantalla de inicio/menú principal de la aplicación.

**Tipo**: `StatelessWidget`

#### Constructor
```dart
const HomeView({super.key})
```

#### Descripción

**Componentes**:
- **Fondo**: Gradiente lineal (azul claro → verde)
- **Icono**: Pelota de fútbol de tamaño 100px
- **Título**: "Dominando el balon" con sombra y estilos prominentes
- **Subtítulo**: "¿Cuántas dominadas puedes hacer?" en cursiva
- **Botón**: "¡JUGAR!" con icono de play para iniciar

**Características**:
- Interfaz atractiva y llamativa
- Navegación a [JuegoView] usando `Navigator.push()`
- SafeArea para respetar notches y barras del sistema
- Diseño responsivo y centrado

#### Estructura de Layout
```
┌─────────────────────────────┐
│   Gradiente (Fondo)         │
│  ┌─────────────────────────┐│
│  │   Icono de Pelota (100) ││
│  │   SizedBox(20)          ││
│  │   Título "Dominando..." ││
│  │   SizedBox(10)          ││
│  │   Subtítulo "¿Cuántas?"││
│  │   SizedBox(50)          ││
│  │   Botón "¡JUGAR!"       ││
│  └─────────────────────────┘│
└─────────────────────────────┘
```

#### Métodos

##### `void onPressed()`
Navega a la pantalla del juego cuando el usuario presiona el botón.

```dart
onPressed: () {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => const JuegoView()),
  );
}
```

#### Estilos

| Elemento | Color | Tamaño | Notas |
|----------|-------|--------|-------|
| Fondo | Gradiente azul-verde | Full screen | LinearGradient |
| Icono | Blanco | 100px | Icons.sports_soccer |
| Título | Blanco | 32px | Bold, shadow |
| Subtítulo | Blanco 70% | 16px | Cursiva |
| Botón BG | Blanco | - | ElevatedButton |
| Botón FG | Verde 800 | - | Contraste |

#### Ejemplo de Uso
```dart
void main() {
  runApp(ProviderScope(child: CounterApp()));
}

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),  // Pantalla inicial
    );
  }
}

// Navegación desde HomeView a JuegoView
onPressed: () {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => const JuegoView()),
  );
}

// Volver desde JuegoView a HomeView
Navigator.pop(context);
```

---

## Main

### `CounterApp` (Root Widget)
**Ubicación**: [lib/main.dart](lib/main.dart)

Widget raíz de la aplicación.

**Tipo**: `StatelessWidget`

#### Constructor
```dart
const CounterApp({super.key})
```

#### Descripción
- Define MaterialApp con tema
- Establece JuegoView como pantalla inicial

#### Ejemplo
```dart
void main() {
  runApp(ProviderScope(child: CounterApp()));
}
```

---

## Constantes y Valores Importantes

### Física del Juego

| Constante | Valor | Descripción |
|-----------|-------|-------------|
| GRAVEDAD | `0.4` | Aceleración por frame (píxeles/frame²) |
| VELOCIDAD_TOQUE | `-10.0` | Velocidad inicial del impulso hacia arriba |
| COEF_RESTITUCIÓN | `0.7` | Factor de rebote elástico (70%) |
| Y_TECHO | `56.0` | Posición del techo donde rebota |
| Y_TERRENO | `400.0` | Posición del terreno visualizado |
| Y_GAME_OVER | `350.0` | Posición donde ocurre game over |
| FPS | `60` | Frames por segundo (16ms por frame) |

### Dimensiones

| Dimensión | Valor | Descripción |
|-----------|-------|-------------|
| Tamaño Pelota | `50.0` | Tamaño del icono de la pelota |
| Offset Horizontal | `width/2 - 25` | Centra la pelota horizontalmente |
| Alto Terreno | `400.0` | Altura desde arriba donde comienza el terreno |
| Border Terreno | `4.0` | Grosor de la línea del terreno |

---

## Patrones de Uso

### Pattern 1: Observar y Reaccionar
```dart
final estado = ref.watch(juegoProvider);
if (estado.toques > 10) {
  // Mostrar achievement
}
```

### Pattern 2: Ejecutar Acción
```dart
ref.read(juegoProvider.notifier).darToque();
```

### Pattern 3: Combinar Estados (Avanzado)
```dart
final contador = ref.watch(contadorProvider);
final juego = ref.watch(juegoProvider);

// Usar ambos estados
final total = contador.contadorClicks + juego.toques;
```

---

## Notas Importantes

⚠️ **No olvide**:
- Siempre use `ref.watch()` en `build()` para observar cambios
- Use `ref.read()` en callbacks para accionar métodos
- Los Notifiers son singletons durante la vida de la app
- Los timers se cancelan automáticamente al descartar el widget

---

**Última actualización**: Mayo 2026  
**Versión de Riverpod**: 2.x
