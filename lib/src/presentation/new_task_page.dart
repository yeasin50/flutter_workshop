import 'package:flutter/material.dart';

import '../domain/models/task.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key, required this.onSave});

  final Function(Task task) onSave;

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> onSave() async {
    final newTask = Task.empty.copyWith(
      title: titleController.text,
      description: descriptionController.text,
    );

    widget.onSave(newTask);

    titleController.text = "";
    descriptionController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(24),
      child: Column(
        mainAxisSize: .min,
        spacing: 24,
        crossAxisAlignment: .stretch,
        children: [
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(hintText: "title"),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: "description"),
          ),

          ElevatedButton.icon(onPressed: onSave, label: Text('save')),
        ],
      ),
    );
  }
}
