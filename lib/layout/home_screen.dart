// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import 'package:apptodo/shared/cubit/cubit.dart';
import 'package:apptodo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../modules/archived_tasks/archived_tasks_screen.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';
import '../shared/component/components.dart';
import '../shared/component/constants.dart';
import '../shared/component/validate.dart';
import 'package:intl/intl.dart';

//////////////// variables start //////////////
var scaffoldKey = GlobalKey<ScaffoldState>();
var titleController = TextEditingController();
var timeController = TextEditingController();
var dateController = TextEditingController();
var formKey = GlobalKey<FormState>();

//////////////// variables End //////////////
class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state is AppInsertDatabaseStates) {
            // AppCubit cubit = AppCubit.get(context);
            Navigator.pop(context);
            // cubit.changeBottomSheet(isBottomShow: false, icon: Icons.edit);
          }
        },
        builder: (BuildContext context, AppState state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.appTitles[cubit.currentIndex]),
            ),
            // ignore: prefer_is_empty

            // ignore: prefer_is_empty
            // cubit.tasks.length == 0
            //     ? const Center(child: CircularProgressIndicator())
            //     : cubit.screens[cubit.currentIndex],
            body: Conditional.single(
              context: context,
              conditionBuilder: (BuildContext context) {
                return state is! AppGetDatabaseLoadingStates;
              },
              widgetBuilder: (BuildContext context) {
                return cubit.screens[cubit.currentIndex];
              },
              fallbackBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
              // condition: state is! AppGetDatabaseLoadingStates,
              // builder: (context) => cubit.screens[cubit.currentIndex],
              // fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              elevation: 100.0,
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    // insertToDatabase(
                    //     title: titleController.text,
                    //     time: timeController.text,
                    //     date: dateController.text)
                    //     .then((value) {
                    //   Navigator.pop(context);
                    //   isBottomSheetShown = false;
                    // setState(() {
                    //   iconFab = Icons.edit;
                    // });
                    // });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet((context) => Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defualtFormField(
                                    validate: Validator.title,
                                    controller: titleController,
                                    type: TextInputType.text,
                                    lable: 'Task Title',
                                    prefix: Icons.title_outlined,
                                  ),
                                  // SizedBox(height: 10.0,),
                                  defualtFormFieldTiming(
                                      validate: Validator.time,
                                      controller: timeController,
                                      type: TextInputType.text,
                                      lable: 'Task Time',
                                      prefix: Icons.watch_later_outlined,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          // ignore: avoid_print
                                          timeController.text =
                                              value!.format(context).toString();
                                        });
                                      }),
                                  defualtFormFieldTiming(
                                      validate: Validator.date,
                                      controller: dateController,
                                      type: TextInputType.text,
                                      lable: 'Task Date',
                                      prefix: Icons.calendar_today_outlined,
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2022-12-01'))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ))
                      .closed
                      .then((value) {
                    cubit.changeBottomSheet(
                        isBottomShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheet(isBottomShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.iconFab),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archived'),
              ],
              type: BottomNavigationBarType.fixed,
            ),
          );
        },
      ),
    );
  }
}
