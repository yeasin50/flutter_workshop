import 'package:flutter/material.dart';
import '/src/domain/repo/task_repo.dart';

import '/src/presentation/new_task_page.dart';
import '../domain/models/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.taskRepo});

  final TaskRepo taskRepo;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TaskRepo get repo => widget.taskRepo;

  late Future<List<Task>> tasks = repo.getTasks();

  Future<void> onNewTaskSave(Task task) async {
    final result = await repo.addTask(task);
    if (result == null) return;

    tasks = repo.getTasks();
    setState(() {});
  }

  void removeTask(Task t) async {
    final result = await repo.deleteTask(t.id);
    if (result == 0) return;

    tasks = repo.getTasks();
    setState(() {});
  }

  void updateTask(Task t, bool? isChecked) async {
    final result = await repo.toggleTaskStatus(
      t.id,
      isChecked == true ? TaskStatus.compelete : TaskStatus.due,
    );

    if (result == 0) return;

    tasks = repo.getTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task list")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: tasks,
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (asyncSnapshot.hasError) {
                  return Center(child: Text(asyncSnapshot.error.toString()));
                }

                final items = asyncSnapshot.data ?? [];

                return ListView(
                  children: [
                    if (items.isEmpty) Center(child: Text("No task found")),
                    ...items.map(
                      (e) => ListTile(
                        title: Text(e.title),
                        subtitle: Text(e.description),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => removeTask(e),
                        ),

                        leading: Checkbox(
                          value: e.status == TaskStatus.compelete,
                          onChanged: (v) {
                            updateTask(e, v);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
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
