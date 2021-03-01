import 'dart:async';
import 'dart:io';
import 'package:acionamento_cargas/screens/local_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class HomeScreen extends StatefulWidget {
  var box;
  HomeScreen(this.box);

  @override
  _HomeScreenState createState() => _HomeScreenState(box);
}


class _HomeScreenState extends State<HomeScreen> {
  var box;
  _HomeScreenState(this.box);

  final _favBox = Hive.box('reles');

  DatabaseReference _firebase = FirebaseDatabase.instance.reference().child('Leds');
  final databaseReference = FirebaseDatabase.instance.reference();

  Socket sock;
  bool verification =  false;

  bool _quarto = false;
  bool _cozinha = false;
  bool _sala = false;
  bool _banheiro = false;
  bool _connection = true;

  Timer timer;

  //List<dynamic> valor;

  @override
  void initState() {
    super.initState();
    _firebase.onValue.listen((event) {
      event.snapshot.value.forEach((k, v){
        _favBox.put(k, v);
      });
    });
  }
    //timer = Timer.periodic(Duration(seconds: 1), (Timer t) => atualizarDados());


  // void atualizarDados(){
  //   if(_connection) {
  //     valor = [];
  //
  //     _firebase.onValue.listen((event) {
  //       event.snapshot.value.forEach((k, v){
  //         _favBox.put(k, v);
  //       });
  //     });
  //   }
  //   setState(() {
  //     valor = _favBox.values.toList();
  //   });
  //   print(valor);
  // }


  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK", style: TextStyle(color: Colors.amber),),
      onPressed: () {Navigator.pop(context);},
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
      sock = await Socket.connect('192.168.1.58', 80, timeout: Duration(seconds: 1));
      verification = true;
      setState(() {
        _connection = false;
      });
      return true;
    } catch(_) {
      verification = false;
      showAlertDialog(context);
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(color: Color(0xff2D2D2D)),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20,40,20,40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Home",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.w900
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Nome Sobrenome",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: _connection ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                            ),
                            height: 60,
                            width: 60,
                            child: IconButton(
                              icon: Icon(Icons.wifi_outlined, size: 40,),
                              color: Colors.white,
                              onPressed: (){
                                setState(() {
                                  _connection = true;
                                });
                                if (sock != null) sock.close();
                                var lista = _favBox.values.toList();

                                databaseReference.child("Leds").update({
                                  'Banheiro': lista[0]
                                });
                                databaseReference.child("Leds").update({
                                  'Cozinha': lista[1]
                                });
                                databaseReference.child("Leds").update({
                                  'Quarto': lista[2]
                                });
                                databaseReference.child("Leds").update({
                                  'Sala': lista[3]
                                });

                                },
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: _connection ? Color(0xff2D2D2D) : Color(0xffF5DF4D),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                            ),
                            height: 60,
                            width: 60,
                            child: IconButton(
                              icon: Icon(Icons.wifi_off, size: 40,),
                              color: Colors.white,
                              onPressed: (){
                                connect();
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Container(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          child: StreamBuilder(
                            stream: _firebase.onValue,
                            builder: (context, snapshot){
                              switch(snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  if(_connection == false) {
                                    return LocalScreen(sock, _favBox);
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(backgroundColor: Color(0xffF5DF4D), valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
                                  );
                                default:
                                  if(_connection == false) {
                                    return LocalScreen(sock, _favBox);
                                  }
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                              child: Card(
                                                elevation: 15,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        snapshot.data.snapshot.value['Quarto'] == 'Q' ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                                                        color: snapshot.data.snapshot.value['Quarto'] == 'Q' ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
                                                        size: 60,
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Text(
                                                        'Quarto',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Color(0xff2D2D2D),
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      CupertinoSwitch(
                                                        activeColor: Color(0xffF5DF4D),
                                                        trackColor: Color(0xff2D2D2D),
                                                        value: snapshot.data.snapshot.value['Quarto'] == 'Q',
                                                        onChanged: (bool value) {
                                                          setState(() {
                                                            _quarto = value;
                                                            print("FIREBASE QUARTO");
                                                            databaseReference.child("Leds").update({
                                                              'Quarto': _quarto == true ? "Q" : "q"
                                                            });
                                                            _favBox.put("Quarto", _quarto ? "Q" : "q");
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ),
                                          SizedBox(width: 10,),
                                          Expanded(
                                              child: Card(
                                                elevation: 15,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        snapshot.data.snapshot.value['Sala'] == 'S' ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                                                        color: snapshot.data.snapshot.value['Sala'] == 'S' ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
                                                        size: 60,
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Text(
                                                        'Sala',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Color(0xff2D2D2D),
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      CupertinoSwitch(
                                                        activeColor: Color(0xffF5DF4D),
                                                        trackColor: Color(0xff2D2D2D),
                                                        value: snapshot.data.snapshot.value['Sala'] == 'S',
                                                        onChanged: (bool value) {
                                                          setState(() {
                                                            _sala = value;
                                                            databaseReference.child("Leds").update({
                                                              'Sala': _sala == true ? "S" : "s"
                                                            });
                                                            _favBox.put("Sala", _sala ? "S" : "s");
                                                            print("FIREBASE SALA");
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                      SizedBox(height:5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                              child: Card(
                                                elevation: 15,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        snapshot.data.snapshot.value['Cozinha'] == 'C' ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                                                        color: snapshot.data.snapshot.value['Cozinha'] == 'C' ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
                                                        size: 60,

                                                      ),
                                                      SizedBox(height: 10,),
                                                      Text(
                                                        'Cozinha',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Color(0xff2D2D2D),
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      CupertinoSwitch(
                                                        activeColor: Color(0xffF5DF4D),
                                                        trackColor: Color(0xff2D2D2D),
                                                        value: snapshot.data.snapshot.value['Cozinha'] == 'C',
                                                        onChanged: (bool value) {
                                                          setState(() {
                                                            _cozinha = value;
                                                            databaseReference.child("Leds").update({
                                                              'Cozinha': _cozinha == true ? "C" : "c"
                                                            });
                                                            _favBox.put("Cozinha", _cozinha ? "C" : "c");
                                                            print("FIREBASE COZINHA");
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ),
                                          SizedBox(width: 10,),
                                          Expanded(
                                              child: Card(
                                                elevation: 15,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(20),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        snapshot.data.snapshot.value['Banheiro'] == 'B' ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                                                        color: snapshot.data.snapshot.value['Banheiro'] == 'B' ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
                                                        size: 60,
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Text(
                                                        'Banheiro',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Color(0xff2D2D2D),
                                                            fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      CupertinoSwitch(
                                                        activeColor: Color(0xffF5DF4D),
                                                        trackColor: Color(0xff2D2D2D),
                                                        value: snapshot.data.snapshot.value['Banheiro'] == 'B',
                                                        onChanged: (bool value) {
                                                          setState(() {
                                                            _banheiro = value;
                                                            databaseReference.child("Leds").update({
                                                              'Banheiro': _banheiro == true ? "B" : "b"
                                                            });
                                                            _favBox.put("Banheiro", _banheiro ? "B" : "b");
                                                            print("FIREBASE BANHEIRO");
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                              }
                            },
                          )
                      )
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}