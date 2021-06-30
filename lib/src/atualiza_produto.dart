import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercado/src/get_produtos.dart';

int id = 0;
String nomeDeus = '';
String precoDeus = '';
String quantidadeDeus = '';
int mercadoId = 0;

class AtualizaProduto extends StatefulWidget {
  @override
  _AtualizaProdutoState createState() => _AtualizaProdutoState();

  AtualizaProduto(
      {required int auxId,
      required String auxNome,
      required String auxPreco,
      required String auxQuantidade,
      required int auxMercadoId}) {
    id = auxId;
    nomeDeus = auxNome;
    precoDeus = auxPreco;
    quantidadeDeus = auxQuantidade;
    mercadoId = auxMercadoId;
  }
}

Future<void> atualizaProduto(int id, String nome, String preco,
    String quantidade, int mercadoId, BuildContext context) async {
  var url = 'http://localhost:8080/atualizaProduto';
  var response = await http.put(Uri.parse(url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        "id": id,
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

class _AtualizaProdutoState extends State<AtualizaProduto> {
  TextEditingController nomeController =
      new TextEditingController(text: nomeDeus);
  TextEditingController precoController =
      new TextEditingController(text: precoDeus);
  TextEditingController quantidadeController =
      new TextEditingController(text: quantidadeDeus);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atualiza Produto"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetProdutos(mercadoId: mercadoId)));
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
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
              await atualizaProduto(
                  id, nome, preco, quantidade, mercadoId, context);
              nomeController.text = '';
              precoController.text = '';
              quantidadeController.text = '';
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
          await removeProduto(id, context);
          setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GetProdutos(mercadoId: mercadoId)));
          });
        },
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> removeProduto(int id, BuildContext context) async {
  var url = 'http://localhost:8080/removerProduto';
  await http.delete(Uri.parse(url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{"id": id}));
}
