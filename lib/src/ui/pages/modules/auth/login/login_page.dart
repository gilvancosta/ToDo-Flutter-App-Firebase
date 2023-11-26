import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../../core/notifier/app_listener_notifier.dart';
import '../../../../../core/ui/theme/app_messages.dart';

import '../../../../../core/widgets/TextFormField/my_textformfield_email.dart';
import '../../../../../core/widgets/TextFormField/my_textformfield_password.dart';
import '../../../../../core/widgets/logo/app_logo_login_widget.dart';
import 'controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    AppListenerNotifier(changeNotifier: context.read<LoginController>())
        .listener(
            context: context,
            everVoidCallback: (notifier, listenerInstance) {
              if (notifier is LoginController) {
                if (notifier.hasInfo) {
                  AppMessages.of(context).showInfo(notifier.infoMessage!);
                }
              }
            },
            successVoidCallback: (notifier, listenerNotifier) {
              print('Login efetuado com sucesso !!!!!');
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  // set height of login page
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      // logo
                      const AppLogoLoginWidget(),

                      // Form
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // email textfield
                              MyTextFormFieldEmail(
                                  controller: _emailEC, focusNode: _emailFocus),
                              const SizedBox(height: 20),
                              // password textfield
                              MyTextFormFieldPassword(
                                controller: _passwordEC,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // forgot password?
                                  TextButton(
                                    onPressed: () {
                                      if (_emailEC.text.isNotEmpty) {
                                        // Recuperar senha
                                        context
                                            .read<LoginController>()
                                            .forgotPassword(_emailEC.text);
                                      } else {
                                        _emailFocus.requestFocus();
                                        AppMessages.of(context).showError(
                                            'Digite um e-mail para recuperar a senha');
                                      }
                                    },
                                    child: const Text('Forgot password?'),
                                  ),

                                  // Login Buttom
                                  ElevatedButton(
                                    onPressed: () {
                                      final formValid =
                                          _formKey.currentState?.validate() ??
                                              false;

                                      if (formValid) {
                                        final email = _emailEC.text;
                                        final password = _passwordEC.text;

                                        context
                                            .read<LoginController>()
                                            .login(email, password);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Login'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffF0F3F7),
                            border: Border(
                              top: BorderSide(
                                width: 2,
                                color: Colors.grey.withAlpha(50),
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              // sign in button Google
                              // O SignInButton  (package) É um widget do pacote flutter_signin_button
                              SignInButton(
                                Buttons.Google,
                                text: 'Continue com Google',
                                padding: const EdgeInsets.all(5),
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                                onPressed: () {
                                  
                                  context.read<LoginController>().googleLogin();
                                },
                              ),

                              // or continue with
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Não tem conta?'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/register');
                                    },
                                    child: const Text('Cadastre-se'),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
    );
  }
}
