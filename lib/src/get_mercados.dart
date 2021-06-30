import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mercado/models/mercado_model.dart';
import 'package:http/http.dart' as http;
import 'package:mercado/src/add_mercado.dart';
import 'package:mercado/src/atualiza_mercado.dart';
import 'package:mercado/src/get_produtos.dart';
import 'package:mercado/src/inicio.dart';

class GetMercado extends StatefulWidget {
  @override
  _GetMercadoState createState() => _GetMercadoState();
}

class _GetMercadoState extends State<GetMercado> {
  List<MercadoModel> mercados = [];
  Future<List<MercadoModel>> getMercados() async {
    mercados = [];
    var data =
        await http.get(Uri.parse('http://localhost:8080/getTodosMercados'));
    var jsonData = json.decode(data.body);

    for (var e in jsonData) {
      MercadoModel mercado =
          new MercadoModel(cnpj: e['cnpj'], id: e['id'], nome: e['nome']);
      mercados.add(mercado);
    }

    return mercados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mercados Cadastrados'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TelaInicio()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      backgroundColor: Colors.blue.shade200,
      body: FutureBuilder(
        future: getMercados(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Nome')),
              DataColumn(label: Text('CNPJ')),
              DataColumn(label: Text('')),
            ],
            rows: mercados
                .map<DataRow>((e) => DataRow(cells: [
                      DataCell(Text(e.id.toString()), onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AtualizaMercado(
                                    auxId: e.id!,
                                    auxNome: e.nome!,
                                    auxCNPJ: e.cnpj!)));
                      }),
                      DataCell(Text(e.nome.toString()), onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AtualizaMercado(
                                    auxId: e.id!,
                                    auxNome: e.nome!,
                                    auxCNPJ: e.cnpj!)));
                      }),
                      DataCell(Text(e.cnpj.toString()), onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AtualizaMercado(
                                    auxId: e.id!,
                                    auxNome: e.nome!,
                                    auxCNPJ: e.cnpj!)));
                      }),
                      DataCell(
                          Text(
                            'Ver Produtos',
                            style: TextStyle(backgroundColor: Colors.black),
                          ), onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GetProdutos(mercadoId: e.id!)));
                      }),
                    ]))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdicionaMercado()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
      ),
    );
  }
}
