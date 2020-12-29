import 'package:acionamento/backend/json/FunctionJson.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

FunctionJason _functionJason = new FunctionJason();

class Add{

  adicionarRele(String nome, String chave){
    Firestore.instance.collection("remoto").document().setData(({'nome': nome, 'chave': chave.toUpperCase(), 'estado': false}));
    _functionJason.addToDo(nome, chave);
  }

  Future<bool> validacao(String chave, VoidCallback existe, VoidCallback Nexiste) async {
    int cont = 0;
    QuerySnapshot snapshot = await Firestore.instance.collection("remoto").getDocuments();
    for(DocumentSnapshot doc in snapshot.documents){
      if(doc.data["chave"]==chave){
        cont++;
        existe();
      }
    }
    if(cont==0) Nexiste();
  }

  removeRele(String id, String chave)  {
    Firestore.instance.collection("remoto").document(id).delete();
    _functionJason.removeToDo(chave);
  }

}