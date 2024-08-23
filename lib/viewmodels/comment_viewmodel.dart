import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/comment_model.dart';

class CommentViewModel extends ChangeNotifier {
  List<Comment> _comments = [];
  final ApiService _apiService = ApiService();

  List<Comment> get comments => _comments;

  Future<void> fetchComments(String taskId) async {
    try {
      _comments = await _apiService.getComments(taskId);
      notifyListeners();
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  Future<void> addComment(String taskId, String content) async {
    try {
      final newComment =
          await _apiService.createComment(taskId, content, DateTime.now().toString());
      _comments.add(newComment);
      notifyListeners();
    } catch (e) {
      print('Error creating comment: $e');
    }
  }
}
