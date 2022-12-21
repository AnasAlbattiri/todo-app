import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:to_do_app/business_logic/app_cubit.dart';

Widget buildTaskItem(Map model, context) => Dismissible(
  key: UniqueKey(),
  child:   Padding(

        padding: const EdgeInsets.all(20.0),

        child: Row(

          children: [

            CircleAvatar(

              radius: 40.0,

              child: Text(

                '${model['time']}',

                style: TextStyle(

                  color: Colors.white,

                ),

              ),

            ),

            SizedBox(

              width: 20.0,

            ),

            Expanded(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(

                    '${model['title']}',

                    style: TextStyle(

                      fontSize: 18.0,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                  Text(

                    '${model['date']}',

                    style: TextStyle(

                      color: Colors.grey,

                    ),

                  ),

                ],

              ),

            ),

            SizedBox(

              width: 20.0,

            ),

            IconButton(

              onPressed: () {

                AppCubit.get(context).updateData(status: 'done', id: model['id']);

              },

              icon: Icon(

                Icons.check_box,

                color: Colors.green,

              ),

            ),

            IconButton(

              onPressed: () {

                AppCubit.get(context).updateData(status: 'archive', id: model['id']);

              },

              icon: Icon(

                Icons.archive,

                color: Colors.black45,

              ),

            ),

          ],

        ),

      ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);
