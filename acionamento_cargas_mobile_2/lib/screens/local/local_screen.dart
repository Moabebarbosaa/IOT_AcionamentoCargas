import 'dart:io';

import 'package:acionamento_cargas_mobile_2/screens/components/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocalScreen extends StatefulWidget {
  Socket sock;
  var _favBox;
  LocalScreen(this.sock, this._favBox);

  @override
  _LocalScreenState createState() => _LocalScreenState(sock, _favBox);
}

class _LocalScreenState extends State<LocalScreen> {
  Socket sock;
  var _favBox;

  bool _lampada = false;
  bool _tomada = false;
  bool _presenca = false;

  @override
  void initState() {
    super.initState();

    var lista = _favBox.values.toList();

    lista[0] == "L" ? _lampada = true : _lampada = false;
    lista[2] == "T" ? _tomada = true : _tomada = false;
    lista[1] == "P" ? _presenca = true : _presenca = false;
  }

  _LocalScreenState(this.sock, this._favBox);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: "LOCAL",
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomText(
                        text: "Lâmpada",
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        _lampada
                            ? Icons.wb_incandescent_sharp
                            : Icons.wb_incandescent_outlined,
                        color: _lampada ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
                        size: 60,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CupertinoSwitch(
                        activeColor: Color(0xffF5DF4D),
                        trackColor: Color(0xff2D2D2D),
                        value: _lampada,
                        onChanged: (bool value) {
                          setState(() {
                            _lampada = value;
                            //sock.write(_lampada == true ? "L" : "l");
                            _favBox.put("Lampada", _lampada ? "L" : "l");
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomText(
                        text: "Tomada",
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        _tomada
                            ? Icons.battery_charging_full
                            : Icons.battery_full_outlined,
                        color: _tomada ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
                        size: 60,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CupertinoSwitch(
                        activeColor: Color(0xffF5DF4D),
                        trackColor: Color(0xff2D2D2D),
                        value: _tomada,
                        onChanged: (bool value) {
                          setState(() {
                            _tomada = value;
                            //sock.write(_tomada == true ? "T" : "t");
                            _favBox.put("Tomada", _tomada ? "T" : "t");
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CustomText(
                        text: "Sensor de Presença",
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        _presenca ? Icons.home : Icons.home_outlined,
                        color:
                            _presenca ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
                        size: 60,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
