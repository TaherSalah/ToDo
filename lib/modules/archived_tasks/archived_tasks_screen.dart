import 'package:apptodo/shared/component/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/component/components.dart';

class ArchivedTasksScreen extends StatefulWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  State<ArchivedTasksScreen> createState() => _ArchivedTasksScreenState();
}

class _ArchivedTasksScreenState extends State<ArchivedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context ,index)=>buildTasksItems(tasks [index]),
        separatorBuilder: (context,index)=>Container(
          width: double.infinity,
          height: 2.0,
          color: Colors.grey[300],
        ),
        itemCount: tasks.length ,
    );
  }
}
