import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app_for_tasks/models/task_model.dart';
import 'package:time_tracking_app_for_tasks/viewmodels/task_viewmodel.dart';
import 'package:time_tracking_app_for_tasks/views/comments_view.dart';
import 'package:time_tracking_app_for_tasks/views/task_timer.dart';

class KanbanColumn extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final String sectionId;
  final Function(Task task, String newSectionId) moveTask;
  final bool isFirstColumn;
  final bool isLastColumn;

  KanbanColumn({
    required this.title,
    required this.tasks,
    required this.sectionId,
    required this.moveTask,
    this.isFirstColumn = false,
    this.isLastColumn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  child: ListTile(
                    title: Text(task.content),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TaskTimer(
                          task: task,
                          onTimeTracked: (duration) {
                            // Save tracked time
                            
                          },
                        ),
                        Text(task.due?.date ?? ''),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentsView(taskId: task.id),
                              ),
                            );
                          },
                          child: Text('View/Add Comments'),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!isFirstColumn)
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              moveTask(task, getPreviousSectionId(context));
                            },
                          ),
                        if (!isLastColumn)
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
                              moveTask(task, getNextSectionId(context));
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String getPreviousSectionId(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    final currentIndex = taskViewModel.sections.indexWhere((section) => section.id == sectionId);
    return taskViewModel.sections[currentIndex - 1].id;
  }

  String getNextSectionId(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    final currentIndex = taskViewModel.sections.indexWhere((section) => section.id == sectionId);
    return taskViewModel.sections[currentIndex + 1].id;
  }
}
