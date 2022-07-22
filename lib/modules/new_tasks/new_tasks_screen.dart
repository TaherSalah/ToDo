import 'package:flutter/material.dart';
import 'package:apptodo/shared/component/constants.dart';

import '../../shared/component/components.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}
class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder:(context,index)=>buildTasksItems(tasks[index]) ,
      separatorBuilder: (context,index)=>Padding(
        padding:  const EdgeInsetsDirectional.only(start: 20.0),
        child: Container(
          width: double.infinity,
          height: 2.0,
          color: Colors.grey[300],
        ),
      ),
      itemCount: tasks.length,
    );
  }
}
