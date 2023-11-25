import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_widget.dart';

import 'data/datasource/sqlite/sqlite_connection_factory.dart';

import 'domain/repositories/auth/login_repository.dart';
import 'domain/repositories/auth/login_repository_impl.dart';

import 'domain/services/user/user_service.dart';
import 'domain/services/user/user_service_impl.dart';

class MyApp extends StatelessWidget {
  final String title;

  const MyApp({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Object()),
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
            create: (_) => SqliteConnectionFactory(),
            lazy:
                false), // o lazy false faz com que o provider seja criado antes de qualquer coisa
        Provider<LoginRepository>(
            create: (context) =>
                LoginRepositoryImpl(firebaseAuth: context.read())),
        Provider<LoginService>(
            create: (context) =>
                LoginServiceImpl(loginRepository: context.read())),
        //  ChangeNotifierProvider(create: (context) => AuthProvider(firebaseAuth: context.read(), userService: context.read())..loadListener(), lazy: false)
      ],
      child: AppWidget(title: title),
    );
  }
}
