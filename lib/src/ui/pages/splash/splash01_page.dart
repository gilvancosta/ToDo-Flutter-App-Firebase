import 'package:flutter/material.dart';

import '../../../core/widgets/logo/app_logo_login_widget.dart';

class Splash01Page extends StatelessWidget {
  const Splash01Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogoLoginWidget(),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Login',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      )),
    );
  }
}
