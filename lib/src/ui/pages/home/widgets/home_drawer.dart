//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_app_firebase/src/core/ui/theme/app_theme_extensions.dart';

import '../../../../core/auth/auth_provider.dart';
import '../../../../core/ui/theme/app_messages.dart';
import '../../../../domain/repositories/tasks/tasks_repository.dart';
import '../../../../domain/services/auth/auth_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(70)),
            child: Row(
              children: [
                Selector<AuthProvider01, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://st2.depositphotos.com/4111759/12123/v/450/depositphotos_121231710-stock-illustration-male-default-avatar-profile-gray.jpg';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(value),
                      radius: 30,
                    );
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Selector<AuthProvider01, String>(
                      selector: (context, authProvider) {
                        return authProvider.user?.displayName ??
                            'Não informado';
                      },
                      builder: (_, value, __) {
                        return Text(
                          value,
                          style: context.textTheme.subtitle2,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('Alterar Nome'),
                      content: TextField(
                        onChanged: (value) => nameVN.value = value,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.blue.shade100),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            final nameValue = nameVN.value;
                            if (nameValue.isEmpty) {
                              AppMessages.of(context).showError(
                                  'Por favor inserir um Nome, para atualizar o registro');
                            } else {
                              Loader.show(context);
                              context
                                  .read<AuthService>()
                                  .updateDisplayName(nameValue);
                              Loader.hide();
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Salvar'),
                        )
                      ],
                    );
                  });
            },
            title: const Text('Alterar Nome'),
          ),
          ListTile(
            onTap: () {
              context.read<TasksRepository>().deleteAllTasks();
              context.read<AuthProvider01>().logout();
            },
            title: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
