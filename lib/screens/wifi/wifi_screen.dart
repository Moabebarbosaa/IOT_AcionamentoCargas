import 'package:acionamento/backend/add/add_reles.dart';
import 'package:acionamento/widget/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class WiFiScreen extends StatefulWidget {
  @override
  _WiFiScreenState createState() => _WiFiScreenState();
}

class _WiFiScreenState extends State<WiFiScreen> {

  final _nameController = TextEditingController();
  final _keyController = TextEditingController();
  final _chaveScaffold = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Add _add = new Add();

  VoidCallback existe(){
    _chaveScaffold.currentState.showSnackBar(SnackBar(
      content: Text("Essa chave ja foi cadastrada."),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 3),
    ));
    _nameController.text = "";
    _keyController.text = "";
  }

  VoidCallback Nexiste(){
    _add.adicionarRele(_nameController.text, _keyController.text);
    _chaveScaffold.currentState.showSnackBar(SnackBar(
      content: Text("Relé cadastrado com sucesso."),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    _nameController.text = "";
    _keyController.text = "";
  }

  showAlertDialog(BuildContext context) {
    Widget cancelaButton = FlatButton(
      child: Text(
        "Cancelar",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15
        ),
      ),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continuaButton = FlatButton(
      child: Text(
        "Adicionar",
        style: TextStyle(
            color: Colors.black,
            fontSize: 15
        ),
      ),
      onPressed:  () {
        if(_formKey.currentState.validate()){
          Navigator.pop(context);
        }
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Adicionar Relé"),
      content: Container(
        height: 200,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                  controller: _nameController,
                  hint: 'Nome',
                  textInputType: TextInputType.text,
                  prefix: Icon(
                    Icons.wb_incandescent_outlined,
                  ),
                  validator: (text) {
                    if (text.isEmpty)
                      return "Nome inválido";
                    else return null;
                  }
              ),
              SizedBox(height: 20,),
              CustomTextField(
                  controller: _keyController,
                  hint: 'Chave',
                  textInputType: TextInputType.text,
                  prefix: Icon(
                    Icons.vpn_key_outlined,
                  ),
                  validator: (text) {
                    _add.validacao( _keyController.text.toUpperCase(), existe, Nexiste);
                    if (text.isEmpty) return "Chave inválida";
                    else if (text.length > 2) return "Digite apenas 1 ou 2 caracteres";
                    else return null;
                  }
              )
            ],
          ),
        )
      ),
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
    return Scaffold(
      key: _chaveScaffold,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
            "Acionamento Remoto"
        ),
      ),
      body: Row(
        children: [
          Expanded(child: StreamBuilder(
              stream: Firestore.instance.collection("remoto").snapshots(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> documents = snapshot.data.documents;
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        documents[index].data['nome'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Text(
                                        'Chave: '+documents[index].data['chave'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),
                                  FlatButton(
                                    child:  Icon(
                                      documents[index].data['estado'] == false ? Icons.wb_incandescent_outlined : Icons.wb_incandescent,
                                        color: documents[index].data['estado'] == false ? Colors.white : Colors.yellow,
                                        size: 100,
                                      ),
                                    onPressed: (){
                                      setState(() {
                                        String id = documents[index].documentID;
                                        bool estado = documents[index].data['estado'];
                                        Firestore.instance.collection("remoto").document(id).updateData(({'estado': !estado}));
                                      });
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 30,),
                              Divider(
                                color: Colors.white,
                                thickness: 2,
                              )
                            ],
                          ),
                        );
                      }
                    );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.add_outlined,
          color: Colors.black,
          size: 40,
        ),
        onPressed: () {
          showAlertDialog(context);
        },

      ),
    );
  }
}


