import 'package:aprendiendo_riverpod/features/contador/view/contador_view.dart';
import 'package:aprendiendo_riverpod/features/juego_pelota/view/juego_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: CounterApp()));
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JuegoView());
  }
}
