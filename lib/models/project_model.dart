class Project {
  final String id;
  final String name;
  final String color;
  final bool isFavorite;
  final String viewStyle;

  Project({
    required this.id,
    required this.name,
    required this.color,
    required this.isFavorite,
    required this.viewStyle,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      isFavorite: json['is_favorite'],
      viewStyle: json['view_style'],
    );
  }
}
