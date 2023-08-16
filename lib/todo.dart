import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String title;
  bool isDone;

  Task(this.title, this.isDone);
}

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  void addTask(String title) {
    tasks.add(Task(title, false));
  }

  void toggleTask(int index) {
    tasks[index].isDone = !tasks[index].isDone;
  }
}

class MyApp extends StatelessWidget {
  final TaskController taskController = TaskController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('Todo App')),
        body: Column(
          children: [
            Expanded(child: TaskList(taskController: taskController)),
            TaskInput(taskController: taskController),
          ],
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final TaskController taskController;

  TaskList({super.key, required this.taskController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskController.tasks.length,
      itemBuilder: (context, index) {
        final task = taskController.tasks[index];
        return ListTile(
          title: Text(task.title),
          trailing: Checkbox(
            value: task.isDone,
            onChanged: (value) => taskController.toggleTask(index),
          ),
        );
      },
    );
  }
}

class TaskInput extends StatelessWidget {
  final TaskController taskController;
  final TextEditingController textEditingController = TextEditingController();

  TaskInput({super.key, required this.taskController});

  void addTask() {
    final title = textEditingController.text;
    if (title.isNotEmpty) {
      taskController.addTask(title);
      textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(labelText: 'Add a new task'),
              onSubmitted: (_) => addTask(),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: addTask,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
