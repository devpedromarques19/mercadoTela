import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'get_produtos.dart';

int id = 0;

class AdicionaProduto extends StatefulWidget {
  @override
  _AdicionaProdutoState createState() => _AdicionaProdutoState();

  AdicionaProduto({required int aux}) {
    id = aux;
  }
}

Future<void> registraProduto(String nome, String preco, String quantidade,
    int mercadoId, BuildContext context) async {
  var url = 'http://localhost:8080/adicionaProduto';
  var response = await http.post(Uri.parse(url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "nome": nome,
        "preco": preco,
        "quantidade": quantidade,
        "mercado_id": mercadoId
      }));

  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            title: Text('Backend Response'), content: Text(response.body));
      });
}

class _AdicionaProdutoState extends State<AdicionaProduto> {
  TextEditingController nomeController = new TextEditingController();
  TextEditingController precoController = new TextEditingController();
  TextEditingController quantidadeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produto"),
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetProdutos(mercadoId: id)));
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
                  hintText: 'Digite o nome do produto',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: TextFormField(
                controller: precoController,
                decoration: InputDecoration(
                    labelText: 'Preco',
                    hintText: 'Digite o preco do mercado',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: TextFormField(
                controller: quantidadeController,
                decoration: InputDecoration(
                    labelText: 'Quantidade',
                    hintText: 'Digite a quantidade disponivel do mercado',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String nome = nomeController.text;
                String preco = precoController.text;
                String quantidade = quantidadeController.text;

                await registraProduto(nome, preco, quantidade, id, context);
                nomeController.text = '';
                precoController.text = '';
                quantidadeController.text = '';
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
