import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/project_model.dart';

class ProjectViewModel extends ChangeNotifier {
  List<Project> _projects = [];
  final ApiService _apiService = ApiService();

  List<Project> get projects => _projects;

  Future<void> fetchProjects() async {
    try {
      _projects = await _apiService.getProjects();
      notifyListeners();
    } catch (e) {
      print('Error fetching projects: $e');
    }
  }

  Future<void> createProject(String name) async {
    final project = await _apiService.createProject(name);
    _projects.add(project);
    notifyListeners();
  }

  

  // Add methods for update, delete, etc.
}
