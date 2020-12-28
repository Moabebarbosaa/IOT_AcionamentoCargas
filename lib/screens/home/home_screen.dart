import 'package:acionamento/backend/blue/InitConnectionBlue.dart';
import 'package:acionamento/screens/wifi/wifi_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    StartConnection _startConnection = new StartConnection(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 50,
              width: 320,
              child: FlatButton(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Acionamento Remoto",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      ),
                    ),
                    SizedBox(width: 20,),
                    Icon(
                      Icons.wifi,
                      color: Colors.black,
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => WiFiScreen()));
                },
              ),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: Container(
              height: 50,
              width: 320,
              child: FlatButton(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Acionamento Bluetooth",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      ),
                    ),
                    SizedBox(width: 20,),
                    Icon(
                      Icons.bluetooth,
                      color: Colors.black,
                    ),
                  ],
                ),
                onPressed: () {
                  _startConnection.start();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
