import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Add{

  adicionarRele(String nome, String chave){
    // if(_validacao(chave) != null){
    Firestore.instance.collection("remoto").document().setData(({'nome': nome, 'chave': chave.toUpperCase(), 'estado': false}));
    // }else{
    //   print("Ja existe");
    // }
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

}