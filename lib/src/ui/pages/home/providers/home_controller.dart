
import '../../../../core/notifier/app_change_notifier.dart';
import '../../../../domain/entities/task_filter_enum.dart';
import '../../../../domain/entities/task_model.dart';
import '../../../../domain/entities/total_tasks_entity.dart';
import '../../../../domain/entities/week_task_entity.dart';
import '../../../../domain/services/tasks/tasks_services.dart';

class HomeController extends AppChangeNotifier {
  final TasksServices _tasksServices;
  var filterSelected = TaskFilterEnum.today;
  TotalTasksEntity? todayTotalTasks;
  TotalTasksEntity? tomorrowTotalTasks;
  TotalTasksEntity? weekTotalTasks;
  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;
  bool showFinishingTasks = false;

  HomeController({required TasksServices tasksServices}) : _tasksServices = tasksServices;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksServices.getToday(),
      _tasksServices.getTomorrow(),
      _tasksServices.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskEntity;

    todayTotalTasks = TotalTasksEntity(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTasks = TotalTasksEntity(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTasks = TotalTasksEntity(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    );
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksServices.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksServices.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _tasksServices.getWeek();
        initialDateOfWeek = weekModel.startDate;
        tasks = weekModel.tasks;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (selectedDay != null) {
        filterByDay(selectedDay!);
      } else if (initialDateOfWeek != null) {
        filterByDay(initialDateOfWeek!);
      }
    } else {
      selectedDay = null;
    }

    if (!showFinishingTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finished).toList();
    }

    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDay = date;
    filteredTasks = allTasks.where((task) {
      return task.dateTime == date;
    }).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  Future<void> checkOrUncheckTask(TaskModel task) async {
    showLoadingAndResetState();
    notifyListeners();

    final taskUpdate = task.copyWith(finished: !task.finished);
    await _tasksServices.checkOrUncheckTask(taskUpdate);
    hideLoading();
    refreshPage();
  }

  void showOrHideFinishTask() {
    showFinishingTasks = !showFinishingTasks;
    refreshPage();
    notifyListeners();
  }

  Future<void> deleteTasks(int id) async {
    await _tasksServices.deleteById(id);
    refreshPage();
    notifyListeners();
  }

  Future<void> showOnlyFinishTask() async {
    filteredTasks = allTasks.where((task) {
      return task.finished;
    }).toList();
    notifyListeners();
  }
}
