import 'package:flutter/material.dart';
import 'package:yes_no_app/features/view/widget/image_bubble.dart';

class BurbujaContacto extends StatelessWidget {
  const BurbujaContacto({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.secondary, borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text('Nacional papá', style: TextStyle(color: Colors.white))
          ),
        ),
        const SizedBox(height: 5,),

        ImageBubble(),

        SizedBox(height: 10,),
      ],
    );
  }
}
