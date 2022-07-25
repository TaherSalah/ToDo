import 'package:apptodo/shared/component/bloc_observable.dart';
import 'package:apptodo/shared/cubit/cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter/conuter.dart';
import 'layout/home_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Flutter Demo', debugShowCheckedModeBanner: false, home: Home());
  }
}
