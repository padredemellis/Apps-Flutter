import 'package:flutter/material.dart';
import 'package:yes_no_app/features/presentation/views/chat/chat_view.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Contacto'),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://mockmind-api.uifaces.co/content/cartoon/29.jpg'),
          ),
        ),
      ),
      body: ChatView(),
    );
  }
}