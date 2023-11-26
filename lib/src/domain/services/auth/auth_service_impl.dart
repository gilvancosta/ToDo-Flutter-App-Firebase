import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth/auth_repository.dart';
import 'auth_service.dart';

class LoginServiceImpl implements AuthService {
  final AuthRepository _authRepository;

  LoginServiceImpl({
    required AuthRepository loginRepository,
  }) : _authRepository = loginRepository;

  @override
  Future<User?> register(String email, String password) => _authRepository.register(email, password);

  @override
  Future<User?> login(String email, String password) => _authRepository.login(email, password);

  @override
  Future<void> forgotPassword(String email) => _authRepository.forgotPassword(email);

  @override
  Future<User?> googleLogin() => _authRepository.googleLogin();

  @override
  Future<void> logout() => _authRepository.logout();

  @override
  Future<void> updateDisplayName(String name) => _authRepository.updateDisplayName(name);
}
