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
  final TeacherStudentDetailsModel details;

  const TeacherStudentModel({
    required this.oid,
    required this.fullName,
    required this.email,
    required this.phone,
    this.details = const TeacherStudentDetailsModel(),
  });

  factory TeacherStudentModel.fromJson(Map<String, dynamic> json) {
    return TeacherStudentModel(
      oid: (json['oid'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      details: TeacherStudentDetailsModel.fromJson(
        (json['details'] as Map?)?.cast<String, dynamic>() ?? const {},
      ),
    );
  }
}

class TeacherStudentDetailsModel {
  final List<TeacherLessonModel> lessons;

  const TeacherStudentDetailsModel({this.lessons = const []});

  factory TeacherStudentDetailsModel.fromJson(Map<String, dynamic> json) {
    final lessonsRaw = json['lessons'];
    return TeacherStudentDetailsModel(
      lessons: lessonsRaw is List
          ? lessonsRaw
                .whereType<Map>()
                .map(
                  (lesson) => TeacherLessonModel.fromJson(
                    lesson.cast<String, dynamic>(),
                  ),
                )
                .toList()
          : const [],
    );
  }
}

class TeacherLessonModel {
  final String oid;
  final String title;
  final String date;
  final String status;

  const TeacherLessonModel({
    required this.oid,
    required this.title,
    required this.date,
    required this.status,
  });

  factory TeacherLessonModel.fromJson(Map<String, dynamic> json) {
    return TeacherLessonModel(
      oid: (json['oid'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      date: (json['date'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
    );
  }
}
