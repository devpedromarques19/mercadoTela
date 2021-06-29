class ProdutoModel {
  int? id;
  String? nome;
  double? preco;
  int? quantidade;

  ProdutoModel({
    required this.id,
    required this.nome,
    required this.preco,
    this.quantidade = 0,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return new ProdutoModel(
        id: json['id'],
        nome: json['nome'],
        preco: json['preco'],
        quantidade: json['quantidade']);
  }

  Map<String, dynamic> toJson() =>
      {"id": id, "nome": nome, "preco": preco, "quantidade": quantidade};
}
