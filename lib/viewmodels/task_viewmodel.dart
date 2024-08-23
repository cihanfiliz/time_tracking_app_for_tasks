import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracking_app_for_tasks/models/section_model.dart';
import '../services/api_service.dart';
import '../models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _completedTasks = [];
  List<Section> _sections = [];
  
  // Focus on a single project for MVP; create ProjectViewModel if multi-project operations are needed.
  final String _projectId = "2337954165";

  final ApiService _apiService = ApiService();

  List<Task> get tasks => _tasks;
  List<Task> get completedTasks => _completedTasks;
  List<Section> get sections => _sections;

  TaskViewModel() {
    fetchTasks();
    loadTasks();
  }

  void moveTask(Task task, String newSectionId) {
    task.sectionId = newSectionId;
    notifyListeners();

    // Optionally, persist this change to a database or backend service
    // It is not possible to update section id with a single API call, todoist does not support it
  }

  Future<void> loadTasks() async {
    _completedTasks = await loadCompletedTasks();
    notifyListeners();
  }

  Future<void> markTaskAsCompleted(String taskId) async {
    try {
      var task = _tasks.firstWhere((task) => task.id == taskId);
      task.isCompleted = true;
      task.completedOn = DateTime.now().toString();

      // Save the task to local storage
      await _saveCompletedTask(task);
      _tasks.remove(task);
      notifyListeners();

      final value = await _apiService.closeTask(taskId);
      value ? null : throw Exception();
    } catch (e) {
      print('Error marking task as completed: $e');
    }
  }

  Future<void> _saveCompletedTask(Task task) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final prefsTasks = prefs.getString('completed_tasks');
      if (prefsTasks != null) {
        final jsonTasks = jsonDecode(prefsTasks);
        _completedTasks = List<Task>.from(jsonTasks.map((e) => Task.fromJson(e)));
        print('Tasks saved successfully.');
      }
      _completedTasks.add(task);
      await prefs.setString(
          'completed_tasks', jsonEncode(_completedTasks.map((task) => task.toJson()).toList()));
    } catch (e) {
      print('Error saving completed task: $e');
    }
  }

  Future<List<Task>> loadCompletedTasks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final prefsTasks = prefs.getString('completed_tasks');
      if (prefsTasks == null) {
        return [];
      }
      final jsonTasks = jsonDecode(prefsTasks);
      return List<Task>.from(jsonTasks.map((e) => Task.fromJson(e)));
    } catch (e) {
      print('Error reading completed tasks: $e');
      return [];
    }
  }

  void updateTaskTimeSpent(String id, Duration duration) {
    var task = _tasks.firstWhere((task) => task.id == id);
    if (task.timeSpent == null) {
      task.timeSpent = duration.toString();
    } else {
      final existingDuration = Duration(milliseconds: int.parse(task.timeSpent!));
      task.timeSpent = (existingDuration + duration).toString();
    }
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    try {
      _sections = await _apiService.getSections(_projectId);
      _tasks = await _apiService.getTasks(_projectId);
      notifyListeners();
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  Future<void> createTask(String content, String sectionId) async {
    try {
      final newTask = await _apiService.createTask(_projectId, sectionId, content);
      _tasks.add(newTask);
      notifyListeners();
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
