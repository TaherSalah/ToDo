import 'package:apptodo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppState>{

  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);
  //////////////// List start ////////////////
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> appTitles =
  ['Add New Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];
//////////////// List End //////////////
  int currentIndex = 0;

  void changeIndex (int index)
  {
    currentIndex=index;
  }
}