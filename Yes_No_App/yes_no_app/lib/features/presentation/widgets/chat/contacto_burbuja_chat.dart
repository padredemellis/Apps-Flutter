import 'package:flutter/material.dart';
import 'package:yes_no_app/features/presentation/widgets/chat/imagen_burbuja.dart';

class ContactoBurbujaChat extends StatelessWidget {
  const ContactoBurbujaChat({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Dime algo interesante',
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ),
        const SizedBox(height: 50),

        ImagenBurbuja(),

        const SizedBox(height: 10),
      ],
    );
  }
}
