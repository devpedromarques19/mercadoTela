import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercado/src/get_mercados.dart';

class AdicionaMercado extends StatefulWidget {
  @override
  _AdicionaMercadoState createState() => _AdicionaMercadoState();
}

Future<void> registraMercado(
    String nome, String cnpj, BuildContext context) async {
  var url = 'http://localhost:8080/adicionaMercado';
  var response = await http.post(Uri.parse(url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{"nome": nome, "cnpj": cnpj}));

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            title: Text('Backend Response'), content: Text(response.body));
      });
}

class _AdicionaMercadoState extends State<AdicionaMercado> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController cnpjController = new TextEditingController();

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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
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
                await registraMercado(nome, cnpj, context);
                nomeController.text = '';
                cnpjController.text = '';
                setState(() {});
              },
              child: Text('Registrar!'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
            )
          ]),
        ));
  }
}
