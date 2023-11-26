import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/services/auth/auth_service.dart';
import '../navigator/todo_list_navigator.dart';

class AuthProvider01 extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final AuthService _userServices;

  AuthProvider01({
    required FirebaseAuth firebaseAuth,
    required AuthService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userServices = userService;

  Future<void> logout() => _userServices.logout();

  User? get user => _firebaseAuth.currentUser;

  //Ficar escutando o firebase ao longo da aplicação

  void loadListener() {
    _firebaseAuth.userChanges().listen((event) => notifyListeners());
    _firebaseAuth.authStateChanges().listen((user) {

      
      if (user != null) {
        TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        TodoListNavigator.to
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}
