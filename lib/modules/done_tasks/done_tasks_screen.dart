import 'package:apptodo/shared/component/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/component/components.dart';

class DoneTasksScreen extends StatefulWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);
  @override
  State<DoneTasksScreen> createState() => _DoneTasksScreenState();
}
class _DoneTasksScreenState extends State<DoneTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder:(context,index)=>buildTasksItems(tasks[index]) ,
        separatorBuilder: (context,index)=>Container(
          width: double.infinity,
          height: 2.0,
          color: Colors.grey[300],
        ),
        itemCount: tasks.length,
    );
  }
}
