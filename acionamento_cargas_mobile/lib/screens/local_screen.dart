import 'dart:io';
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
  _LocalScreenState(this.sock, this._favBox);

  bool _quarto = false;
  bool _cozinha = false;
  bool _sala = false;
  bool _banheiro = false;


  @override
  void initState() {
    super.initState();

    var lista = _favBox.values.toList();

    lista[0] == "B" ? _banheiro = true : _banheiro = false;
    lista[1] == "C" ? _cozinha = true : _cozinha = false;
    lista[2] == "Q" ? _quarto = true : _quarto = false;
    lista[3] == "S" ? _sala = true : _sala = false;

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Card(
                  elevation: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          _quarto ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                          color: _quarto ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
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
                              sock.write(_quarto == true ? "Q" : "q");
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
                          _sala ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                          color: _sala ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
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
                              sock.write(_sala ? "S" : "s");
                              _favBox.put("Sala", _sala ? "S" : "s");
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
        SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Card(
                  elevation: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          _cozinha ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                          color: _cozinha ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
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
                              sock.write(_cozinha == true ? "C" : "c");
                              _favBox.put("Cozinha", _cozinha ? "C" : "c");
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
                          _banheiro ? Icons.wb_incandescent_sharp : Icons.wb_incandescent_outlined,
                          color: _banheiro ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
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
                              sock.write(_banheiro ? "B" : "b");
                              _favBox.put("Banheiro", _banheiro ? "B" : "b");
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )
            ),

          ],
        )
      ],
    );
  }


}
