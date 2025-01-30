class ItenslistaModel {
  final int? idItemLista;
  final int? idLista;
  final int? idProduto;
  final double quantidade;
  final double valor;
  final int? pego;

  ItenslistaModel(
      {this.idItemLista,
      this.idLista,
      this.idProduto,
      required this.quantidade,
      required this.valor,
      this.pego});

  Map<String, dynamic> toMap() {
    return {
      'idItemLista': idItemLista,
      'idLista': idLista,
      'idProduto': idProduto,
      'quantidade': quantidade,
      'valor': valor,
      'pego': pego
    };
  }

  factory ItenslistaModel.fromMap(Map<String, dynamic> map) {
    return ItenslistaModel(
        idItemLista: map['idItemLista'],
        idLista: map['idLista'],
        idProduto: map['idProduto'],
        quantidade: map['quantidade'],
        valor: map['valor'],
        pego: map['pego']);
  }

  @override
  String toString() {
    return 'ItensListaModel(idItemLista: $idItemLista, idLista: $idLista, idProduto: $idProduto, quantidade: $quantidade, valor: $valor, pego: $pego)';
  }
}
