import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

import 'sqlite_migration_factory.dart';

/// Database connection factory for sqlite
/// possui o conceito de Singleton para que seja criada apenas uma instancia da classe
/// O objetivo é que seja criada apenas uma conexão com o banco de dados
/// deixar as conexões abertas pode causar problemas de performance e corromper os arquivos do banco de dados
///
class SqliteConnectionFactory {
  static const _version = 1;
  static const _databaseName = 'DB_TODO_LIST';

  static SqliteConnectionFactory? _instance;
  
 // Cria uma instancia do banco de dados para futuras verificações se está aberto ou não
  Database? _db;

  // é uma classe que permite que apenas uma thread execute o código por vez
  final _lock = Lock(); 

  // construtor privado
  SqliteConnectionFactory._();

  // factory é um construtor que retorna uma instancia da classe
  // somente é criada uma nova conexão quando não existe uma instancia da classe
  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();

    return _instance!;
  }

  Future<Database> openConnection() async {
    var databasePath =
        await getDatabasesPath(); //(package) é utilizado para pegar o caminho do banco de dados
    var databasePathFinal = join(databasePath,
        _databaseName); // o join é utilizado para juntar o caminho do banco de dados com o nome do banco de dados
    if (_db == null) {
      await _lock.synchronized(() async { // o _lock é utilizado para que apenas uma thread execute o código por vez
        _db ??= await openDatabase(
          databasePathFinal,
          version: _version,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onDowngrade: _onDowngrade,
        );
      });
    }

    return _db!;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFectory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }

    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFectory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.upgrade(batch);
    }

    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}

  void closeConnection() {
    _db?.close();
    _db = null;
  }
}
