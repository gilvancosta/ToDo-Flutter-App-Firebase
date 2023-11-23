import 'package:flutter/material.dart';

import 'core/ui/theme/app_themev2.dart';
import 'data/datasource/sqlite/sqlite_adm_connection.dart';

import 'domain/modules/user/user_module.dart';
import 'ui/pages/splash/splash01_page.dart';

class AppWidget extends StatefulWidget {
  final String title;
  const AppWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<AppWidget> createState() => _MyAppState();
}

class _MyAppState extends State<AppWidget> {
  var sqliteAdmConnection = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();

    // FirebaseAuth auth = FirebaseAuth.instance;

    WidgetsBinding.instance.addObserver(
        sqliteAdmConnection); // adicionando o ciclo de vida na aplicação
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: MyAppThemeV2.theme,
      // initialRoute: '/login',
      routes: {
        ...UserModule().routers,
      },
      home: const Splash01Page(),
    );
  }
}
