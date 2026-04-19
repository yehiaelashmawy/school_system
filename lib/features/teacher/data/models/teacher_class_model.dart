class TeacherClassModel {
  final String oid;
  final String name;
  final String level;
  final String createdAt;
  final int studentsCount;
  final int sectionsCount;
  final List<TeacherStudentModel> students;

  TeacherClassModel({
    required this.oid,
    required this.name,
    required this.level,
    required this.createdAt,
    required this.studentsCount,
    required this.sectionsCount,
    this.students = const [],
  });

  factory TeacherClassModel.fromJson(Map<String, dynamic> json) {
    final studentsRaw = json['students'];
    return TeacherClassModel(
      oid: (json['oid'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      level: (json['level'] ?? '').toString(),
      createdAt: (json['createdAt'] ?? '').toString(),
      studentsCount: (json['studentsCount'] as num?)?.toInt() ?? 0,
      sectionsCount: (json['sectionsCount'] as num?)?.toInt() ?? 0,
      students: studentsRaw is List
          ? studentsRaw
                .whereType<Map>()
                .map(
                  (student) => TeacherStudentModel.fromJson(
                    student.cast<String, dynamic>(),
                  ),
                )
                .toList()
          : const [],
    );
  }
}

class TeacherStudentModel {
  final String oid;
  final String fullName;
  final String email;
  final String phone;

  const TeacherStudentModel({
    required this.oid,
    required this.fullName,
    required this.email,
    required this.phone,
  });

  factory TeacherStudentModel.fromJson(Map<String, dynamic> json) {
    return TeacherStudentModel(
      oid: (json['oid'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
    );
  }
}
