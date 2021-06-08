import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conecta {
  static final Conecta _banco = new Conecta();

  factory Conecta() {
    return _banco;
  }

  static dataBaseManager() async {
    final int versiondb = 1;
    final pathDatabase = await getDatabasesPath();
    final localDatabase = join(pathDatabase, "aluguel.db");

    var connection = await openDatabase(localDatabase,
        version: versiondb, onCreate: Conecta._onCreate);

    return connection;
  }

  static OnDatabaseCreateFn _onCreate(db, versiondb) {
    db.execute("""
    CREATE TABLE aluguel (
      nome        VARCHAR(50),
      cpf         VARCHAR(16) PRIMARY KEY,
      idade       INT,
      valor       VARCHAR(30)
    )
    """);
  }
}
