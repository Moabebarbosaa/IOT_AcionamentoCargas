import 'dart:io';

import 'package:acionamento_cargas_mobile_2/screens/components/custom_text.dart';
import 'package:acionamento_cargas_mobile_2/screens/local/local_screen.dart';
import 'package:acionamento_cargas_mobile_2/screens/remote/components/custom_card_remote.dart';
import 'package:acionamento_cargas_mobile_2/screens/remote/components/float_action_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RemoteScreen extends StatefulWidget {
  var box;
  RemoteScreen({this.box});

  @override
  _RemoteScreenState createState() => _RemoteScreenState(box);
}

class _RemoteScreenState extends State<RemoteScreen> {
  var box;
  _RemoteScreenState(this.box);

  final _favBox = Hive.box('reles');

  DatabaseReference _firebase =
      FirebaseDatabase.instance.reference().child("Leds");
  final databaseReference = FirebaseDatabase.instance.reference();

  Socket sock;
  bool verification = false;
  bool _connection = true;

  SpeechToText _speech;

  void showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.amber),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alerta = AlertDialog(
      title: Text("Erro Na Conexão Local"),
      content: Text("Conecte a mesma rede do ESP e reinicie o aplicativo."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  Future<bool> connect() async {
    try {
      // sock = await Socket.connect('192.168.1.58', 80,
      //     timeout: Duration(seconds: 1));
      verification = true;
      setState(() {
        _connection = false;
      });
      return true;
    } catch (_) {
      verification = false;
      showAlertDialog(context);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _speech = SpeechToText();
    _firebase.onValue.listen((event) {
      event.snapshot.value.forEach((k, v) {
        _favBox.put(k, v);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatActionButton(
        speech: _speech,
        favBox: _favBox,
        connection: _connection,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              color: Color(0xff2D2D2D),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Home",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Nome Sobrenome",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: _connection
                                  ? Color(0xffF5DF4D)
                                  : Color(0xff2D2D2D),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            height: 60,
                            width: 60,
                            child: IconButton(
                              icon: Icon(
                                Icons.wifi_outlined,
                                size: 40,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  _connection = true;
                                });
                                if (sock != null) sock.close();
                                var lista = _favBox.values.toList();
                                print(lista[0]);
                                print(lista[1]);
                                print(lista[2]);
                                databaseReference
                                    .child("Leds")
                                    .update({'Lampada': lista[0]});
                                databaseReference
                                    .child("Leds")
                                    .update({'Tomada': lista[2]});
                                databaseReference
                                    .child("Leds")
                                    .update({'Presenca': lista[1]});
                              },
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: _connection
                                  ? Color(0xff2D2D2D)
                                  : Color(0xffF5DF4D),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            height: 60,
                            width: 60,
                            child: IconButton(
                              icon: Icon(
                                Icons.wifi_off,
                                size: 40,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                connect();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 200),
              child: Container(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: _firebase.onValue,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              if (_connection == false) {
                                return LocalScreen(sock, _favBox);
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Color(0xffF5DF4D),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              );
                            default:
                              if (_connection == false) {
                                return LocalScreen(sock, _favBox);
                              }
                              return Column(
                                children: [
                                  CustomText(
                                    text: "REMOTO",
                                  ),
                                  Row(
                                    children: [
                                      CustomCard(
                                        nome: "Lâmpada",
                                        iconTrue: Icons.wb_incandescent_sharp,
                                        iconFalse:
                                            Icons.wb_incandescent_outlined,
                                        state: snapshot.data.snapshot
                                                    .value["Lampada"] ==
                                                "L"
                                            ? true
                                            : false,
                                        favBox: _favBox,
                                        sock: sock,
                                        connection: true,
                                      ),
                                      CustomCard(
                                        nome: "Tomada",
                                        iconTrue: Icons.battery_charging_full,
                                        iconFalse: Icons.battery_full_outlined,
                                        state: snapshot.data.snapshot
                                                    .value["Tomada"] ==
                                                "T"
                                            ? true
                                            : false,
                                        favBox: _favBox,
                                        sock: sock,
                                        connection: true,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      CustomCard(
                                        nome: "Sensor de Presença",
                                        iconTrue: Icons.home,
                                        iconFalse: Icons.home,
                                        state: snapshot.data.snapshot
                                                    .value["Presenca"] ==
                                                "P"
                                            ? true
                                            : false,
                                        favBox: _favBox,
                                        sock: sock,
                                        connection: true,
                                      ),
                                    ],
                                  )
                                ],
                              );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
