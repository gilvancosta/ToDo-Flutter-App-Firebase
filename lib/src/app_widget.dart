import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/navigator/todo_list_navigator.dart';
import 'core/ui/theme/app_theme.dart';
import 'data/datasource/sqlite/sqlite_adm_connection.dart';

import 'domain/modules/auth/auth_module.dart';
import 'domain/modules/home_module.dart';
import 'domain/modules/tasks/tasks_module.dart';
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
      navigatorKey: TodoListNavigator.navigatorKey,
      initialRoute: '/login',
      title: 'Todo List',
      theme: MyAppTheme.theme,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TasksModule().routers,
      },
      home: const Splash01Page(),
    );
  }
}
