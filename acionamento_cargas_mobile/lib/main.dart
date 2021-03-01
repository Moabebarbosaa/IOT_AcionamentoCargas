import 'package:acionamento_cargas/bd_hive/articles.g.dart';
import 'package:acionamento_cargas/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(ReleModelAdapter());
  var box = await Hive.openBox('reles');

  runApp(MyApp(box));
}


class MyApp extends StatelessWidget {
  var box;
  MyApp(this.box);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(box),
    );
  }
}