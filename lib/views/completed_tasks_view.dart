import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';

class CompletedTasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks History'),
      ),
      body: ListView.builder(
        itemCount: taskViewModel.tasks.where((task) => task.isCompleted).length,
        itemBuilder: (context, index) {
          final task = taskViewModel.tasks.where((task) => task.isCompleted).elementAt(index);
          return ListTile(
            title: Text(task.content),
            subtitle: Text('Completed on: ${task.due?.date}\nTime Spent: ${task.due?.datetime}'),
          );
        },
      ),
    );
  }
}
