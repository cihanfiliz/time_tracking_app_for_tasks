import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app_for_tasks/models/section_model.dart';
import 'package:time_tracking_app_for_tasks/models/task_model.dart';
import 'package:time_tracking_app_for_tasks/views/kanban_column.dart';
import '../viewmodels/task_viewmodel.dart';
import 'task_timer.dart';
import 'comments_view.dart';

class KanbanBoardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kanban Board'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Implement task creation dialog
            },
          ),
        ],
      ),
      body: taskViewModel.tasks.isEmpty
          ? Center(child: Text('No tasks found or Loading...'))
          : Row(
              children: [
                KanbanColumn(
                  title: 'To Do',
                  tasks: taskViewModel.tasks
                      .where((task) => task.sectionId == taskViewModel.sections[0].id)
                      .toList(),
                  sectionId: taskViewModel.sections[0].id,
                  moveTask: taskViewModel.moveTask,
                  isFirstColumn: true,
                ),
                KanbanColumn(
                  title: 'In Progress',
                  tasks: taskViewModel.tasks
                      .where((task) => task.sectionId == taskViewModel.sections[1].id)
                      .toList(),
                  sectionId: taskViewModel.sections[1].id,
                  moveTask: taskViewModel.moveTask,
                ),
                KanbanColumn(
                  title: 'Done',
                  tasks: taskViewModel.tasks
                      .where((task) => task.sectionId == taskViewModel.sections[2].id)
                      .toList(),
                  sectionId: taskViewModel.sections[2].id,
                  moveTask: taskViewModel.moveTask,
                  isLastColumn: true,
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    String taskContent = '';
    String selectedSectionId = taskViewModel.sections[0].id;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  taskContent = value;
                },
                decoration: InputDecoration(labelText: 'Task Content'),
              ),
              DropdownButton<String>(
                value: selectedSectionId,
                onChanged: (String? newValue) {
                  selectedSectionId = newValue!;
                },
                items: taskViewModel.sections.map<DropdownMenuItem<String>>((Section section) {
                  return DropdownMenuItem<String>(
                    value: section.id,
                    child: Text(section.name),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskContent.isNotEmpty) {
                  taskViewModel.createTask(taskContent, selectedSectionId, null);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add Task'),
            ),
          ],
        );
      },
    );
  }
}
