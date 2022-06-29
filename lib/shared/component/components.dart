import 'package:flutter/material.dart';

Widget defualtFormField({
   String? Function(String?) ?validate,
 required TextEditingController  controller,
  required TextInputType type,
  required String lable,
  required IconData prefix,
double padding=15.0,
  double borderRadius=25.0,
  void Function()? onTap,
})=> Container(
  padding: EdgeInsets.all(padding),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
    color: Colors.grey[200],
  ),
  child: TextFormField(
    validator:validate,
    onTap:onTap,
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
  String? Function(String?) ?validate,
  required TextEditingController  controller,
  required TextInputType type,
  required String lable,
  required IconData prefix,
  double padding=15.0,
  double borderRadius=25.0,
  void Function()? onTap,
})=> Container(
  padding: EdgeInsets.all(padding),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(borderRadius),
    color: Colors.grey[200],
  ),
  child: TextFormField(
    validator: validate,
    readOnly: true,
    onTap:onTap,
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      labelText: lable,
      prefix: Icon(prefix),
    ),
  ),
);
Widget buildTasksItems() =>Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
    children: [
      const CircleAvatar(
        radius: 45.0,
        backgroundColor: Colors.pinkAccent,
        child: Text('02.05'),
      ),
      SizedBox(
        width: 10.0,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Task Title',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '01 , April , 2022',
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[300],
                fontWeight: FontWeight.bold),
          ),
        ],
      )
    ],
  ),
);
