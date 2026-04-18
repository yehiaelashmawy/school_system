class TeacherClassModel {
  final String oid;
  final String name;
  final String level;
  final String createdAt;
  final int studentsCount;
  final int sectionsCount;

  TeacherClassModel({
    required this.oid,
    required this.name,
    required this.level,
    required this.createdAt,
    required this.studentsCount,
    required this.sectionsCount,
  });

  factory TeacherClassModel.fromJson(Map<String, dynamic> json) {
    return TeacherClassModel(
      oid: json['oid'] as String,
      name: json['name'] as String,
      level: json['level'] as String,
      createdAt: json['createdAt'] as String,
      studentsCount: json['studentsCount'] as int,
      sectionsCount: json['sectionsCount'] as int,
    );
  }
}
