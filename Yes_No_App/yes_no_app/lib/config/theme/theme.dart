import 'package:flutter/material.dart';

const Color _customColor = Colors
    .blueGrey; // creamos una constante de tipo Color para definir el color principal de la app
const List<Color> _colorThemes = [
  // creamos una lista de themas que el usuario podra utilizar mas adelante
  _customColor,
  Colors.black87,
  Colors.red,
  Colors.blueAccent,
  Colors.deepOrange,
  Colors.teal,
];

///Clase que define el tema de la app
class AppTheme {
  final int selectedColor; // variable que controlará el color a seleccionar
  AppTheme({this.selectedColor = 0})
    : assert(
        selectedColor >= 0,
        'Colors must be between 0 and ${_colorThemes.length}',
      ),
      assert(selectedColor <= _colorThemes.length -1, 'The color must be the same size as the list of colors offered.');

  /// Metodo que retorna el tema
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true, // actualiza al estilo de material 3
      colorSchemeSeed: _colorThemes[selectedColor], //utiliza la "semilla del color seleccionado"
    );
  }
}
