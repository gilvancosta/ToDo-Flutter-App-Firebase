import 'package:flutter/material.dart';

class AppLogoLoginWidget extends StatelessWidget {
  const AppLogoLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo.png', height: 200),
        const Text('My APP',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ))
      ],
    );
  }
}
