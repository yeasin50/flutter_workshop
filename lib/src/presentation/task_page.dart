import 'package:flutter/material.dart';

import '/src/presentation/new_task_page.dart';
import '../domain/models/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late List<Task> tasks = [];

  void onNewTaskSave(Task task) {
    tasks.add(task);
    setState(() {});
  }

  void removeTask(Task t) async {
    tasks.remove(t);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task list")),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                if (tasks.isEmpty) Center(child: Text("No task found")),
                ...tasks.map(
                  (e) => ListTile(
                    title: Text(e.title),
                    subtitle: Text(e.description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removeTask(e),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: NewTaskPage(onSave: onNewTaskSave),
            ),
          ),
        ],
      ),
    );
  }
}
