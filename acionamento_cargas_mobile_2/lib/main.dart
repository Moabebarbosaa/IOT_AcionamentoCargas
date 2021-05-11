import 'package:acionamento_cargas_mobile_2/bd_hive/articles.g.dart';
import 'package:acionamento_cargas_mobile_2/screens/remote/remote_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
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
      home: RemoteScreen(box: box),
    );
  }
}
