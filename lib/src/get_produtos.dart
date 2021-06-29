import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mercado/models/produto_model.dart';
import 'package:http/http.dart' as http;
import 'package:mercado/src/add_produto.dart';
import 'package:mercado/src/atualiza_produto.dart';

import 'inicio.dart';

int id = 0;

class GetProdutos extends StatefulWidget {
  @override
  _GetProdutosState createState() => _GetProdutosState();

  GetProdutos({required int mercadoId}) {
    id = mercadoId;
  }
}

class _GetProdutosState extends State<GetProdutos> {
  List<ProdutoModel> produtos = [];
  Future<List<ProdutoModel>> getProdutos() async {
    produtos = [];
    var data =
        await http.get(Uri.parse('http://localhost:8080/getTodosProdutos/$id'));
    var jsonData = json.decode(data.body);

    for (var e in jsonData) {
      ProdutoModel produto = new ProdutoModel(
          preco: e['preco'],
          id: e['id'],
          nome: e['nome'],
          quantidade: e['quantidade']);
      produtos.add(produto);
    }

    return produtos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos Cadastrados nesta Empresa'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TelaInicio()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Container(
        child: FutureBuilder(
          future: getProdutos(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Nome')),
                  DataColumn(label: Text('Preco')),
                  DataColumn(label: Text('Quantidade')),
                ],
                rows: produtos
                    .map<DataRow>((e) => DataRow(cells: [
                          DataCell(Text(e.id.toString()), onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AtualizaProduto(
                                        auxId: e.id!,
                                        auxNome: e.nome!,
                                        auxPreco: e.preco!.toString(),
                                        auxQuantidade: e.quantidade!.toString(),
                                        auxMercadoId: id)));
                          }),
                          DataCell(Text(e.nome.toString()), onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AtualizaProduto(
                                        auxId: e.id!,
                                        auxNome: e.nome!,
                                        auxPreco: e.preco!.toString(),
                                        auxQuantidade: e.quantidade!.toString(),
                                        auxMercadoId: id)));
                          }),
                          DataCell(Text(e.preco.toString()), onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AtualizaProduto(
                                        auxId: e.id!,
                                        auxNome: e.nome!,
                                        auxPreco: e.preco!.toString(),
                                        auxQuantidade: e.quantidade!.toString(),
                                        auxMercadoId: id)));
                          }),
                          DataCell(Text(e.quantidade.toString()), onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AtualizaProduto(
                                        auxId: e.id!,
                                        auxNome: e.nome!,
                                        auxPreco: e.preco!.toString(),
                                        auxQuantidade: e.quantidade!.toString(),
                                        auxMercadoId: id)));
                          }),
                        ]))
                    .toList());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdicionaProduto(aux: id)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
