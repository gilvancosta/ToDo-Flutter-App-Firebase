import 'package:sqflite_common/sqlite_api.dart';

import 'migration_interface.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table teste1 (
        id Integer primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime 
  
      )
    ''');
  }

  @override
  void upgrade(Batch batch) {
    batch.execute('''
      create table teste2 (
        id Integer primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime 
  
      )
    ''');
  }
}
