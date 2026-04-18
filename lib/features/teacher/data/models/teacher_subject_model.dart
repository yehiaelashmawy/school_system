class SubjectTeacherModel {
  final String oid;
  final String fullName;
  final String email;

  SubjectTeacherModel({
    required this.oid,
    required this.fullName,
    required this.email,
  });

  factory SubjectTeacherModel.fromJson(Map<String, dynamic> json) {
    return SubjectTeacherModel(
      oid: json['oid'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
    );
  }
}

class TeacherSubjectModel {
  final String oid;
  final String name;
  final String code;
  final int teachersCount;
  final int activeClassesCount;
  final List<SubjectTeacherModel> teachers;

  TeacherSubjectModel({
    required this.oid,
    required this.name,
    required this.code,
    required this.teachersCount,
    required this.activeClassesCount,
    required this.teachers,
  });

  factory TeacherSubjectModel.fromJson(Map<String, dynamic> json) {
    return TeacherSubjectModel(
      oid: json['oid'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      teachersCount: json['teachersCount'] as int,
      activeClassesCount: json['activeClassesCount'] as int,
      teachers: (json['teachers'] as List?)
              ?.map((e) => SubjectTeacherModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
