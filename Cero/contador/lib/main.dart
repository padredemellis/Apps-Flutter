import 'package:flutter/material.dart';
import 'package:contador/features/view/screens/counter_functions_screen.dart';

void main() {
  runApp(Contador()); //Ejecucion del widget principal
}

class Contador extends StatelessWidget {
  const Contador({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.black12),
      home: CounterFunctionsScreen()
    );
  }
}
