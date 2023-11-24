
import '../../../../../core/notifier/app_change_notifier.dart';
import '../../../../../domain/services/tasks/tasks_services.dart';

class TaskCreateController extends AppChangeNotifier {
  TasksServices _tasksServices;
  DateTime? _selectedDate;

  TaskCreateController({required TasksServices tasksServices})
      : _tasksServices = tasksServices;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _tasksServices.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da task não selecionada');
      }
    }  catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
