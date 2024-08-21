import 'package:flutter/material.dart';
import 'package:time_tracking_app_for_tasks/models/section_model.dart';
import '../services/api_service.dart';
import '../models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Section> _sections = [];

  final ApiService _apiService = ApiService();

  List<Task> get tasks => _tasks;
  List<Section> get sections => _sections;

  Future<void> fetchTasks(String projectId) async {
    try {
      _sections = await _apiService.getSections(projectId);
      _tasks = await _apiService.getTasks(projectId);
      print(_sections.toString());
      notifyListeners();
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> createTask(String content, String projectId, String sectionId, String? dueString) async {
    try {
      await _apiService.createTask(projectId, sectionId, content, dueString);
    } catch (e) {
      print('Error creating task: $e');
    }
  }

  Future<Task> fetchTask(String id) async {
    return await _apiService.getTask(id);
  }

  Future<void> updateTask(String id, String? content) async {
    try {
      final updatedTask = await _apiService.updateTask(id, content);
      print("updated task: ${updatedTask.toString()}");
      int index = _tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        _tasks[index] = updatedTask;
      }
      notifyListeners();
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _apiService.deleteTask(id);
    } catch (e) {
      print('Error deleting task: $e');
    }
  }
}
