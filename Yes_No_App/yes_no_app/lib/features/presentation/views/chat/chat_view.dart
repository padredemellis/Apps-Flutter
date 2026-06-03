import 'package:flutter/material.dart';
import 'package:yes_no_app/features/presentation/widgets/chat/usuario_burbuja_chat.dart';
import 'package:yes_no_app/features/presentation/widgets/chat/contacto_burbuja_chat.dart';
import 'package:yes_no_app/features/presentation/widgets/shared/message_field_box.dart';


class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea( // Hace que lo que tenga no se salga de los margenes de la pantalla fisica del celu
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded( //Permite expandir el widget hijo a todo el espacio disponible
              child: ListView.builder(  //crea una lista de elementos escroleable
                itemCount: 100, // se usa para limitar esos elementos
                itemBuilder: (context, index) { //construye el elemento
                  return (index % 2 == 0)
                  ? const ContactoBurbujaChat() : const UsuarioBurbujaChat();
                }, 
              ),
            ),
            const MessageFieldBox(),
          ],
        ),
      ),
    );
  }
}
