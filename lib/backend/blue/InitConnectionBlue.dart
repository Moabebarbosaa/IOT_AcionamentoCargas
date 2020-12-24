import 'package:acionamento/screens/blue/BluetoothControl.dart';
import 'package:acionamento/screens/blue/SelectBondedDevicePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

class StartConnection{

  BuildContext context;

  StartConnection(this.context);

  start()async{

    await FlutterBluetoothSerial.instance.requestEnable();
    final BluetoothDevice selectedDevice = await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) { return SelectBondedDevicePage(checkAvailability: false); })
    );
    if (selectedDevice != null) {
      print('Connect -> selected ' + selectedDevice.address);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) { return BluetoothControl(server: selectedDevice); }));
    }
    else {
      print('Connect -> no device selected');
    }

  }

}