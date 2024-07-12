import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:wpp/controllers/chat_controller.dart';
import 'package:wpp/controllers/theme_controller.dart';
import 'package:wpp/controllers/user_controller.dart';
import 'package:wpp/pages/chat_page.dart';
import 'package:wpp/pages/email_page.dart';
import 'package:wpp/pages/login_page.dart';
import 'package:wpp/pages/messages_page.dart';
import 'package:wpp/pages/request.page.dart';
import 'package:wpp/pages/username_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => ChatController()),
      ],
      child: MyApp(),
    ),
  );
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
        initialRoute: '/',
        routes: {
          '/': (context ) => EmailPage(),
          '/chat': (context ) => const ChatPage(),
          '/login': (context) =>  LoginPage(),
          '/home': (context) =>  MessagePage(),
          '/username': (context) => UsernamePage(),
          '/request': (context) => RequestPage(),
          '/find': (context) => RequestPage(),

        }, 
      );
    } );
  }
}






