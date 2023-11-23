import '../../entities/task_model.dart';
import '../../entities/week_task_entity.dart';

abstract class TasksServices {
  Future<void> save(DateTime date, String description);
  Future<void> deleteById(int id);
  Future<void> deleteAllTasks();

  Future<List<TaskModel>> getToday();
  Future<List<TaskModel>> getTomorrow();
  Future<WeekTaskEntity> getWeek();
  Future<void> checkOrUncheckTask(TaskModel task);

  
}
