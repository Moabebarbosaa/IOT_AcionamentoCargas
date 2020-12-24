import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  bool _key = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
            "Acionamento de Cargas"
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlatButton(
              child: Container(
                height: 200,
                width: 200,
                child: Icon(
                  _key == true ? Icons.wb_incandescent_outlined : Icons.wb_incandescent,
                  color: _key == true ? Colors.white : Colors.yellow,
                  size: 200,
                ),
              ),
              onPressed: () {
                setState(() {
                  _key = !_key;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
