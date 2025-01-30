class ListaModels {
  final int? id;
  final String nomeLista;
  final String? estabelecimento;

  ListaModels({this.id, required this.nomeLista, this.estabelecimento});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeLista': nomeLista,
      'estabelecimento': estabelecimento
    };
  }

  factory ListaModels.fromMap(Map<String, dynamic> map) {
    return ListaModels(
        id: map['id'],
        nomeLista: map['nomeLista'],
        estabelecimento: map['estabelecimento']);
  }

  @override
  String toString() {
    return 'ListaModels(id: $id, nomeLista: $nomeLista, estabelecimento: $estabelecimento)';
  }
}
