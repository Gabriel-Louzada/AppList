import 'package:listfy/data/database.dart';
import 'package:listfy/models/produtoModels.dart';

class Produtodao {
  static const String nomeTabela = 'Produtos';
  static const String id = 'id';
  static const String nome = 'nome';
  static const String valor = 'valor';
  static const String quantidade = 'quantidade';
  static const String pego = 'pego';
  static const String imagem = 'imagem';
  static const String categoria = 'categoria';
  static const String isAtivo = 'isAtivo';

//O PEGO IGUAL A 0 É O MESMO QUE FALSE IGUAL A 1 É O MESMO QUE VERDADEIRO
// ENTENDO QUE FALSE (0) O PRODUTO AINDA NÃO FOI PEGO

  static const String create = '''
  CREATE TABLE IF NOT EXISTS $nomeTabela(
  $id         INTEGER PRIMARY KEY AUTOINCREMENT,
  $nome       TEXT NOT NULL,
  $valor      REAL,
  $quantidade REAL,
  $pego       INTEGER,
  $imagem     TEXT,
  $categoria  TEXT,
  $isAtivo    INTEGER) 
 ''';

  Future<void> adicionarColunaImagem() async {
    try {
      final db = await getDataBase();
      const sql = '''ALTER TABLE $nomeTabela ADD COLUMN $imagem TEXT''';
      await db.execute(sql);
    } catch (error) {
      print("Erro: $error");
    }
  }

  Future<void> adicionarColunaCategoria() async {
    try {
      final db = await getDataBase();
      const sql = '''ALTER TABLE $nomeTabela ADD COLUMN $categoria TEXT''';
      await db.execute(sql);
    } catch (error) {
      print("Erro: $error");
    }
  }

  Future<void> adicionarColunaIsAtivo() async {
    try {
      final db = await getDataBase();
      const sql = '''ALTER TABLE $nomeTabela ADD COLUMN $isAtivo INTEGER''';
      await db.execute(sql);
    } catch (error) {
      print("Erro: $error");
    }
  }

//METODO PARA INSERIR OS DADOS
  Future<int> inserirProduto(ProdutoModel produto) async {
    final db = await getDataBase(); //ABRIR O BANCO DE DADOS
    const sqlInsert = '''
    INSERT INTO $nomeTabela($nome, $valor, $quantidade, $pego, $imagem, $categoria,$isAtivo) VALUES (?,?,?,?,?,?,?)
     '''; // SQL BRUTO PARA INSERÇÃO DE DADOS
    final resultado = await db.rawInsert(sqlInsert, [
      capitalize(produto.nome),
      produto.valor,
      produto.quantidade,
      produto.pego,
      produto.imagem,
      produto.categoria,
      produto.isAtivo
    ]); //INSERINDO OS DADOS E ARMAZENANDO O RETORNO EM UMA VARIAVEL O RETORNO É O ID DO PRODUTO
    return resultado;
  }

  Future<int> inserirProdutoPadrao() async {
    final db = await getDataBase(); //ABRIR O BANCO DE DADOS
    const sqlInsert = '''
    INSERT INTO $nomeTabela($nome, $valor, $quantidade, $pego, $imagem, $categoria,$isAtivo) VALUES
('Arroz', 1.00, 1, 0, "assets/icone_app.png","Mercearia",1),
('Feijão', 1.00, 1, 0, "assets/icone_app.png","Mercearia",1),
('Macarrão', 1.00, 1, 0, "assets/icone_app.png","Mercearia",1),
('Óleo de Soja', 1.00, 1, 0, "assets/icone_app.png","Mercearia",1),
('Açúcar', 1.00, 1, 0, "assets/icone_app.png","Mercearia",1),
('Café', 1.00, 1, 0, "assets/icone_app.png","Mercearia",1),
('Leite', 1.00, 6, 0, "assets/icone_app.png","Frios e laticínios",1),
('Farinha de Trigo', 1.00, 1, 0, "assets/icone_app.png","Mercearia",1),
('Sal', 1.00, 1, 0, "assets/icone_app.png","Mercearia",1),
('Carne Bovina', 1.00, 2, 0, "assets/icone_app.png","Carnes",1),
('Frango', 1.00, 2, 0, "assets/icone_app.png","Carnes",1),
('Ovos', 1.00, 12, 0, "assets/icone_app.png","Mercearia",1),
('Batata', 1.00, 3, 0, "assets/icone_app.png","Hortifrúti",1),
('Tomate', 1.00, 3, 0, "assets/icone_app.png","Hortifrúti",1),
('Cebola', 1.00, 2, 0, "assets/icone_app.png","Hortifrúti",1),
('Alho', 1.00, 1, 0, "assets/icone_app.png","Hortifrúti",1),
('Banana', 1.00, 6, 0, "assets/icone_app.png","Hortifrúti",1),
('Maçã', 1.00, 4, 0, "assets/icone_app.png","Hortifrúti",1),
('Sabonete', 1.00, 3, 0, "assets/icone_app.png","Limpeza e Higiene Pessoal",1),
('Detergente', 1.00, 1, 0, "assets/icone_app.png","Limpeza e Higiene Pessoal",1),
('Papel Higiênico', 1.00, 12, 0, "assets/icone_app.png","Limpeza e Higiene Pessoal",1),
('Creme Dental', 1.00, 1, 0, "assets/icone_app.png","Limpeza e Higiene Pessoal",1),
('Shampoo', 1.00, 1, 0, "assets/icone_app.png","Limpeza e Higiene Pessoal",1),
('Condicionador', 1.00, 1, 0, "assets/icone_app.png","Limpeza e Higiene Pessoal",1),
('Desinfetante', 1.00, 1, 0, "assets/icone_app.png","Limpeza e Higiene Pessoal",1);
     '''; // SQL BRUTO PARA INSERÇÃO DE DADOS
    final resultado = await db.rawInsert(sqlInsert);
    return resultado;
  }

  //METODO PARA LISTAR TODOS OS DADOS
  Future<List<ProdutoModel>> listarTodosProdutos() async {
    final db = await getDataBase(); // abrindo o banco de dados
    const sqlSelect =
        '''SELECT $id, $nome, $valor, $quantidade, $pego, $imagem, $categoria, $isAtivo FROM $nomeTabela WHERE $pego = 0 AND $isAtivo = 1 ORDER BY $nome''';
    final List<Map<String, dynamic>> resultado = await db.rawQuery(sqlSelect);
    List<ProdutoModel> produtos =
        resultado.map((map) => ProdutoModel.fromMap(map)).toList();
    return produtos;
  }

  //METODO PARA LISTAR TODOS OS DADOS pegos
  Future<List<ProdutoModel>> listarTodosProdutosPegos() async {
    final db = await getDataBase(); // abrindo o banco de dados
    const sqlSelect =
        '''SELECT $id, $nome, $valor, $quantidade, $pego, $imagem, $categoria, $isAtivo FROM $nomeTabela WHERE $pego = 1 AND $isAtivo = 1 ORDER BY $nome ''';
    final List<Map<String, dynamic>> resultado = await db.rawQuery(sqlSelect);
    List<ProdutoModel> produtos =
        resultado.map((map) => ProdutoModel.fromMap(map)).toList();
    return produtos;
  }

  //METODO PARA LISTAR TODOS OS DADOS pegos
  Future<List<ProdutoModel>> listarTodosProdutosDesativados() async {
    final db = await getDataBase(); // abrindo o banco de dados
    const sqlSelect =
        '''SELECT $id, $nome, $valor, $quantidade, $pego, $imagem, $categoria, $isAtivo FROM $nomeTabela WHERE $isAtivo = 0  ORDER BY $nome ''';
    final List<Map<String, dynamic>> resultado = await db.rawQuery(sqlSelect);
    List<ProdutoModel> produtos =
        resultado.map((map) => ProdutoModel.fromMap(map)).toList();
    return produtos;
  }

//METODO PARA ATUALIZAR O PRODUTO. não quero alterar o pego desta forma
  Future<int> alterarProduto(ProdutoModel produto) async {
    final db = await getDataBase();
    const sqlUpdate = '''
      UPDATE $nomeTabela 
         SET $nome = ?,
             $valor = ?,
             $quantidade = ?,
             $pego = ?,
             $imagem = ?,
             $categoria = ?,
             $isAtivo = ?
       WHERE $id = ?''';
    final retorno = await db.rawUpdate(sqlUpdate, [
      produto.nome,
      produto.valor,
      produto.quantidade,
      produto.pego,
      produto.imagem,
      produto.categoria,
      produto.isAtivo,
      produto.id,
    ]);
    return retorno;
  }

//METODO PARA ATUALIZAR O PRODUTO. onde altero apenas o pego
  Future<int> pegarProduto(ProdutoModel produto) async {
    final db = await getDataBase();
    const sqlUpdate = '''
      UPDATE $nomeTabela 
         SET $pego = 1
       WHERE $id = ?''';
    final retorno = await db.rawUpdate(sqlUpdate, [
      produto.id,
    ]);
    return retorno;
  }

//METODO PARA ATUALIZAR O PRODUTO. onde altero apenas o Ativo
  Future<int> ativarProduto(ProdutoModel produto) async {
    final db = await getDataBase();
    const sqlUpdate = '''
      UPDATE $nomeTabela 
         SET $isAtivo = 1
       WHERE $id = ?''';
    final retorno = await db.rawUpdate(sqlUpdate, [
      produto.id,
    ]);
    return retorno;
  }

  //METODO PARA ATUALIZAR O PRODUTO. onde altero apenas o Ativo
  Future<int> desativarProduto(int id) async {
    final db = await getDataBase();
    String sqlUpdate = '''
      UPDATE $nomeTabela 
         SET $isAtivo = 0
       WHERE id = ?''';
    final retorno = await db.rawUpdate(sqlUpdate, [
      id,
    ]);
    return retorno;
  }

//METODO PARA COLOCAR TODOS OS PRODUTOS NO CARRRINHO
  Future<int> pegarTodosProdutos() async {
    final db = await getDataBase();
    const sqlUpdate = '''
      UPDATE $nomeTabela
         SET $pego = 1''';
    final retorno = await db.rawUpdate(sqlUpdate, []);
    return retorno;
  }

//METODO PARA TIRAR TODOS OS PRODUTOS DO CARRINHO
  Future<int> voltarListaTodos() async {
    final db = await getDataBase();
    const sqlUpdate = '''
      UPDATE $nomeTabela
         SET $pego = 0''';
    final retorno = await db.rawUpdate(sqlUpdate, []);
    return retorno;
  }

//VOLTAR UM PRODUTO PARA A LISTA
  Future<int> voltaLista(ProdutoModel produto) async {
    final db = await getDataBase();
    const sqlUpdate = '''
      UPDATE $nomeTabela 
         SET $pego = 0
       WHERE $id = ?''';
    final retorno = await db.rawUpdate(sqlUpdate, [
      produto.id,
    ]);
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
