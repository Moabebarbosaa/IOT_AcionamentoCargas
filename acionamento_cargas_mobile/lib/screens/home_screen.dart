import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _quarto = false;
  bool _cozinha = false;
  bool _sala = false;
  bool _banheiro = false;

  final databaseReference = FirebaseDatabase.instance.reference();

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
                          Icon(
                            Icons.wifi_outlined,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.wifi_off_sharp,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      )
                    ],
                  ),
                )

              ],
            ),
            DraggableScrollableSheet(
              builder: (context, scrollController){
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 40, 30, 50),
                      child: Column(
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
                                            _quarto == true ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                                            color: _quarto == true ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
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
                                            value: _quarto,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _quarto = value;
                                                databaseReference.child("Leds").update({
                                                  'Quarto': _quarto == true ? "Q" : "q"
                                                });
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
                                            _sala == true ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                                            color: _sala == true ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
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
                                            value: _sala,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _sala = value;
                                                databaseReference.child("Leds").update({
                                                  'Sala': _sala == true ? "S" : "s"
                                                });
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
                                            _cozinha == true ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                                            color: _cozinha == true ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
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
                                            value: _cozinha,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _cozinha = value;
                                                databaseReference.child("Leds").update({
                                                  'Cozinha': _cozinha == true ? "C" : "c"
                                                });
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
                                            _banheiro == true ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                                            color: _banheiro == true ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
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
                                            value: _banheiro,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _banheiro = value;
                                                databaseReference.child("Leds").update({
                                                  'Banheiro': _banheiro == true ? "B" : "b"
                                                });
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
                      ),
                    ),
                    controller: scrollController,
                  ),
                );
              },
              initialChildSize: 0.70,
              minChildSize: 0.70,
              maxChildSize: 1,
            )
          ],
        ),
      ),
    );
  }
}