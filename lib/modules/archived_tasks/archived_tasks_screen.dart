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
    return buildTasksItems();
  }
}
