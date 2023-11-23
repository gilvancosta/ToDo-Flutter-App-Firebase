import 'task_model.dart';

class WeekTaskEntity {
  final DateTime startDate;
  final DateTime endDate;
  final List<TaskModel> tasks;
  const WeekTaskEntity({
    required this.startDate,
    required this.endDate,
    required this.tasks,
  });
}
