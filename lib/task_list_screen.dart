import 'package:flutter/material.dart';
import 'task.dart';
import 'task_item.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isEmpty) return;
    setState(() {
      _tasks.add(Task(name: _taskController.text));
      _taskController.clear();
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _clearAllTasks() {
    setState(() {
      _tasks.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Manager")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(labelText: 'Enter Task'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(onPressed: _addTask, child: Text("Add")),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _clearAllTasks,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("All Clear", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: _tasks[index],
                    onToggle: () => _toggleTaskCompletion(index),
                    onDelete: () => _removeTask(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
