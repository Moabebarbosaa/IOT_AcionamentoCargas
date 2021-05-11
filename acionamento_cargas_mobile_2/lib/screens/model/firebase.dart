import 'package:firebase_database/firebase_database.dart';

class Firebase {
  DatabaseReference _firebase =
      FirebaseDatabase.instance.reference().child("Leds");

  final databaseRefence = FirebaseDatabase.instance.reference();

  void setState(bool value, String name, bool connection, var favBox) {
    if (connection) {
      if (name == 'Sensor de Presença')
        _firebase.update({"Presenca": value ? "P" : "p"});
      else if (name == 'Lâmpada')
        _firebase.update({"Lampada": value ? "L" : "l"});
      else if (name == 'Tomada')
        _firebase.update({"Tomada": value ? "T" : "t"});
    }

    favBox.put("Lampada", value ? "L" : "l");
    favBox.put("Presenca", value ? "P" : "p");
    favBox.put("Tomada", value ? "T" : "t");
  }
}
