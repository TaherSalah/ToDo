import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../modules/archived_tasks/archived_tasks_screen.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';
import '../shared/component/components.dart';
import '../shared/component/validate.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //////////////// variables start //////////////
  int currentIndex = 0;
  late Database database;
  bool isBottomSheetShown = false;
  IconData iconFab = Icons.edit;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  //////////////// variables End //////////////
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
  List<Map>tasks=[];
  //////////////// List End //////////////

  @override
  void initState() {
    super.initState();
    _createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(appTitles[currentIndex]),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        elevation: 100.0,
        onPressed: () {
          if (isBottomSheetShown) {
            if (formKey.currentState!.validate()) {
              insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text)
                  .then((value) {
                Navigator.pop(context);
                isBottomSheetShown = false;
                setState(() {
                  iconFab = Icons.edit;
                });
              });
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
                                          lastDate:
                                              DateTime.parse('2022-02-01'))
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
              isBottomSheetShown = false;
              setState(() {
                iconFab = Icons.edit;
              });
            });
            isBottomSheetShown = true;
            setState(() {
              iconFab = Icons.add;
            });
          }
        },
        child: Icon(iconFab),
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
      getDataFromDatabase(database).then((value) {
        tasks=value;
        // ignore: avoid_print
        print(tasks);
      });
      // ignore: avoid_print
      print('database opened');
    });
  }

  Future insertToDatabase(
      {required String title,
      required String time,
      required String date}) async {
    return await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO todo (title, date, time, status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        // ignore: avoid_print
        print('$value successfully inserted data complete');
      }).catchError((onError) {
        // ignore: avoid_print
        print('is error${onError.toString()}');
      });
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT * FROM todo');
  }
}
