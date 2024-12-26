import 'package:listfy/data/database.dart';
import 'package:listfy/models/produtoModels.dart';

class Produtodao {
  static const String nomeTabela = 'Produtos';
  static const String id = 'id';
  static const String nome = 'nome';
  static const String valor = 'valor';
  static const String quantidade = 'quantidade';
  static const String pego = 'pego';

//O PEGO IGUAL A 0 É O MESMO QUE FALSE IGUAL A 1 É O MESMO QUE VERDADEIRO
// ENTENDO QUE FALSE (0) O PRODUTO AINDA NÃO FOI PEGO

  static const String create = '''
  CREATE TABLE IF NOT EXISTS $nomeTabela(
  $id         INTEGER PRIMARY KEY AUTOINCREMENT,
  $nome       TEXT NOT NULL,
  $valor      REAL,
  $quantidade REAL,
  $pego       INTEGER) 
 ''';

//METODO PARA INSERIR OS DADOS
  Future<int> inserirProduto(ProdutoModel produto) async {
    final db = await getDataBase(); //ABRIR O BANCO DE DADOS
    const sqlInsert = '''
    INSERT INTO $nomeTabela($nome, $valor, $quantidade, $pego) VALUES (?,?,?,0)
     '''; // SQL BRUTO PARA INSERÇÃO DE DADOS
    final resultado = await db.rawInsert(sqlInsert, [
      capitalize(produto.nome),
      produto.valor,
      produto.quantidade
    ]); //INSERINDO OS DADOS E ARMAZENANDO O RETORNO EM UMA VARIAVEL O RETORNO É O ID DO PRODUTO
    return resultado;
  }

  Future<int> inserirProdutoPadrao() async {
    final db = await getDataBase(); //ABRIR O BANCO DE DADOS
    const sqlInsert = '''
    INSERT INTO $nomeTabela($nome, $valor, $quantidade, $pego) VALUES
('Arroz', 1.00, 1, 0),
('Feijão', 1.00, 1, 0),
('Macarrão', 1.00, 1, 0),
('Óleo de Soja', 1.00, 1, 0),
('Açúcar', 1.00, 1, 0),
('Café', 1.00, 1, 0),
('Leite', 1.00, 6, 0),
('Farinha de Trigo', 1.00, 1, 0),
('Sal', 1.00, 1, 0),
('Carne Bovina', 1.00, 2, 0),
('Frango', 1.00, 2, 0),
('Ovos', 1.00, 12, 0),
('Batata', 1.00, 3, 0),
('Tomate', 1.00, 3, 0),
('Cebola', 1.00, 2, 0),
('Alho', 1.00, 1, 0),
('Banana', 1.00, 6, 0),
('Maçã', 1.00, 4, 0),
('Sabonete', 1.00, 3, 0),
('Detergente', 1.00, 1, 0),
('Papel Higiênico', 1.00, 12, 0),
('Creme Dental', 1.00, 1, 0),
('Shampoo', 1.00, 1, 0),
('Condicionador', 1.00, 1, 0),
('Desinfetante', 1.00, 1, 0);
     '''; // SQL BRUTO PARA INSERÇÃO DE DADOS
    final resultado = await db.rawInsert(sqlInsert);
    return resultado;
  }

  //METODO PARA LISTAR TODOS OS DADOS
  Future<List<ProdutoModel>> listarTodosProdutos() async {
    final db = await getDataBase(); // abrindo o banco de dados
    const sqlSelect =
        '''SELECT $id, $nome, $valor, $quantidade, $pego FROM $nomeTabela WHERE $pego = 0 ORDER BY $nome''';
    final List<Map<String, dynamic>> resultado = await db.rawQuery(sqlSelect);
    List<ProdutoModel> produtos =
        resultado.map((map) => ProdutoModel.fromMap(map)).toList();
    print(produtos);
    return produtos;
  }

  //METODO PARA LISTAR TODOS OS DADOS pegos
  Future<List<ProdutoModel>> listarTodosProdutosPegos() async {
    final db = await getDataBase(); // abrindo o banco de dados
    const sqlSelect =
        '''SELECT $id, $nome, $valor, $quantidade, $pego FROM $nomeTabela WHERE $pego = 1  ORDER BY $nome ''';
    final List<Map<String, dynamic>> resultado = await db.rawQuery(sqlSelect);
    List<ProdutoModel> produtos =
        resultado.map((map) => ProdutoModel.fromMap(map)).toList();
    print("Produto pegos dentro do dao");
    print(produtos);
    return produtos;
  }

//METODO PARA ATUALIZAR O PRODUTO. não quero alterar o pego desta forma
  Future<int> alterarProduto(ProdutoModel produto) async {
    final db = await getDataBase();
    const sqlUpdate = '''
      UPDATE $nomeTabela 
         SET $nome = ?,
             $valor = ?,
             $quantidade = ?
       WHERE $id = ?''';
    final retorno = await db.rawUpdate(sqlUpdate, [
      produto.nome,
      produto.valor,
      produto.quantidade,
      produto.id,
    ]);
    return retorno;
  }

//METODO PARA ATUALIZAR O PRODUTO. onde altero apenas o pego
  Future<int> pegarProduto(ProdutoModel produto) async {
    final db = await getDataBase();
    print(produto);
    const sqlUpdate = '''
      UPDATE $nomeTabela 
         SET $pego = 1
       WHERE $id = ?''';
    final retorno = await db.rawUpdate(sqlUpdate, [
      produto.id,
    ]);
    print(produto);
    return retorno;
  }

  Future<int> voltarCarrinho(ProdutoModel produto) async {
    final db = await getDataBase();
    print(produto);
    const sqlUpdate = '''
      UPDATE $nomeTabela 
         SET $pego = 0
       WHERE $id = ?''';
    final retorno = await db.rawUpdate(sqlUpdate, [
      produto.id,
    ]);
    print(produto);
    return retorno;
  }

//METODO PARA DELETAR O PRODUTO
  Future<int> removerProduto(int id) async {
    final db = await getDataBase();
    const sqlDelete = '''DELETE FROM $nomeTabela WHERE id = ? ''';
    final resultado = await db.rawDelete(sqlDelete, [id]);
    return resultado;
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}
