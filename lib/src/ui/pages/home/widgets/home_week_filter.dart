import 'package:date_picker_timeline/date_picker_widget.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_app_firebase/src/core/ui/theme/app_theme_extensions.dart';

import '../../../../domain/entities/task_filter_enum.dart';
import '../providers/home_controller.dart';



class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>((controller) => controller.filterSelected == TaskFilterEnum.week),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'DIA DA SEMANA',
            style: context.titleStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) => controller.initialDateOfWeek ?? DateTime.now(),
              builder: (_, value, __) {
                return DatePicker(
                  value,
                  locale: 'pt_BR',
                  height: 2,
                  initialSelectedDate: value,
                  selectionColor: context.primaryColor,
                  selectedTextColor: Colors.white,
                  daysCount: 7,
                  monthTextStyle: const TextStyle(fontSize: 8),
                  dayTextStyle: const TextStyle(fontSize: 13),
                  dateTextStyle: const TextStyle(fontSize: 13),
                  onDateChange: (date) {
                    context.read<HomeController>().filterByDay(date);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
