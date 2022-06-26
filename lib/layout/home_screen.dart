import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../modules/archived_tasks/archived_tasks_screen.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];
  // ignore: prefer_typing_uninitialized_variables
   late Database database;
  List<String> appTitles = ['Add New Tasks', 'Done Tasks', 'Archived Tasks'];
  @override
  void initState() {
    super.initState();
    _createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          insertToDatabase();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined), label: 'Archived'),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  void _createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
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
      // ignore: avoid_print
      print('database opened');
    });
  }

  void insertToDatabase() {
    database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO todo(title,date,time,status)VALUES("first task","123","123","new")');
    });
  }
}
