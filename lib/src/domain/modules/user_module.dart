import 'package:provider/provider.dart';
import 'todo_list_module.dart';
import '../../ui/pages/login/controller/login_controller.dart';
import '../../ui/pages/login/login_page.dart';
import '../../ui/pages/register/controller/register_controller.dart';
import '../../ui/pages/register/register_page.dart';



class UserModule extends TodoListModule {
  UserModule()
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
