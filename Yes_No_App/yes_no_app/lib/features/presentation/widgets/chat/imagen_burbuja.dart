import 'package:flutter/material.dart';

class ImagenBurbuja extends StatelessWidget {
  const ImagenBurbuja({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        "https://yesno.wtf/assets/no/2-101be1e3d8a0ed407c4e3c001ef8fa66.gif",
        width: size.width * 0.7,
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) { //Sirve para mostrar algo mientras carga el contenido
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator( // Sireve para mostrar un circulo mientras carga el contenido
              value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
              : null,
            )
          );
        },
      ),
    );
  }
}
