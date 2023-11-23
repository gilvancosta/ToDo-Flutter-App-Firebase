import 'package:flutter/material.dart';
import 'sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver { // o bjetivo do WidgetsBindingObserver é observar o ciclo de vida da aplicação
  // inicia uma instancia do SqliteConnectionFactory para controlar seu estado
  final connection = SqliteConnectionFactory();

  @override
  void didChangeAppLifecycleState(AppLifecycleState  state) {

/*     if (
     (state == AppLifecycleState.hidden) || 
     (state == AppLifecycleState.paused) || 
     (state == AppLifecycleState.detached)   
    
    ) {
       connection.closeConnection();
    }
 */

   // se o estado for um dos abaixo, ele faz alguma coisa
    switch (state) {
      case AppLifecycleState.resumed: // Aplicativo aberto em tela
      case AppLifecycleState.inactive:    
        break;
      case AppLifecycleState.hidden: // Clique na bolinha do meio
      case AppLifecycleState.paused: // Atendeu alguma ligação ou outro app abriu por cima
      case AppLifecycleState.detached: // Matou o app
        connection.closeConnection();
        break;
    }


    super.didChangeAppLifecycleState(state);
  }
}
