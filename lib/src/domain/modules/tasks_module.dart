import 'package:provider/provider.dart';

import 'todo_list_module.dart';
import '../repositories/tasks/tasks_repository.dart';
import '../repositories/tasks/tasks_repository_impl.dart';
import '../services/tasks/tasks_services.dart';
import '../services/tasks/tasks_services_impl.dart';
import '../../ui/pages/tasks/controller/task_create_controller.dart';
import '../../ui/pages/tasks/task_create_page.dart';



class TasksModule extends TodoListModule {
  TasksModule()
      : super(bindings: [
          Provider<TasksRepository>(
            create: (context) => TasksRepositoryImpl(
              sqliteConnectionFectory: context.read(),
            ),
          ),
          Provider<TasksServices>(
            create: (context) => TasksServicesImpl(
              taskRepository: context.read(),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => TaskCreateController(tasksServices: context.read()),
          )
        ], routers: {
          '/task/create': (context) => TaskCreatePage(
                controller: context.read(),
              )
        });
}
