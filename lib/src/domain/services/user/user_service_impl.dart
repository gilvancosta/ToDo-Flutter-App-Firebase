import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth/login_repository.dart';
import './user_service.dart';

class LoginServiceImpl implements LoginService {
  final LoginRepository _loginRepository;

  LoginServiceImpl({
    required LoginRepository loginRepository,
  }) : _loginRepository = loginRepository;

  @override
  Future<User?> register(String email, String password) => _loginRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) => _loginRepository.login(email, password);

  @override
  Future<void> forgotPassword(String email) => _loginRepository.forgotPassword(email);

  @override
  Future<User?> googleLogin() => _loginRepository.googleLogin();

  @override
  Future<void> logout() => _loginRepository.logout();

  @override
  Future<void> updateDisplayName(String name) => _loginRepository.updateDisplayName(name);
}
