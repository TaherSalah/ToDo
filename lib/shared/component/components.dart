import 'package:apptodo/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

Widget defualtFormField({
  String? Function(String?)? validate,
  required TextEditingController controller,
  required TextInputType type,
  required String lable,
  required IconData prefix,
  double padding = 15.0,
  double borderRadius = 25.0,
  void Function()? onTap,
}) =>
    Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        validator: validate,
        onTap: onTap,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: lable,
          prefix: Icon(prefix),
        ),
      ),
    );
Widget defualtFormFieldTiming({
  String? Function(String?)? validate,
  required TextEditingController controller,
  required TextInputType type,
  required String lable,
  required IconData prefix,
  double padding = 15.0,
  double borderRadius = 25.0,
  void Function()? onTap,
}) =>
    Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        validator: validate,
        readOnly: true,
        onTap: onTap,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: lable,
          prefix: Icon(prefix),
        ),
      ),
    );
Widget tasksBuilder({
  required List<Map> tasks,
  BuildContext? context,
}) =>
    Conditional.single(
      // ignore: prefer_is_empty
      conditionBuilder: (context) => tasks.length > 0,
      context: context!,
      widgetBuilder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTasksItems(tasks[index], context),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0),
          child: Container(
            width: double.infinity,
            height: 2.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length,
      ),
      fallbackBuilder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              color: Colors.blueGrey,
              size: 30.0,
            ),
            Text(
              'No Tasks Yet Please Add Some Tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.blueGrey,
              ),
            )
          ],
        ),
      ),
    );
Widget buildTasksItems(Map dataRespon, context) => Dismissible(
      key: Key(
        dataRespon['id'].toString(),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: dataRespon['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundColor: Colors.pinkAccent,
              child: Text('${dataRespon['time']}'),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${dataRespon['title']}',
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${dataRespon['date']}',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[300],
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDataBase(status: 'done', id: dataRespon['id']);
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateDataBase(status: 'archived', id: dataRespon['id']);
              },
              icon: const Icon(
                Icons.archive,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
