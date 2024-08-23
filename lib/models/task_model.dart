class Task {
  final String id;
  final String content;
  final bool isCompleted;
  final String projectId;
  String sectionId;
  final int order;
  final Due? due;

  Task({
    required this.id,
    required this.content,
    required this.isCompleted,
    required this.projectId,
    required this.sectionId,
    required this.order,
    this.due,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      content: json['content'],
      isCompleted: json['is_completed'],
      projectId: json['project_id'],
      sectionId: json['section_id'],
      order: json['order'],
      due: json['due'] != null ? Due.fromJson(json['due']) : null,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, content: $content, isCompleted: $isCompleted, projectId: $projectId, sectionId: $sectionId, due: ${due?.toString()}, order: $order)';
  }
}

class Due {
  final String date;
  final bool isRecurring;
  final String datetime;
  final String string;
  final String timezone;

  Due({
    required this.date,
    required this.isRecurring,
    required this.datetime,
    required this.string,
    required this.timezone,
  });

  factory Due.fromJson(Map<String, dynamic> json) {
    return Due(
      date: json['date'],
      isRecurring: json['is_recurring'],
      datetime: json['datetime'],
      string: json['string'],
      timezone: json['timezone'],
    );
  }

  @override
  String toString() {
    return 'Due(date: $date, isRecurring: $isRecurring, datetime: $datetime, string: $string, timezone: $timezone)';
  }
}
