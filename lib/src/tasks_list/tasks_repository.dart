import 'task.dart';

Future<List<Task>> loadTasks(index, offset) async {
  // Simulates server loading time with a delay
  await Future.delayed(Duration(milliseconds: 500));
  
  // Creates a ten items Task list
  return List<Task>
      .generate(offset, (i) {
        final id = index + i + 1;
        return Task("Task $id", "$id");
      });
}