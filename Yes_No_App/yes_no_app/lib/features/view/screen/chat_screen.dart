import 'package:flutter/material.dart';
import 'package:yes_no_app/features/view/widget/burbuja_contacto.dart';
import 'package:yes_no_app/features/view/widget/burbuja_usuario.dart';
import 'package:yes_no_app/features/view/widget/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MiAppBar(),
      body: _ChatView(), //es el body del chat_screen
    );
  }
}

class _MiAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MiAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://mockmind-api.uifaces.co/content/cartoon/15.jpg',
          ),
        ),
      ),
      title: const Text('Mi amor'),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //Safe area sirve para que el contenido del widget no se salga de la pantalla
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ( index % 2 == 0) ? BurbujaContacto() : BurbujaUsuario();
                },
              ),
            ),
            //Caja de texto
            MessageFieldBox(),
          ],
        ),
      ),
    );
  }
}
