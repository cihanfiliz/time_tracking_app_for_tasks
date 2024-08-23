class Section {
  final String id;
  final String projectId;
  final String name;
  final int order;

  Section({
    required this.id,
    required this.projectId,
    required this.name,
    required this.order,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    // Check for missing or null values and throw ArgumentError
    if (json['id'] == null ||
        json['project_id'] == null ||
        json['name'] == null ||
        json['order'] == null) {
      throw ArgumentError('One or more required fields are missing or null');
    }

    return Section(
      id: json['id'],
      projectId: json['project_id'],
      name: json['name'],
      order: json['order'],
    );
  }

  @override
  String toString() {
    return 'Section(id: $id, projectId: $projectId, name: $name, order: $order)';
  }
}
