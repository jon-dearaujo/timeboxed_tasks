import 'package:flutter/material.dart';

import 'src/tasks_list/tasks_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = "TimeBoxed Tasks";
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title)
        ),
        body: TasksList(),
      )
    );
  }
}