import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercado/src/get_mercados.dart';

int id = 0;
String nomeDeus = '';
String cnpjDeus = '';

class AtualizaMercado extends StatefulWidget {
  @override
  _AtualizaMercadoState createState() => _AtualizaMercadoState();

  AtualizaMercado(
      {required int auxId, required String auxNome, required String auxCNPJ}) {
    id = auxId;
    nomeDeus = auxNome;
    cnpjDeus = auxCNPJ;
  }
}

Future<void> atualizaMercado(
    int id, String nome, String cnpj, BuildContext context) async {
  var url = 'http://localhost:8080/atualizaMercado';
  var response = await http.put(Uri.parse(url),
      headers: <String, String>{"Content-Type": "application/json"},
      body:
          jsonEncode(<String, dynamic>{"id": id, "nome": nome, "cnpj": cnpj}));

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            title: Text('Backend Response'), content: Text(response.body));
      });
}

class _AtualizaMercadoState extends State<AtualizaMercado> {
  TextEditingController nomeController =
      new TextEditingController(text: nomeDeus);
  TextEditingController cnpjController =
      new TextEditingController(text: cnpjDeus);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo mercado"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GetMercado()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      backgroundColor: Colors.blue.shade200,
      body: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: ListView(children: [
          TextFormField(
            controller: nomeController,
            decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite o nome do mercado',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: TextFormField(
              controller: cnpjController,
              decoration: InputDecoration(
                  labelText: 'CNPJ',
                  hintText: 'Digite o CNPJ do mercado',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              String nome = nomeController.text;
              String cnpj = cnpjController.text;
              await atualizaMercado(id, nome, cnpj, context);
              nomeController.text = '';
              cnpjController.text = '';
              setState(() {});
            },
            child: Text('Atualizar!'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          await removerMercado(id, context);
          setState(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => GetMercado()));
          });
        },
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> removerMercado(int id, BuildContext context) async {
  var url = 'http://localhost:8080/removerMercado';
  await http.delete(Uri.parse(url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{"id": id}));
}
