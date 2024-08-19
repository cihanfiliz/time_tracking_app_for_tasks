class Comment {
  final String id;
  final String taskId;
  final String content;
  final String postedAt;

  Comment({
    required this.id,
    required this.taskId,
    required this.content,
    required this.postedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      taskId: json['task_id'],
      content: json['content'],
      postedAt: json['posted_at'],
    );
  }
}
