import 'package:flutter/material.dart';
import 'package:todo_flutter_app_firebase/src/core/ui/theme/app_theme_extensions.dart';
import 'package:todo_flutter_app_firebase/src/ui/pages/home/widgets/home_drawer.dart';

import '../../../core/notifier/app_listener_notifier.dart';
import '../../../core/ui/theme/app_icons.dart';
import '../../../domain/entities/task_filter_enum.dart';
import '../../../modules/tasks_module.dart';
import 'providers/home_controller.dart';
import 'widgets/home_filters.dart';
import 'widgets/home_header.dart';
import 'widgets/home_tasks.dart';
import 'widgets/home_week_filter.dart';


class HomePage extends StatefulWidget {

  final HomeController homeController;
  const HomePage({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    AppListenerNotifier(changeNotifier: widget.homeController).listener(
        context: context,
        sucessVoidCallback: (notifier, listenerInstance) {
          listenerInstance.dispose();
        });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.homeController.loadTotalTasks();
      widget.homeController.findTasks(filter: TaskFilterEnum.today);
    });
  }


  Future<void> _goToCreateTask(BuildContext context) async {
    await Navigator.of(context).push(
      //MaterialPageRoute(
      //  builder: (_) => TasksModule().getPage('/task/create', context),
      //),
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuad);
          return ScaleTransition(
            scale: animation,
            alignment: Alignment.bottomRight,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return TasksModule().getPage('/task/create', context);
        },
      ),
    );
    widget.homeController.refreshPage();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.primaryColor),
        backgroundColor: const Color(0xFFFAFBFE),
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(AppIcons.filter),
            onSelected: (value) {
              widget.homeController.showOrHideFinishTask();
            },
            itemBuilder: (_) => [
              PopupMenuItem<bool>(
                value: true,
                child: Text(
                  '${widget.homeController.showFinishingTasks ? 'Esconder' : 'Mostrar'} tarefas concluidas',
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColor,
        onPressed: () => _goToCreateTask(context),
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFFAFBFE),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [HomeHeader(), HomeFilters(), HomeWeekFilter(), HomeTasks()],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
