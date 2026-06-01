import 'package:flutter/material.dart';

class UsuarioBurbujaChat extends StatelessWidget {
  const UsuarioBurbujaChat({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Todo lo puedo en Cristo que me fortalece',
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
