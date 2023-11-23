import 'package:flutter/material.dart';

class Splash00Page extends StatefulWidget {
  const Splash00Page({super.key});

  @override
  State<Splash00Page> createState() => _SplashPageState();
}

class _SplashPageState extends State<Splash00Page> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Page'),
      ),
    );
  }
}
