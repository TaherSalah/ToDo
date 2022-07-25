import 'package:apptodo/shared/cubit/cubit.dart';
import 'package:apptodo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:apptodo/shared/component/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/components.dart';

class NewTasksScreen  extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (BuildContext context,AppState state)
        {
          var tasks =AppCubit.get(context).newTasks;
          return tasksBuilder(tasks: tasks,context: context );
        },
        listener: (BuildContext context, AppState state){}
    );


}}
//   return ListView.separated(
//     itemBuilder:(context,index)=>buildTasksItems(tasks[index],context) ,
//     separatorBuilder: (context,index)=>Padding(
//       padding:  const EdgeInsetsDirectional.only(start: 20.0),
//       child: Container(
//         width: double.infinity,
//         height: 2.0,
//         color: Colors.grey[300],
//       ),
//     ),
//     itemCount: tasks.length,
//   );
// }

// class NewTasksScreen extends StatefulWidget {
//   const NewTasksScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NewTasksScreen> createState() => _NewTasksScreenState();
// }
// class _NewTasksScreenState extends State<NewTasksScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit,AppState>(
//      listener: (BuildContext context, AppState state){},
//       builder: (BuildContext context , AppState state)
//       {
//         var tasks =AppCubit.get(context).newTasks;
//
//         return ListView.separated(
//           itemBuilder:(context,index)=>buildTasksItems(tasks[index],context) ,
//           separatorBuilder: (context,index)=>Padding(
//             padding:  const EdgeInsetsDirectional.only(start: 20.0),
//             child: Container(
//               width: double.infinity,
//               height: 2.0,
//               color: Colors.grey[300],
//             ),
//           ),
//           itemCount: tasks.length,
//         );
//       },
//     );
//   }
// }
