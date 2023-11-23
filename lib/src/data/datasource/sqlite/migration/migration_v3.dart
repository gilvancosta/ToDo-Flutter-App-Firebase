import 'package:sqflite_common/sqlite_api.dart';

import 'migration_interface.dart';

class MigrationV3 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table teste3 (
        id Integer primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime 
  
      )
    ''');
  }

  @override
  void upgrade(Batch batch) {
    batch.execute('''
      create table teste4 (
        id Integer primary key autoincrement,
        descricao varchar(500) not null,
        data_hora datetime 
  
      )
    ''');
  }
}
