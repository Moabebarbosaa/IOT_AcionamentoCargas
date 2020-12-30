import 'package:acionamento/backend/blue/FunctionBluetooth.dart';
import 'package:acionamento/backend/json/FunctionJson.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


FunctionJason _functionJason = new FunctionJason();
//FunctionBluetooth _functionBluetooth = new FunctionBluetooth(connection);

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //
  //   _functionJason.readData().then((data) {
  //     setState(() {
  //       _functionJason.setToDoList(json.decode(data));
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
            "Acionamento Bluetooth"
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _functionJason.getToDoList().length,
              itemBuilder: buildItem),),
        ],
      )
    );
  }

  Widget buildItem(BuildContext context, int index){
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _functionJason.getToDoList()[index]['nome'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Chave: " + _functionJason.getToDoList()[index]['chave'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    ),
                  ),
                ],
              ),
              FlatButton(
                child:  Icon(
                  _functionJason.getToDoList()[index]['chave'] ==
                      _functionJason.getToDoList()[index]['chave'].toUpperCase() ?
                  Icons.wb_incandescent : Icons.wb_incandescent_outlined,
                  color:_functionJason.getToDoList()[index]['chave'] ==
                      _functionJason.getToDoList()[index]['chave'].toUpperCase() ?
                  Colors.amber : Colors.white,
                  size: 100,
                ),
                onPressed: (){
                  setState(() {
                    _functionJason.refreshState(_functionJason.getToDoList()[index]['chave']);
                    //  print(_functionJason.getToDoList());
                    //  _functionJason.setToDoList([]);
                    // _functionJason.saveData();
                    // print(_functionJason.getToDoList());
                  });
                },
              )
            ],
          ),
          SizedBox(height: 30,),
        ],
      ),
    );
  }
}
