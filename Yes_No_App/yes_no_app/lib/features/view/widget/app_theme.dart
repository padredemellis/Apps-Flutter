import 'package:flutter/material.dart';

const Color _color = Color(0xFF5C11D4);

const List<Color> _colorthemes = [
  _color,
  Colors.blue,
  Colors.red,
  Colors.yellowAccent,
  Colors.blueGrey,
  Colors.green,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0}) : assert(
    selectedColor >=0 && selectedColor <= _colorthemes.length - 1, 'Color must be between 0 and ${_colorthemes.length}'
    );

  ThemeData theme() {
    return ThemeData(useMaterial3: true, colorSchemeSeed: _colorthemes[selectedColor]);
  }
}
