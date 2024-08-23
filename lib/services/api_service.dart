import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_tracking_app_for_tasks/models/comment_model.dart';
import 'package:time_tracking_app_for_tasks/models/project_model.dart';
import 'package:time_tracking_app_for_tasks/models/section_model.dart';
import 'package:time_tracking_app_for_tasks/models/task_model.dart';

const String token = '996a25fc901143f33b395af979f599cfa09b432a';

class ApiService {
  final String baseUrl = 'https://api.todoist.com/rest/v2';

  Future<List<Project>> getProjects() async {
    final response = await http.get(
      Uri.parse('$baseUrl/projects'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final projectsJson = json.decode(response.body);
    return List<Project>.from(projectsJson.map((json) => Project.fromJson(json)));
  }

  Future<Project> getProject(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/projects/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final projectJson = json.decode(response.body);
    return Project.fromJson(projectJson);
  }

  Future<Project> createProject(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/projects'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );
    final projectJson = json.decode(response.body);
    return Project.fromJson(projectJson);
  }

  Future<Project> updateProject(String id, String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/projects/$id'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );
    final projectJson = json.decode(response.body);
    return Project.fromJson(projectJson);
  }

  Future<void> deleteProject(String id) async {
    await http.delete(
      Uri.parse('$baseUrl/projects/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  // Add similar methods for tasks, sections, and comments.
  Future<List<Section>> getSections(String projectId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/sections?project_id=$projectId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final sectionsJson = json.decode(response.body);
    return List<Section>.from(sectionsJson.map((json) => Section.fromJson(json)));
  }

  Future<Section> getSection(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/sections/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return json.decode(response.body);
  }

  Future<Section> createSection(String projectId, String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sections'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({"project_id": projectId, "name": name}),
    );
    return json.decode(response.body);
  }

  Future<Section> updateSection(String id, String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sections/$id'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({'name': name}),
    );
    return json.decode(response.body);
  }

  Future<void> deleteSection(String id) async {
    await http.delete(
      Uri.parse('$baseUrl/projects/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<List<Task>> getTasks(String projectId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tasks?project_id=$projectId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final tasksJson = json.decode(response.body);
    return List<Task>.from(tasksJson.map((json) => Task.fromJson(json)));
  }

  Future<Task> getTask(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return json.decode(response.body);
  }

  Future<Task> createTask(
      String projectId, String sectionId, String content, String? dueString) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({
        "content": content,
        "due_string": dueString,
        "project_id": projectId,
        "section_id": sectionId
      }),
    );

    return Task.fromJson(json.decode(response.body));
  }

  Future<Task> updateTask(String id, String? content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({"content": content}),
    );

    return Task.fromJson(json.decode(response.body));
  }

  Future<void> deleteTask(String id) async {
    await http.delete(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }

  Future<List<Comment>> getComments(String taskId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments?task_id=$taskId'),
      headers: {'Authorization': 'Bearer $token'},
    );
    
    final commentsJson = json.decode(response.body);
    return List<Comment>.from(commentsJson.map((json) => Comment.fromJson(json)));
  }

  Future<Comment> getComment(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return json.decode(response.body);
  }

  Future<Comment> createComment(String taskId, String content, String postedAt) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({"task_id": taskId, "content": content, "posted_at": postedAt}),
    );

    final commentsJson = json.decode(response.body);
    return Comment.fromJson(commentsJson);
  }

  Future<Comment> updateComment(String id, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments/$id'),
      headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      body: json.encode({'content': content}),
    );
    return json.decode(response.body);
  }

  Future<void> deleteComment(String id) async {
    await http.delete(
      Uri.parse('$baseUrl/comments/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
