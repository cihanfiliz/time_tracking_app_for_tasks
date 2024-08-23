import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app_for_tasks/viewmodels/task_viewmodel.dart';


class CompletedTasksView extends StatelessWidget {
  const CompletedTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks History'),
      ),
      body: Consumer<TaskViewModel>(
        builder: (BuildContext context, TaskViewModel taskViewModel, Widget? child) {
          if (taskViewModel.completedTasks.isEmpty) {
            return Center(child: Text('No completed tasks found'));
          }
          return ListView.builder(
            itemCount: taskViewModel.completedTasks.length,
            itemBuilder: (context, index) {
              final task = taskViewModel.completedTasks[index];
              return ListTile(
                title: Text(task.content),
                subtitle: Text('Completed on: ${task.completedOn}\nTime Spent: ${task.timeSpent} minutes'),
              );
            },
          );
        },
      ),
    );
  }
}
