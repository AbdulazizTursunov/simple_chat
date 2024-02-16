import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_chat_socket/chat_constructor/chat_app.dart';
import 'package:simple_chat_socket/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:defaultTargetPlatform ==TargetPlatform.iOS ? IosTheme:androidTheme,
      home:  ChatApp(),
    );
  }
}
