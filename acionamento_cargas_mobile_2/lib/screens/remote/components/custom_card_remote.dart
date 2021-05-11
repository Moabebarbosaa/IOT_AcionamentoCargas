import 'dart:io';

import 'package:acionamento_cargas_mobile_2/screens/components/custom_text.dart';
import 'package:acionamento_cargas_mobile_2/screens/model/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {this.nome,
      this.iconTrue,
      this.iconFalse,
      this.state,
      this.connection,
      this.sock,
      this.favBox});

  final Socket sock;
  var favBox;
  final String nome;
  final IconData iconTrue;
  final IconData iconFalse;
  final bool state;
  final bool connection;

  Firebase firebase = new Firebase();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 15,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              CustomText(
                text: nome,
                fontSize: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                state ? iconTrue : iconFalse,
                color: state ? Color(0xffF5DF4D) : Color(0xff2D2D2D),
                size: 60,
              ),
              SizedBox(
                height: 20,
              ),
              nome == "Sensor de Presença"
                  ? Container()
                  : CupertinoSwitch(
                      activeColor: Color(0xffF5DF4D),
                      trackColor: Color(0xff2D2D2D),
                      value: state,
                      onChanged: (bool value) {
                        firebase.setState(value, nome, connection, favBox);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
