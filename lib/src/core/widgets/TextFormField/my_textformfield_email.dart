import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../ui/theme/app_icons.dart';

class MyTextFormFieldEmail extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;

  const MyTextFormFieldEmail({
    Key? key,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: Validatorless.multiple([
        Validatorless.required('E-mail obrigatório'),
        Validatorless.email('E-mail inválido'),
      ]),
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: 'E-Mail',
        labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
        isDense: true,
        suffixIcon: IconButton(
          icon: const Icon(
            AppIcons.eye,
            size: 15,
          ),
          onPressed: () {
            // obscureTextVN.value = !obscureTextValue;
          },
        ),
      ),
      // obscureText: true,
    );
  }
}
