import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../ui/theme/app_icons.dart';
import '../../validators/validators.dart';


class MyTextFormFieldPasswordConfirme extends StatelessWidget {
 final  TextEditingController? passwordEC;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
 //final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  MyTextFormFieldPasswordConfirme({
    Key? key,
    this.passwordEC,
    this.suffixIconButton,
    this.obscureText = false,
    this.controller,
 
    this.focusNode,
  })  : assert(
          obscureText == true ? suffixIconButton == null : true,
          'ObscureText não pode ser enviado em conjunto com suffixIconButtom',
        ),
        obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validators.compare(
                          passwordEC, 'Confirmação de senha é diferente'),
                    ]),
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Confirmar Senha',
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        icon: Icon(
                          !obscureTextValue ? AppIcons.eye_slash : AppIcons.eye,
                          size: 15,
                        ),
                        onPressed: () {
                          obscureTextVN.value = !obscureTextValue;
                        },
                      )
                    : null),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}
