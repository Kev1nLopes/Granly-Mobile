import 'package:flutter/material.dart';
import 'package:wpp/controllers/theme_controller.dart';
import 'package:wpp/pages/chat_page.dart';
import 'package:wpp/pages/login_page.dart';
import 'package:wpp/pages/messages_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(      
      animation: ThemeController.instance,
      builder: (context, child) {
      return MaterialApp(
        theme: ThemeData(brightness: ThemeController.instance.switchColor ? Brightness.dark : Brightness.light),
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/chat': (context ) => const ChatPage(),
          '/login': (context) =>  LoginPage(),
          '/home': (context) => MessagesPage(),
        },
      );
    } );
  }
}






