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
  final List<TeacherHomeworkModel> homeworks;
  final List<TeacherExamModel> exams;
  final TeacherAttendanceModel attendance;

  const TeacherStudentDetailsModel({
    this.lessons = const [],
    this.homeworks = const [],
    this.exams = const [],
    this.attendance = const TeacherAttendanceModel(),
  });

  factory TeacherStudentDetailsModel.fromJson(Map<String, dynamic> json) {
    final lessonsRaw = json['lessons'];
    final homeworksRaw = json['homeworks'];
    final examsRaw = json['exams'];
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
      homeworks: homeworksRaw is List
          ? homeworksRaw
                .whereType<Map>()
                .map(
                  (homework) => TeacherHomeworkModel.fromJson(
                    homework.cast<String, dynamic>(),
                  ),
                )
                .toList()
          : const [],
      exams: examsRaw is List
          ? examsRaw
                .whereType<Map>()
                .map(
                  (exam) => TeacherExamModel.fromJson(
                    exam.cast<String, dynamic>(),
                  ),
                )
                .toList()
          : const [],
      attendance: TeacherAttendanceModel.fromJson(
        (json['attendance'] as Map?)?.cast<String, dynamic>() ?? const {},
      ),
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

class TeacherHomeworkModel {
  final String oid;
  final String title;
  final String dueDate;
  final String status;
  final double? grade;

  const TeacherHomeworkModel({
    required this.oid,
    required this.title,
    required this.dueDate,
    required this.status,
    this.grade,
  });

  factory TeacherHomeworkModel.fromJson(Map<String, dynamic> json) {
    return TeacherHomeworkModel(
      oid: (json['oid'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      dueDate: (json['dueDate'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      grade: (json['grade'] as num?)?.toDouble(),
    );
  }
}

class TeacherExamModel {
  final String oid;
  final String name;
  final String date;
  final double? score;
  final double? grade;

  const TeacherExamModel({
    required this.oid,
    required this.name,
    required this.date,
    this.score,
    this.grade,
  });

  factory TeacherExamModel.fromJson(Map<String, dynamic> json) {
    return TeacherExamModel(
      oid: (json['oid'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      date: (json['date'] ?? '').toString(),
      score: (json['score'] as num?)?.toDouble(),
      grade: (json['grade'] as num?)?.toDouble(),
    );
  }
}

class TeacherAttendanceModel {
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final double attendancePercentage;
  final List<TeacherAttendanceRecordModel> recentRecords;

  const TeacherAttendanceModel({
    this.presentCount = 0,
    this.absentCount = 0,
    this.lateCount = 0,
    this.attendancePercentage = 0,
    this.recentRecords = const [],
  });

  factory TeacherAttendanceModel.fromJson(Map<String, dynamic> json) {
    final recordsRaw = json['recentRecords'];
    return TeacherAttendanceModel(
      presentCount: (json['presentCount'] as num?)?.toInt() ?? 0,
      absentCount: (json['absentCount'] as num?)?.toInt() ?? 0,
      lateCount: (json['lateCount'] as num?)?.toInt() ?? 0,
      attendancePercentage: (json['attendancePercentage'] as num?)?.toDouble() ?? 0,
      recentRecords: recordsRaw is List
          ? recordsRaw
                .whereType<Map>()
                .map(
                  (record) => TeacherAttendanceRecordModel.fromJson(
                    record.cast<String, dynamic>(),
                  ),
                )
                .toList()
          : const [],
    );
  }
}

class TeacherAttendanceRecordModel {
  final String date;
  final String status;
  final String remarks;

  const TeacherAttendanceRecordModel({
    required this.date,
    required this.status,
    required this.remarks,
  });

  factory TeacherAttendanceRecordModel.fromJson(Map<String, dynamic> json) {
    return TeacherAttendanceRecordModel(
      date: (json['date'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      remarks: (json['remarks'] ?? '').toString(),
    );
  }
}
