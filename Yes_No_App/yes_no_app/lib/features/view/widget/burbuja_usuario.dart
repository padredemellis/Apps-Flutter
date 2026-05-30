import 'package:flutter/material.dart';
import 'package:yes_no_app/features/view/widget/app_theme.dart';

class BurbujaUsuario extends StatelessWidget {
  const BurbujaUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      //agrupa muchos widgets verticalmente con su children
      crossAxisAlignment: CrossAxisAlignment
          .end, //alinea los widgets al final del eje horizontal
      children: [
        Container(
          //widget que permite decorar y controlar el layout de un widget hijo
          decoration: BoxDecoration(
            //define el estilo visual del Container (colores, bordes, sombras, etc)
            color: colors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            // crea espacio interno alrededor del widget hijo
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Peñarol papá',
              style: TextStyle(color: Colors.amberAccent),
            ),
          ),
        ),
        const SizedBox(height: 10), //se usa para dar espacio entre widgets
      ],
    );
  }
}
