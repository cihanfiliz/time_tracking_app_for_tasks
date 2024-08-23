class Task {
  final String id;
  final String content;
  bool isCompleted;
  final String projectId;
  String sectionId;
  final int order;
  String? timeSpent;
  String? completedOn;

  Task({
    required this.id,
    required this.content,
    required this.isCompleted,
    required this.projectId,
    required this.sectionId,
    required this.order,
    this.timeSpent,
    this.completedOn,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      content: json['content'],
      isCompleted: json['is_completed'],
      projectId: json['project_id'],
      sectionId: json['section_id'],
      order: json['order'],
      timeSpent: json['time_spent'],
      completedOn: json['completed_on'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'is_completed': isCompleted,
      'project_id': projectId,
      'section_id': sectionId,
      'order': order,
      'time_spent': timeSpent,
      'completed_on': completedOn,
    };
  }

  @override
  String toString() {
    return 'Task(id: $id, content: $content, isCompleted: $isCompleted, projectId: $projectId, sectionId: $sectionId, order: $order, timeSpent: $timeSpent, completedOn: $completedOn)';
  }
}

