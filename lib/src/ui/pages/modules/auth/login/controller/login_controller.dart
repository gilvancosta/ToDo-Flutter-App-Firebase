import '../../../../../../core/exception/app_auth_exception.dart';
import '../../../../../../core/notifier/app_change_notifier.dart';
import '../../../../../../domain/services/auth/auth_service.dart';

class LoginController extends AppChangeNotifier {
  final AuthService _authService;
  
  String? infoMessage;

  LoginController({required AuthService userService}) : _authService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> googleLogin() async {
    try {
     //await
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _authService.googleLogin();

      if (user != null) {
        success();
      } else {
        _authService.logout();
        setError('Erro ao realizar login com Google');
      }
    } on AppAuthException catch (e) {
      _authService.logout();
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      final user = await _authService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError('Usuário ou senha inválidos');
      }
    } on AppAuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _authService.forgotPassword(email);
      infoMessage = 'Reset de senha enviado para seu e-mail';
    } on AppAuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Erro ao resetar senha');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
