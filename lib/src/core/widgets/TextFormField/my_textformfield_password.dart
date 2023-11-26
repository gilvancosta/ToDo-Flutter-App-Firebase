import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../ui/theme/app_icons.dart';


class MyTextFormFieldPassword extends StatelessWidget {

  final bool obscureText;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  MyTextFormFieldPassword({
    Key? key, 
    this.obscureText = true,
    this.controller,
    this.validator,
    this.focusNode,
  })  : obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator:  Validatorless.multiple([
                      Validatorless.required('Senha obrigatória'),
                      Validatorless.min(
                          6, 'Senha deve ter pelo menos 6 caracteres'),
                    ]),
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText:  'Password',
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon:  IconButton(
                        icon: Icon(
                          !obscureTextValue ? AppIcons.eye_slash : AppIcons.eye,
                          size: 15,
                        ),
                        onPressed: () {
                          obscureTextVN.value = !obscureTextValue;
                        },
                      ),
          ),
          obscureText: obscureTextValue,
        );
      },
    );
  }
}
