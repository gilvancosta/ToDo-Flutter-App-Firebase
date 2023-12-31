import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_app_firebase/src/core/ui/theme/app_theme_extensions.dart';

import '../../../../../core/notifier/app_listener_notifier.dart';

import '../../../../../core/widgets/TextFormField/my_textformfield password_confirme.dart';
import '../../../../../core/widgets/TextFormField/my_textformfield_email.dart';
import '../../../../../core/widgets/TextFormField/my_textformfield_password.dart';
import '../../../../../core/widgets/logo/app_logo_login_widget.dart';
import 'controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    var defaultListner =
        AppListenerNotifier(changeNotifier: context.read<RegisterController>());
    defaultListner.listener(
      context: context,
      successVoidCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
        Navigator.of(context).pop();
      },

      //Esse atributo é opcional
      //errorCallback: (notifier, listenerInstance) {
      //  print('Deu Erro !!!!');
      //}
    );
    /*  context.read<RegisterController>().addListener(() {
      final controller = context.read<RegisterController>();
      var success = controller.success;
      var error = controller.error;
      if (success) {
        Navigator.of(context).pop();
      } else if (error != null && error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          ),
        );
      }
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // desabilita o botão de voltar
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: ClipOval(
            child: Container(
              color: context.primaryColor.withAlpha(20),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: context.primaryColor,
              ),
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Todo List',
              style: TextStyle(fontSize: 11, color: context.primaryColor),
            ),
            Text(
              'Cadastro',
              style: TextStyle(fontSize: 15, color: context.primaryColor),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              fit: BoxFit.fitHeight,
              child: AppLogoLoginWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  MyTextFormFieldEmail(
                    controller: _emailEC,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextFormFieldPassword(
                    controller: _passwordEC,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextFormFieldPasswordConfirme(
                    passwordEC: _passwordEC,
                    controller: _confirmPasswordEC,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            _formkey.currentState?.validate() ?? false;
                        if (formValid) {
                          final email = _emailEC.text;
                          final password = _passwordEC.text;

                          context
                              .read<RegisterController>()
                              .registerUser(email, password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Salvar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class My_TextFormField_General {}
