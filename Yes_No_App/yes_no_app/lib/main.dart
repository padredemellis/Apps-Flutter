import 'package:flutter/material.dart';
import 'package:yes_no_app/config/theme/theme.dart';
import 'package:yes_no_app/features/presentation/views/chat/chat_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yes no app',
      theme: AppTheme( selectedColor: 0).theme(),
      home: ChatScreen()
        );
  }
}