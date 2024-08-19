import 'package:flutter/material.dart';
import '../viewmodels/task_viewmodel.dart';
import '../viewmodels/comment_viewmodel.dart';
import 'package:provider/provider.dart';

class TaskDetails extends StatelessWidget {
  final String taskId;

  TaskDetails(this.taskId);

  @override
  Widget build(BuildContext context) {
    return Consumer2<TaskViewModel, CommentViewModel>(
      builder: (context, taskViewModel, commentViewModel, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Task Details')),
          body: Column(
            children: <Widget>[
              // Display task details here
              // Display comments here
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Implement add comment logic
            },
            child: Icon(Icons.comment),
          ),
        );
      },
    );
  }
}
