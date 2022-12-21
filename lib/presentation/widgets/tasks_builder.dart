import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/widgets/task_item.dart';
import 'package:conditional_builder/conditional_builder.dart';

Widget tasksBuilder({
  required List<Map> tasks,
}) => ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
      itemBuilder: (context, index)
      {
        return buildTaskItem(tasks[index], context);
      },
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 20.0,
        ),
        child: Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
      ),
      itemCount: tasks.length,
    ),
    fallback: (context) => Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            [
              Icon(
                Icons.menu,
                size: 100.0,
                color: Colors.grey,
              ),
              Text(
                'No Tasks Yet, Please Add some tasks',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ]
        )
    )
);