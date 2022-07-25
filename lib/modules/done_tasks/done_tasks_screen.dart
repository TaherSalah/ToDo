import 'package:apptodo/shared/component/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';



class DoneTasksScreen  extends StatelessWidget {
  const DoneTasksScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (BuildContext context,AppState state)
        {
          var tasks =AppCubit.get(context).doneTasks;
          return tasksBuilder(tasks: tasks,context: context );
        },
        listener: (BuildContext context, AppState state){}
    );

    // return ListView.separated(
    //   itemBuilder:(context,index)=>buildTasksItems(tasks[index],context) ,
    //   separatorBuilder: (context,index)=>Padding(
    //     padding:  const EdgeInsetsDirectional.only(start: 20.0),
    //     child: Container(
    //       width: double.infinity,
    //       height: 2.0,
    //       color: Colors.grey[300],
    //     ),
    //   ),
    //   itemCount: tasks.length,
    // );
  }
}



