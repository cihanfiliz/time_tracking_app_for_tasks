import 'package:flutter/material.dart';
import 'package:time_tracking_app_for_tasks/models/section_model.dart';
import '../services/api_service.dart';
import '../models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Section> _sections = [];
  // List<String> _todoTasks = [];
  // List<String> _inProgressTasks = [];
  // List<String> _doneTasks = [];

  final ApiService _apiService = ApiService();

  List<Task> get tasks => _tasks;
  List<Section> get sections => _sections;
  // List<String> get todoTasks => _todoTasks;
  // List<String> get inProgressTasks => _inProgressTasks;
  // List<String> get doneTasks => _doneTasks;

  Future<void> fetchTasks(String projectId) async {
    try {
      _sections = await _apiService.getSections(projectId);
      _tasks = await _apiService.getTasks(projectId);
      print(_sections.toString());
      // _sections.map((section) {
      //   _tasks.map((task) {
      //     if (section.id == task.sectionId) {
      //       if (section.order == 1) {
      //         _todoTasks.add(task.content);
      //       } else if (section.order == 2) {
      //         _inProgressTasks.add(task.content);
      //       } else if (section.order == 3) {
      //         _doneTasks.add(task.content);
      //       }
      //     }
      //   });
      // });
      notifyListeners();
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> createTask(String content) async {
    // Implement creation logic
  }

  Future<void> updateTask(String id, String content) async {
    // Implement update logic
  }

  Future<void> deleteTask(String id) async {
    // Implement deletion logic
  }
}
