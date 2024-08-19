import 'package:flutter/material.dart';
import '../viewmodels/project_viewmodel.dart';
import '../viewmodels/task_viewmodel.dart';
import 'package:provider/provider.dart';

class KanbanBoard extends StatefulWidget {
  @override
  _KanbanBoardState createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  List<String> todoTasks = [];
  List<String> inProgressTasks = [];
  List<String> doneTasks = [];

  String? draggingTask;
  int? originalIndex;
  String? originalColumn;
  bool taskDropped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kanban Board')),
      body: Consumer<ProjectViewModel>(
        builder: (context, projectViewModel, child) {
          if (projectViewModel.projects.isEmpty) {
            projectViewModel.fetchProjects();
            return Center(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Create Project"),
              ),
            );
          }
          return Consumer<TaskViewModel>(
            builder: (context, taskViewModel, child) {
              if (taskViewModel.tasks.isEmpty) {
                taskViewModel.fetchTasks(projectViewModel.projects[1].id);
                return const Center(child: CircularProgressIndicator());
              }
              for (var section in taskViewModel.sections) {
                debugPrint("section: ${section.toString()}");
                for (var task in taskViewModel.tasks) {
                  debugPrint("task: ${task.content}");
                  if (section.id == task.sectionId) {
                    if (section.order == 1) {
                      todoTasks.add(task.content);
                    } else if (section.order == 2) {
                      inProgressTasks.add(task.content);
                    } else if (section.order == 3) {
                      doneTasks.add(task.content);
                    }
                  }
                }
              }
              return Row(
                children: [
                  buildColumn('To Do', todoTasks),
                  buildColumn('In Progress', inProgressTasks),
                  buildColumn('Done', doneTasks),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget buildColumn(String title, List<String> tasks) {
    return Expanded(
      child: DragTarget<String>(
        builder: (context, accepted, rejected) {
          return Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: Column(
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Draggable<String>(
                        data: tasks[index],
                        onDragStarted: () {
                          setState(() {
                            draggingTask = tasks[index];
                            originalIndex = index;
                            originalColumn = title;
                            taskDropped = false;
                          });
                        },
                        feedback: Material(
                          child: Container(
                            width: 100,
                            padding: EdgeInsets.all(8.0),
                            color: Colors.blue,
                            child: Text(tasks[index], style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        childWhenDragging: Container(),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          padding: EdgeInsets.all(8.0),
                          color: Colors.blue,
                          child: Text(tasks[index], style: TextStyle(color: Colors.white)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        onWillAccept: (data) => true,
        onAccept: (data) {
          setState(() {
            taskDropped = true;
            if (originalColumn != title) {
              // Move to a different column
              tasks.add(data);
              removeFromOriginalColumn();
            } else {
              // Snap to the same column's new position
              tasks.removeAt(originalIndex!);
              tasks.insert(originalIndex!, draggingTask!);
            }
          });
        },
        onLeave: (data) {
          if (!taskDropped && draggingTask != null) {
            setState(() {
              // Snap back to original column if not dropped in a new column
              addToOriginalColumn();
            });
          }
        },
      ),
    );
  }

  void removeFromOriginalColumn() {
    if (originalColumn == 'To Do') {
      todoTasks.removeAt(originalIndex!);
    } else if (originalColumn == 'In Progress') {
      inProgressTasks.removeAt(originalIndex!);
    } else if (originalColumn == 'Done') {
      doneTasks.removeAt(originalIndex!);
    }
  }

  void addToOriginalColumn() {
    if (originalColumn == 'To Do') {
      todoTasks.insert(originalIndex!, draggingTask!);
    } else if (originalColumn == 'In Progress') {
      inProgressTasks.insert(originalIndex!, draggingTask!);
    } else if (originalColumn == 'Done') {
      doneTasks.insert(originalIndex!, draggingTask!);
    }
  }
}
