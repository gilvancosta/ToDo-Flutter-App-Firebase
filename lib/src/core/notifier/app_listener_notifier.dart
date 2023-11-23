import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../ui/theme/app_messages.dart';
import 'app_change_notifier.dart';


class AppListenerNotifier {
  final AppChangeNotifier changeNotifier;

  const AppListenerNotifier({required this.changeNotifier});

  void listener({
    required BuildContext context,
    required SucessVoidCallback sucessVoidCallback,
    EverVoidCallback? everVoidCallback,
    ErrorVoidCallback? errorCallback,
  }) {
    changeNotifier.addListener(() {
      if (everVoidCallback != null) {
        everVoidCallback(changeNotifier, this);
      }

      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        AppMessages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
       // if (sucessVoidCallback != null) {
          sucessVoidCallback(changeNotifier, this);
       // }
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SucessVoidCallback = void Function(AppChangeNotifier notifier, AppListenerNotifier listenerNotifier);

typedef ErrorVoidCallback = void Function(AppChangeNotifier notifier, AppListenerNotifier listenerNotifier);

typedef EverVoidCallback = void Function(AppChangeNotifier notifier, AppListenerNotifier listenerNotifier);
