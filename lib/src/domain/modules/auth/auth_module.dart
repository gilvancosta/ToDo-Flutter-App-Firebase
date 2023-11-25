import 'package:provider/provider.dart';

import '../../../core/modules/todo_list_module.dart';
import '../../../ui/pages/modules/auth/login/controller/login_controller.dart';
import '../../../ui/pages/modules/auth/login/login_page.dart';
import '../../../ui/pages/modules/auth/register/controller/register_controller.dart';
import '../../../ui/pages/modules/auth/register/register_page.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => LoginController(userService: context.read()),
            ),
            ChangeNotifierProvider(
              create: (context) => RegisterController(userService: context.read()),
            ),
          ],
          routers: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
          },
        );
}
