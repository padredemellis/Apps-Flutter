import 'package:flutter/material.dart';
import 'package:yes_no_app/features/view/screen/chat_screen.dart';
import 'package:yes_no_app/features/view/widget/app_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme( selectedColor: 3 ).theme(),
      title: 'Yes-No-App',
      home: const ChatScreen(),
        );
  }
}