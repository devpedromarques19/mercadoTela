import 'produto_model.dart';

class MercadoModel {
  int? id;
  String? nome;
  String? cnpj;
  List<ProdutoModel>? produtos;

  MercadoModel(
      {required this.id,
      required this.nome,
      required this.cnpj,
      this.produtos = const []});

  factory MercadoModel.fromJson(Map<String, dynamic> json) {
    return new MercadoModel(
        id: json['id'],
        cnpj: json['cnpj'],
        nome: json['nome'],
        produtos: json['produtos']);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "nome": nome, "cnpj": cnpj, "produtos": produtos};
}
