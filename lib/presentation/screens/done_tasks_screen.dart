import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/business_logic/app_cubit.dart';
import '../../business_logic/app_state.dart';
import '../widgets/tasks_builder.dart';

class DoneTasksScreen extends StatelessWidget {
   DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    {
      var tasks = AppCubit.get(context).doneTasks;
      return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return tasksBuilder(tasks: tasks,);
        },
      );
    }

  }
}

