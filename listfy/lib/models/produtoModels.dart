class ProdutoModel {
  final int? id;
  final String nome;
  final double valor;
  final double quantidade;
  final int? pego;
  bool isChecked = false; // esse cara tem a ver com a seleção de produtos
  String? imagem;

  ProdutoModel(
      {this.id,
      required this.nome,
      required this.valor,
      required this.quantidade,
      this.pego,
      this.imagem});

//CONVERTE OS PRODUTOS EM UM MAP DE PRODUTOS
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
      'quantidade': quantidade,
      'pego': pego,
      'imagem': imagem
    };
  }

//CONVERTE O MAP DE PRODUTOS EM UM PRODUTOMODEL
  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['id'],
      nome: map['nome'],
      valor: map['valor'],
      quantidade: map['quantidade'],
      pego: map['pego'],
      imagem: map['imagem'],
    );
  }

//CONVERTE OS PRODUTOS EM UMA STRING
  @override
  String toString() {
    return 'ProdutoModel(id: $id, nome: $nome, valor: $valor, quantidade: $quantidade, pego: $pego, isChecked: $isChecked, imagem: $imagem)';
  }
}
