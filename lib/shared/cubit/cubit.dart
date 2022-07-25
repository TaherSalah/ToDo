import 'package:apptodo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/archived_tasks/archived_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppState> {
  int currentIndex = 0;
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);
  //////////////// var start ////////////////

  bool isBottomSheetShown = false;
  IconData iconFab = Icons.edit;
  //////////////// List start ////////////////
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  List<String> appTitles = ['Add New Tasks', 'Done Tasks', 'Archived Tasks'];
//////////////// List End //////////////

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeNavbarStates());
  }
  //////////////// createDatabase start //////////////

  void createDatabase() {
    openDatabase('todo.db', version: 1,
        onCreate: (Database database, int version) {
      // ignore: avoid_print
      print('database created');
      database
          .execute(
              'CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        // ignore: avoid_print
        print('created table');
      }).catchError((error) {
        // ignore: avoid_print
        print('object${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      // ignore: avoid_print
      print('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseStates());
    });
  }

  //////////////// insertToDatabase start //////////////
  insertToDatabase(
      {required String title,
      required String time,
      required String date}) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO todo (title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        // ignore: avoid_print
        print('$value successfully inserted data complete');
        emit(AppInsertDatabaseStates());
        getDataFromDatabase(database);
      }).catchError((onError) {
        // ignore: avoid_print
        print('is error${onError.toString()}');
      });
      // return null;
    });
  }
  //////////////// getDataFromDatabase start //////////////

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingStates());
    database.rawQuery('SELECT * FROM todo').then((value) {
      // newTasks = value;
      // ignore: avoid_function_literals_in_foreach_calls
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });
      // ignore: avoid_print
      // getDataFromDatabase(database);
      emit(AppGetDatabaseStates());
      // ignore: avoid_print
      print('this the tasks $newTasks');
    });
  }

  //////////////// updateDataBase start //////////////

  void updateDataBase({required String status, required int id}) async {
    database.rawUpdate('UPDATE todo SET status = ? WHERE id = ?',
        [' $status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
      // ignore: avoid_print
      // print('updated ${value}');
    });
  }

  //////////////// updateDataBase start //////////////
  void deleteData({
    required int id,
  }) async {
    database.rawDelete('DELETE FROM todo WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseStates());
    });
  }

  void changeBottomSheet({required bool isBottomShow, required IconData icon}) {
    isBottomSheetShown = isBottomShow;
    iconFab = icon;
    emit(AppChangeBottomSheetStates());
  }
}
