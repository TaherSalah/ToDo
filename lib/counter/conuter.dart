import 'package:apptodo/counter/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';

import 'cubit/states.dart';

class CountScreen extends StatelessWidget {
  CountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
          listener: (context, state)
          {
            if(state is CounterPlusState)
              {
                // ignore: avoid_print
                print('state is plus ${state.counter}');
              }
            if(state is CounterMinusState)
              {
                // ignore: avoid_print
                print('state is minus ${state.counter}');

              }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Counter',
                ),
              ),
              body: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TextButton(
                          onPressed: () {
                            CounterCubit.get(context).minus();
                          },
                          child: const Text('MINUS'),
                        ),
                      ),
                      Text(
                        '${CounterCubit.get(context).counter}',
                        style: const TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TextButton(
                          onPressed: () {
                            CounterCubit.get(context).plus();
                          },
                          child: const Text('PLUS'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
