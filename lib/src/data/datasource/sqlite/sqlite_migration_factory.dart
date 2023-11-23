
import 'migration/migration_interface.dart';
import 'migration/migration_v1.dart';
import 'migration/migration_v2.dart';
import 'migration/migration_v3.dart';

class SqliteMigrationFectory {
  // Tera todas as migrations
  List<Migration> getCreateMigration() => [
        MigrationV1(),
        MigrationV2(),
        //  MigrationV3(),
      ];

  List<Migration> getUpgradeMigration(int version) {
    final migrations = <Migration>[];

    // tera a 2 e 3
    if (version == 1) {
      migrations.add(MigrationV2());
      migrations.add(MigrationV3()); 
    
    }

    // tera somente a 3
    if (version == 2) {
       migrations.add(MigrationV3());
    }

    return migrations;
  }
}


