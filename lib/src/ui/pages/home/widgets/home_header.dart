import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_app_firebase/src/core/ui/theme/app_theme_extensions.dart';

import '../../../../core/auth/auth_provider.dart';



class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Selector<AuthProvider01, String>(
          selector: (context, authProvider) => authProvider.user?.displayName ?? 'Não Informado',
          builder: (_, value, __) {
            return Text(
              'E ai, $value!',
              style: context.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            );
          }),
    );
  }
}
