import 'package:flutter/material.dart';

class AddReleScreen extends StatelessWidget {

  showAlertDialog2(BuildContext context) {
    Widget cancelaButton = FlatButton(
      child: Text("Cancelar"),
      onPressed:  () {},
    );
    Widget continuaButton = FlatButton(
      child: Text("Continar"),
      onPressed:  () {},
    );
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Deseja continuar aprendendo Flutter ?"),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
