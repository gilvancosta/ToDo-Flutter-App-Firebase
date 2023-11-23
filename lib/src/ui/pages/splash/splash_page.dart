import 'package:flutter/material.dart';
import '../../../core/widgets/logo/app_logo_login_widget.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

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
            child: const Text('Login'),
          ),
        ],
      )),
    );
  }
}
