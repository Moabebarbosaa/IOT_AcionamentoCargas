import 'dart:io';
import 'package:acionamento_cargas/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  Socket sock = await Socket.connect('192.168.1.58', 80);
  runApp(MyApp(sock));
}

class MyApp extends StatelessWidget {

  Socket sock;
  MyApp(this.sock);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(sock),
    );
  }
}