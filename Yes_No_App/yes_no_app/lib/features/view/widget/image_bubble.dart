import 'package:flutter/material.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(
      context,
    ).size; //MediaQuery nos da informacion referente al dispositivo que se esta ejecutando
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        "https://yesno.wtf/assets/yes/10-271c872c91cd72c1e38e72d2f8eda676.gif",
        width: size.width * 0.7, //redimensiono la imagen al 70% de ese tamaño
        height: 150,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: size.width * 0.7,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: const Text("Mi amor está enviando una imagen"),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size.width * 0.7,
            height: 150,
            color: Colors.grey,
            child: Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }
}
