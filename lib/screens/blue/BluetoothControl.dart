import 'package:acionamento/backend/blue/FunctionBluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';


class BluetoothControl extends StatefulWidget {

  final BluetoothDevice server;

  const BluetoothControl({this.server});

  @override
  _BluetoothControlState createState() => _BluetoothControlState();
}

class _BluetoothControlState extends State<BluetoothControl> {

  FunctionBluetooth _functionBluetooth;
  BluetoothConnection connection;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      _functionBluetooth = new FunctionBluetooth(connection);

      connection.input.listen(_functionBluetooth.onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        }
        else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: (
              isConnecting ? Text('Conectando ' + widget.server.name + '...') :
              isConnected ? Text('Conectado à ' + widget.server.name) :
              Text('Desconectado')
          )
      ),
      body: Container(
        
      ),
    );
  }
}
