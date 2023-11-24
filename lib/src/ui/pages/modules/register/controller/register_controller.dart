

import '../../../../../core/exception/app_auth_exception.dart';
import '../../../../../core/notifier/app_change_notifier.dart';
import '../../../../../domain/services/user/user_service.dart';

class RegisterController extends AppChangeNotifier {
  final LoginService _userService;

  RegisterController({required LoginService userService}) : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        // sucess
        success();
      } else {
        //error
        setError('Erro ao registrar usuário');
      }
    } on AppAuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
