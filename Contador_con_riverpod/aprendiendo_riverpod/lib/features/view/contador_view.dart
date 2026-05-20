import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aprendiendo_riverpod/features/view_models/contador_notifier.dart';

class ContadorView extends ConsumerWidget {
  const ContadorView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(contadorProvider);
    return Scaffold(
      appBar: AppBar(title:Center(child: Text("Contador"))),
      body: Center(child: Text(provider.contadorClicks != 0 ? 'Clicks: ${provider.contadorClicks}' : 'Click: ${provider.contadorClicks}')),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        FloatingActionButton(onPressed: () => ref.read(contadorProvider.notifier).incrementar(),
        child: Icon(Icons.plus_one)),
        const SizedBox(height: 10),
        FloatingActionButton(onPressed: () => ref.read(contadorProvider.notifier).restar(),
        child: Icon(Icons.exposure_minus_1_sharp)),
        const SizedBox(height: 10),
        FloatingActionButton(onPressed: () => ref.read(contadorProvider.notifier).refescar(),
        child: Icon(Icons.refresh))
        ]
        ),
    );
  }
}
