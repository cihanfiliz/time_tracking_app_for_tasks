import 'package:flutter/material.dart';
import 'package:time_tracking_app_for_tasks/components/selected_task.dart';
import 'package:time_tracking_app_for_tasks/models/section_model.dart';
import 'package:time_tracking_app_for_tasks/models/task_model.dart';
import '../viewmodels/project_viewmodel.dart';
import '../viewmodels/task_viewmodel.dart';
import 'package:provider/provider.dart';

class KanbanBoard extends StatefulWidget {
  @override
  _KanbanBoardState createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  List<Task> todoTasks = [];
  List<Task> inProgressTasks = [];
  List<Task> doneTasks = [];

  Task? draggingTask;
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
                      todoTasks.add(task);
                    } else if (section.order == 2) {
                      inProgressTasks.add(task);
                    } else if (section.order == 3) {
                      doneTasks.add(task);
                    }
                  }
                }
              }
              return Row(
                children: [
                  buildColumn(taskViewModel.sections[0], todoTasks),
                  buildColumn(taskViewModel.sections[1], inProgressTasks),
                  buildColumn(taskViewModel.sections[2], doneTasks),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget buildColumn(Section section, List<Task> tasks) {
    return Expanded(
      child: DragTarget<String>(
        builder: (context, accepted, rejected) {
          return Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: Column(
              children: [
                Text(section.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Draggable<String>(
                        data: tasks[index].content,
                        onDragStarted: () {
                          //setState(() {
                          draggingTask = tasks[index];
                          originalIndex = index;
                          originalColumn = section.name;
                          taskDropped = false;
                          tasks.removeAt(index);
                          //});
                        },
                        feedback: Material(
                          child: SelectedTask(content: tasks[index].content),
                        ),
                        //childWhenDragging: Container(),
                        child: SelectedTask(content: tasks[index].content),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
        //onWillAccept: (data) => true,
        onAcceptWithDetails: (data) {
          try {
            //setState(() {
            taskDropped = true;
            if (originalColumn != section.name) {
              // Move to a different column
              print(
                  "draggingTask!.id: ${draggingTask!.id}, Moved to ${section.id}, original: $originalColumn");
              removeFromOriginalColumn();
              TaskViewModel().deleteTask(draggingTask!.id);
              TaskViewModel()
                  .createTask(draggingTask!.content, section.projectId, section.id, null);
              addToColumn(section.name);
            } else {
              // Snap to the same column's new position
              // tasks.removeAt(originalIndex!);
              // tasks.insert(originalIndex!, draggingTask!);
            }
            //});
          } catch (e) {
            print(e);
          }
        },
        onLeave: (data) {
          // print("hereeeeeee section name: ${section.name}, original: $originalColumn");
          // if (!taskDropped && draggingTask != null) {
          //   //setState(() {
          //     // Snap back to original column if not dropped in a new column
          //     addToColumn(originalColumn!);
          //   //});
          // }
        },
      ),
    );
  }

  void removeFromOriginalColumn() {
    if (originalColumn == 'To Do') {
      print("in to do");
      todoTasks.removeWhere((task) => task.id == draggingTask!.id);
    } else if (originalColumn == 'In Progress') {
      print("in in progress");
      inProgressTasks.removeWhere((task) => task.id == draggingTask!.id);
    } else if (originalColumn == 'Done') {
      print("in done");
      doneTasks.removeWhere((task) => task.id == draggingTask!.id);
    }
  }

  void addToColumn(String columnName) {
    if (columnName == 'To Do') {
      todoTasks.insert(originalIndex!, draggingTask!);
    } else if (columnName == 'In Progress') {
      inProgressTasks.insert(originalIndex!, draggingTask!);
    } else if (columnName == 'Done') {
      doneTasks.insert(originalIndex!, draggingTask!);
    }
  }
}
