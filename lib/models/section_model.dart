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
