import 'package:school_system/features/teacher/data/models/teacher_exam_model.dart';

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
  final String avatar;
  final TeacherStudentDetailsModel details;

  const TeacherStudentModel({
    required this.oid,
    required this.fullName,
    required this.email,
    required this.phone,
    this.avatar = '',
    this.details = const TeacherStudentDetailsModel(),
  });

  factory TeacherStudentModel.fromJson(Map<String, dynamic> json) {
    return TeacherStudentModel(
      oid: (json['oid'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),
      avatar: json['avatar']?.toString() ?? '',
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
                  (exam) =>
                      TeacherExamModel.fromJson(exam.cast<String, dynamic>()),
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
  final String description;
  final String date;
  final String startTime;
  final String endTime;
  final int duration;
  final String status;
  final String type;
  final String className;
  final String subjectName;
  final String teacherName;
  final int materialsCount;
  final int objectivesCount;
  final bool hasHomework;
  final LessonHomeworkModel? homework;
  final List<LessonObjectiveModel> objectives;
  final List<LessonMaterialModel> materials;
  final List<String>? resourceLinks;
  final String? teacherNotes;
  final String createdAt;
  final String? updatedAt;

  TeacherLessonModel({
    required this.oid,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.status,
    required this.type,
    required this.className,
    required this.subjectName,
    required this.teacherName,
    required this.materialsCount,
    required this.objectivesCount,
    required this.hasHomework,
    this.homework,
    required this.objectives,
    required this.materials,
    this.resourceLinks,
    this.teacherNotes,
    required this.createdAt,
    this.updatedAt,
  });

  factory TeacherLessonModel.fromJson(Map<String, dynamic> json) {
    return TeacherLessonModel(
      oid: (json['oid'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      date: (json['date'] ?? '').toString(),
      startTime: (json['startTime'] ?? '').toString(),
      endTime: (json['endTime'] ?? '').toString(),
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      status: (json['status'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      className: (json['className'] ?? '').toString(),
      subjectName: (json['subjectName'] ?? '').toString(),
      teacherName: (json['teacherName'] ?? '').toString(),
      materialsCount: (json['materialsCount'] as num?)?.toInt() ?? 0,
      objectivesCount: (json['objectivesCount'] as num?)?.toInt() ?? 0,
      hasHomework: json['hasHomework'] ?? false,
      homework: json['homework'] != null
          ? LessonHomeworkModel.fromJson(json['homework'])
          : null,
      objectives:
          (json['objectives'] as List?)
              ?.map((e) => LessonObjectiveModel.fromJson(e))
              .toList() ??
          [],
      materials:
          (json['materials'] as List?)
              ?.map((e) => LessonMaterialModel.fromJson(e))
              .toList() ??
          [],
      resourceLinks: (json['resourceLinks'] as List?)
          ?.map((e) => e.toString())
          .toList(),
      teacherNotes: json['teacherNotes']?.toString(),
      createdAt: (json['createdAt'] ?? '').toString(),
      updatedAt: json['updatedAt']?.toString(),
    );
  }
}

class LessonObjectiveModel {
  final String oid;
  final String description;
  final int order;

  LessonObjectiveModel({
    required this.oid,
    required this.description,
    required this.order,
  });

  factory LessonObjectiveModel.fromJson(Map<String, dynamic> json) {
    return LessonObjectiveModel(
      oid: json['oid'] ?? '',
      description: json['description'] ?? '',
      order: json['order'] ?? 0,
    );
  }
}

class LessonMaterialModel {
  final String? oid;
  final String name;
  final String fileUrl;
  final String fileType;
  final int fileSize;

  LessonMaterialModel({
    this.oid,
    required this.name,
    required this.fileUrl,
    required this.fileType,
    required this.fileSize,
  });

  factory LessonMaterialModel.fromJson(Map<String, dynamic> json) {
    return LessonMaterialModel(
      oid: json['oid'],
      name: json['name'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      fileType: json['fileType'] ?? '',
      fileSize: (json['fileSize'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fileUrl': fileUrl,
      'fileType': fileType,
      'fileSize': fileSize,
    };
  }
}

class LessonHomeworkModel {
  final String? title;
  final String? description;
  final String? dueDate;

  LessonHomeworkModel({this.title, this.description, this.dueDate});

  factory LessonHomeworkModel.fromJson(Map<String, dynamic> json) {
    return LessonHomeworkModel(
      title: json['title'],
      description: json['description'],
      dueDate: json['dueDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (dueDate != null) 'dueDate': dueDate,
    };
  }
}

class TeacherHomeworkModel {
  final String oid;
  final String title;
  final String dueDate;
  final String status;
  final double? grade;
  final String? description;
  final String? instructions;
  final String? assignedDate;
  final int? totalMarks;
  final String? submissionType;
  final bool? allowLateSubmissions;
  final bool? notifyParents;
  final String? className;
  final String? subjectName;
  final String? teacherName;
  final int? submittedCount;
  final int? totalStudents;
  final int? pendingCount;
  final int? gradedCount;
  final int? lateCount;
  final List<dynamic>? attachments;
  final List<LessonMaterialModel>? materials;

  const TeacherHomeworkModel({
    required this.oid,
    required this.title,
    required this.dueDate,
    required this.status,
    this.grade,
    this.description,
    this.instructions,
    this.assignedDate,
    this.totalMarks,
    this.submissionType,
    this.allowLateSubmissions,
    this.notifyParents,
    this.className,
    this.subjectName,
    this.teacherName,
    this.submittedCount,
    this.totalStudents,
    this.pendingCount,
    this.gradedCount,
    this.lateCount,
    this.attachments,
    this.materials,
  });

  factory TeacherHomeworkModel.fromJson(Map<String, dynamic> json) {
    return TeacherHomeworkModel(
      oid: (json['oid'] ?? json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      dueDate: (json['dueDate'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      grade: (json['grade'] as num?)?.toDouble(),
      description: json['description']?.toString(),
      instructions: json['instructions']?.toString(),
      assignedDate: json['assignedDate']?.toString(),
      totalMarks: (json['totalMarks'] as num?)?.toInt(),
      submissionType: json['submissionType']?.toString(),
      allowLateSubmissions: json['allowLateSubmissions'] as bool?,
      notifyParents: json['notifyParents'] as bool?,
      className: json['className']?.toString(),
      subjectName: json['subjectName']?.toString(),
      teacherName: json['teacherName']?.toString(),
      submittedCount: (json['submittedCount'] as num?)?.toInt(),
      totalStudents: (json['totalStudents'] as num?)?.toInt(),
      pendingCount: (json['pendingCount'] as num?)?.toInt(),
      gradedCount: (json['gradedCount'] as num?)?.toInt(),
      lateCount: (json['lateCount'] as num?)?.toInt(),
      attachments: json['attachments'] as List<dynamic>?,
      materials: (json['materials'] as List<dynamic>?)
          ?.map((e) => LessonMaterialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      attendancePercentage:
          (json['attendancePercentage'] as num?)?.toDouble() ?? 0,
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
