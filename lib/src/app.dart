
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';


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

        //  ChangeNotifierProvider(create: (context) => AuthProvider(firebaseAuth: context.read(), userService: context.read())..loadListener(), lazy: false)
      ],
      child: AppWidget(title: title),
    );
  }
}
