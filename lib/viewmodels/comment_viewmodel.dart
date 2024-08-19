import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/comment_model.dart';

class CommentViewModel extends ChangeNotifier {
  List<Comment> _comments = [];
  final ApiService _apiService = ApiService();

  List<Comment> get comments => _comments;

  Future<void> fetchComments(String taskId) async {
    final commentsJson = await _apiService.getComments(taskId);
    _comments = commentsJson.map((json) => Comment.fromJson(json as Map<String, dynamic>)).toList();
    notifyListeners();
  }

  Future<void> addComment(String taskId, String content) async {
    // Implement add comment logic
  }
}
