import 'package:listfy/data/database.dart';
import 'package:listfy/models/listaModels.dart';

class ListaDao {
  static const String nomeTabela = 'Lista';
  static const String id = 'id';
  static const String nomeLista = 'nomeLista';
  static const String estabelecimento = 'estabelecimento';

  static const String create = '''
  CREATE TABLE IF NOT EXISTS $nomeTabela(
  $id              INTEGER PRIMARY KEY AUTOINCREMENT,
  $nomeLista       TEXT NOT NULL,
  $estabelecimento TEXT
  )''';

  Future<int> insertLista(ListaModels lista) async {
    final db = await getDataBase();
    const sqlInsert = '''
    INSERT INTO $nomeLista($nomeLista, $estabelecimento) VALUES(?,?)
 ''';
    final resultado =
        await db.rawInsert(sqlInsert, [lista.nomeLista, lista.estabelecimento]);
    return resultado;
  }

  Future<List<ListaModels>> listarTodasListas() async {
    final db = await getDataBase();
    const sqlSelect = '''
    SELECT $id, $nomeLista, $estabelecimento FROM $nomeTabela ORDER BY $nomeLista''';
    final List<Map<String, dynamic>> resultado = await db.rawQuery(sqlSelect);
    List<ListaModels> listas =
        resultado.map((map) => ListaModels.fromMap(map)).toList();
    return listas;
  }

  Future<int> alterarLista(ListaModels lista) async {
    final db = await getDataBase();
    const sqlUpdate = '''
    UPDATE $nomeTabela
       SET $nomeLista = ?,
           $estabelecimento = ?
     WHERE $id = ?''';
    final retorno = await db.rawUpdate(
        sqlUpdate, [lista.nomeLista, lista.estabelecimento, lista.id]);
    return retorno;
  }

  Future<int> removerLista(int id) async {
    final db = await getDataBase();
    const sqlDelete = ''' DELETE FROM $nomeTabela WHERE id = ? ''';
    final resultado = await db.rawDelete(sqlDelete, [id]);
    return resultado;
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}
