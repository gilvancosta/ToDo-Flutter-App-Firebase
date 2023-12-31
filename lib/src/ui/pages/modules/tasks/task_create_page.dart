import 'package:flutter/material.dart';
import 'package:todo_flutter_app_firebase/src/core/ui/theme/app_theme_extensions.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/notifier/app_listener_notifier.dart';

import '../../../../core/widgets/TextFormField/my_textformfield general.dart';
import 'controller/task_create_controller.dart';
import 'widgets/calendar_button.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  TaskCreatePage({
    Key? key,
    required TaskCreateController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AppListenerNotifier(
      changeNotifier: widget._controller,
    ).listener(
        context: context,
        successVoidCallback: (notifier, listenerIstance) {
          listenerIstance.dispose();
          Navigator.pop(context);
        });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            widget._controller.save(_descriptionEC.text);
          }
        },
        label: const Text(
          'Salvar Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Criar Atividade',
                  style: context.titleStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextFormFieldGeneral(
                controller: _descriptionEC,
                validator: Validatorless.required('Descrição é obrigatória'),
                label: '',
              ),
              const SizedBox(
                height: 20,
              ),
              CalendarButton()
            ],
          ),
        ),
      ),
    );
  }
}
