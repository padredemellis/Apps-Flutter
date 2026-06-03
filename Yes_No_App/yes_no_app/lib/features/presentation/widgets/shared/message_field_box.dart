import 'package:flutter/material.dart';

/// Widget que representa un campo de entrada de texto para mensajes.
///
/// [MessageFieldBox] es un componente visual que no cambia de estado.
/// Crea un campo de texto personalizado con un botón de envío integrado.
/// Ideal para aplicaciones de chat o mensajería.
class MessageFieldBox extends StatelessWidget {
  /// Constructor de la clase [MessageFieldBox].
  /// El parámetro [super.key] permite identificar de forma única este widget.
  const MessageFieldBox({super.key});

  /// Método que construye la interfaz visual del widget.
  ///
  /// Este método se ejecuta cada vez que el widget necesita ser dibujado en pantalla.
  /// Retorna el widget [TextFormField] personalizado que será mostrado al usuario.
  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final focusNode = FocusNode();

    /// Define el estilo del borde del campo de texto.
    ///
    /// Utiliza un [UnderlineInputBorder] que crea:
    /// - Un borde transparente (invisible)
    /// - Bordes redondeados con radio de 40 píxeles
    final outlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40),
    );

    /// Configura la apariencia del campo de texto.
    ///
    /// Incluye:
    /// - El estilo del borde (definido arriba)
    /// - Un fondo relleno para mejor visualización
    /// - Un botón de envío ([suffixIcon]) en la esquina derecha
    final inputDecoration = InputDecoration(
      hintText: 'Termina tu mensaje con "?"',
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        /// Icono de envío que se muestra en el campo de texto
        icon: Icon(Icons.send_outlined),

        /// Acción que se ejecuta cuando el usuario presiona el botón de envío
        onPressed: () {
          final textValue = textController.value.text;
          print('button: $textValue');
          textController.clear();
        },
      ),
    );

    /// Retorna un campo de formulario para texto.
    ///
    /// [TextFormField] es un componente que permite:
    /// - Mostrar el campo de entrada personalizado
    /// - Detectar cambios en el texto
    /// - Capturar el envío del formulario
    return TextFormField(
      onTapOutside: (event) => focusNode.unfocus(),
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,

      /// Se ejecuta cuando el usuario presiona Enter o envía el formulario.
      /// [value] contiene el texto ingresado por el usuario.
      onFieldSubmitted: (value) {
        print('Submiy value $value');
        textController.clear();
        focusNode.requestFocus();
      },
    );
  }
}
