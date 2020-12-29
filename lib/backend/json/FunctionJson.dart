import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FunctionJason{

  List _toDoList = [];

  getToDoList(){
    return _toDoList;
  }

  setToDoList(List lista) {
    _toDoList = lista;
  }

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> saveData() async {
    String data = json.encode(_toDoList);

    final file = await getFile();
    return file.writeAsString(data);
  }

  Future<String> readData() async {
    try {
      final file = await getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  void addToDo(String nome, String chave) {
    Map<String, dynamic> newToDo = Map();
    newToDo["nome"] = nome;
    newToDo["chave"] = chave;
    _toDoList.add(newToDo);
    saveData();
  }

  void removeToDo(String chave) {
    for(int i=0; i<_toDoList.length;i++){
      if (_toDoList[i]['chave'] == chave) {
        _toDoList.removeAt(i);
        saveData();
      }
    }
  }

  void acionamento(String chave) {
    
  }

}