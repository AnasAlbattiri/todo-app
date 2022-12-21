import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/business_logic/app_cubit.dart';
import 'package:to_do_app/presentation/widgets/default_form_field.dart';
import '../../business_logic/app_state.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  // Variables
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime(2022, 12, 5);

  // Controllers
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                cubit.titles[cubit.currentIndex],
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.black,
                child: Icon(
                  cubit.fabIcon,
                ),
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                          title: titleController.text,
                          date: dateController.text,
                          time: timeController.text);
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) => Container(
                            color: Colors.grey[100],
                            padding: EdgeInsets.all(20.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Form(
                                    child: DefaultFormField(
                                      controller: titleController,
                                      textType: TextInputType.text,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Title must not be empty';
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icon(
                                        Icons.title,
                                      ),
                                      label: 'Task Title',
                                      onTap: () {},
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Form(
                                    child: DefaultFormField(
                                      controller: timeController,
                                      textType: TextInputType.text,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Time must not be empty';
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icon(
                                        Icons.watch_later_outlined,
                                      ),
                                      label: 'Task Time',
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeController.text =
                                              value!.format(context).toString();
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Form(
                                    child: DefaultFormField(
                                      controller: dateController,
                                      textType: TextInputType.text,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Date must not be empty';
                                        }
                                        return null;
                                      },
                                      prefixIcon: Icon(Icons.date_range),
                                      label: 'Task Date',
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: dateTime,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          elevation: 20.0,
                        )
                        .closed
                        .then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });
                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                }),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.check_circle_outline,
                    ),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive_outlined,
                    ),
                    label: 'Archived',
                  ),
                ]),
          );
        },
      ),
    );
  }
}
