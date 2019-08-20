import 'package:flutter/material.dart';

import 'task.dart';
import 'tasks_repository.dart';

class TasksListState extends State<TasksList> {
  
  static const LOAD_OFFSET = 15;
  final _tasks = <Task>[];
  Future<List<Task>> _future;
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  
  TasksListState() {
    // Adds a Listener to the scrollController that loads more Tasks
    _controller.addListener(() {
      if (_controller.offset == _controller.position.maxScrollExtent && _future == null) {
        // Fetch! 
        setState(() {
          _future = _paginateTasks();
        }); 
      }
    });

    // Initial load of Tasks
    _future = _paginateTasks();
  }

  // Loads the data and updates the local Task list
  // Also, clears the future to control the FutureBuilder
  Future<List<Task>> _paginateTasks() async {
    // Loads the next page of Tasks, adds it to the existing Tasks list and return it
    _tasks.addAll(await loadTasks(_tasks.length, LOAD_OFFSET));
    setState(() {
      _future = null;
    });
    return _tasks;
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: _future,
    builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
      var children = <Widget>[
        ListView.builder(
          itemCount: _tasks.length,
          controller: _controller,
          itemBuilder: _buildListItem,
        )
      ];
      if (snapshot.connectionState == ConnectionState.waiting) {
        children.add(
          LinearProgressIndicator()
        );
      }
      return Stack(
        children: children
      );
    }
  );
  
  Widget _buildListItem(BuildContext, int index) {
    final task = _tasks[index];
    return Column(children: <Widget>[
      ListTile(
        contentPadding: EdgeInsets.only(left: 30.0),
        title: Text(
          task.title,
          style: TextStyle(fontSize: 20.0),
        )
      ),
      Divider()
    ]);
  }
}

// Infinite scrollable list for Tasks
class TasksList extends StatefulWidget {
  @override
  TasksListState createState () => TasksListState();
}