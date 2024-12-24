import 'package:listfy/dao/ProdutoDao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDataBase() async {
  final String path = join(await getDatabasesPath(), "ListFy.db");
  return openDatabase(path, onCreate: (db, version) {
    db.execute(Produtodao.create);
  }, version: 1);
}
