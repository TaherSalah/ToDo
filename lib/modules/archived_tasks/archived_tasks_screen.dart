import 'package:apptodo/shared/component/constants.dart';
import 'package:apptodo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';


class ArchivedTasksScreen  extends StatelessWidget {
  const ArchivedTasksScreen({super.key});




  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AppCubit,AppState>(
        builder: (BuildContext context,AppState state)
        {
          var tasks =AppCubit.get(context).archivedTasks;
          return tasksBuilder(tasks: tasks,context: context );
          
        },
        listener: (BuildContext context, AppState state){}
    );
  }
}







// class ArchivedTasksScreen extends StatefulWidget {
//   const ArchivedTasksScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ArchivedTasksScreen> createState() => _ArchivedTasksScreenState();
// }
//
// class _ArchivedTasksScreenState extends State<ArchivedTasksScreen> {
//   @override
//   Widget build(BuildContext context) {
//     var tasks =AppCubit.get(context).archivedTasks;
//
//     return ListView.separated(
//       itemBuilder:(context,index)=>buildTasksItems(tasks[index],context) ,
//       separatorBuilder: (context,index)=>Padding(
//         padding:  const EdgeInsetsDirectional.only(start: 20.0),
//         child: Container(
//           width: double.infinity,
//           height: 2.0,
//           color: Colors.grey[300],
//         ),
//       ),
//       itemCount: tasks.length,
//     );
//     // return ListView.separated(
//     //     itemBuilder: (context ,index)=>buildTasksItems(tasks [index]),
//     //     separatorBuilder: (context,index)=>Container(
//     //       width: double.infinity,
//     //       height: 2.0,
//     //       color: Colors.grey[300],
//     //     ),
//     //     itemCount: tasks.length ,
//     // );
//   }
// }
